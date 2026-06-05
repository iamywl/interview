#!/usr/bin/env bash
# =============================================================================
# pt_exam_research.sh — SSAFY PT(발표)면접 "무엇을 요구하나 / 어떻게 답해야 하나" 병렬 조사
#
#   기존 research.sh / research_gartner.sh / deep_themes.sh 패턴 그대로 차용:
#     - Vertex AI ADC 재사용(하드코딩 금지)
#     - 조사 각도(시드) 1개당 전용 tmux 세션을 띄워 동시 실행
#     - gemini -m MODEL --skip-trust -y -p PROMPT 헤드리스 호출, 마크다운 본문만 출력
#
#   6개 각도(시드)를 각각 한 워커가 전담해 깊게 정리한다.
#     01 format          형식·절차·시간·진행방식
#     02 criteria        평가기준·면접관이 보는 역량
#     03 answer_structure 좋은 답변 구조(두괄식·논리·전달력)
#     04 followup        꼬리질문 대응 전략
#     05 cases           실전 후기·자주 나온 주제 유형
#     06 mistakes        흔한 실수·감점 요인 + 체크리스트
#   결과: gemini/pt_exam/research/<NN>_<slug>.md
#
# 사용법:  pt_exam_research.sh run | status | stop
# 환경변수: GEMINI_MODEL(기본 gemini-2.5-pro), MAX_CONCURRENT(기본 6, 0=무제한)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SELF")" && pwd)"   # = .../interview/gemini
OUT="$ROOT/pt_exam/research"
CTX="$ROOT/_context.md"
PREFIX="ptr_"

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
MAX_CONCURRENT="${MAX_CONCURRENT:-6}"

# NN|slug|조사 각도 라벨(전담 초점)
ANGLES=(
  "01|format|SSAFY PT(발표)면접의 형식·절차·진행방식: 발표 준비시간/발표시간/질의응답 구성, 자료(화이트보드·종이·PPT 등) 형태, 1:다 면접 흐름, 당일 동선"
  "02|criteria|평가 기준과 면접관이 실제로 보는 역량: 논리력·전달력·기술이해도·태도·성장가능성 등 항목별로, SSAFY가 표방하는 인재상과 연결"
  "03|answer_structure|좋은 PT 답변/발표의 구조: 두괄식, 서론-본론-결론 설계, 핵심메시지 1개로 좁히기, 시간배분, 시각자료 구성, 말하기 전달력 기법"
  "04|followup|발표 후 꼬리질문(압박질문 포함) 대응 전략: 모르는 것을 만났을 때, 근거를 요구받을 때, 반박당할 때 침착하게 답하는 프레임"
  "05|cases|실제 SSAFY PT면접 후기에서 반복되는 주제 유형과 출제 경향, 자주 나오는 질문 패턴, 합격/탈락을 가른 요인(일반화된 경향 위주, 과장 금지)"
  "06|mistakes|흔한 실수·감점 요인과 그 예방책: 시간초과, 암기 티, 동문서답, 근거부족, 자신감 부족 등 + 발표 직전 점검용 체크리스트"
)

die() { echo "오류: $*" >&2; exit 1; }

build_prompt() {
  local label="$1" ctx=""
  [ -f "$CTX" ] && ctx="$(cat "$CTX")"
  cat <<EOP
당신은 SSAFY(삼성 청년 SW 아카데미) 채용/면접을 잘 아는 취업 PT(발표)면접 코치입니다.
아래 한 가지 각도만 매우 깊고 길게, 실제 지원자가 바로 써먹을 수 있게 정리하세요.

[지원자 배경 — 답변·예시를 이 사람 기준으로 구체화]
${ctx:-(배경 파일 없음 — 일반 SSAFY 지원자 기준으로 작성)}

[전제]
- 웹 검색은 사용할 수 없습니다. 학습한 지식으로 작성하되, 사실 기반으로 씁니다.
  불확실한 디테일은 단정하지 말고 "일반적으로/대체로 알려진 바로는"처럼 자연스럽게 서술합니다.
- 한국어로 작성합니다. 비유·유추를 쓰지 말고 직접적으로 기술합니다.
- 면접장에서 실제로 적용 가능한 구체적 행동지침과 예시 문장을 풍부하게 넣습니다.

[이번 문서의 전담 각도 — 이 범위만 다룬다]
${label}

[포함할 것]
1. 이 각도의 핵심을 먼저 한 문단으로 요약(두괄식).
2. 구체적 항목별 상세 설명(각 항목 충분히 길게, 실제 예시 문장 포함).
3. 지원자가 바로 적용할 수 있는 행동지침·문장 템플릿.
4. 마지막에 "한눈에 보는 체크리스트"(불릿 6개 이상).

[작성 규칙]
- 마크다운 본문만 출력(인사말·메타설명 없이 바로 본론). 분량은 길수록 좋습니다.
EOP
}

worker() {  # <NN> <slug> <label>
  local nn="$1" slug="$2" label="$3" f ts
  mkdir -p "$OUT"; f="$OUT/${nn}_${slug}.md"; ts="$(date +%Y%m%d-%H%M)"
  echo "[ptr] ${nn}_${slug}" >&2
  { echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI / ${GOOGLE_CLOUD_PROJECT}) -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$label")" 2>/dev/null
  } > "$f"
  echo "[ptr] 완료: $f" >&2
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

run() {
  mkdir -p "$OUT"; local rec nn slug label sess n=0
  echo "출력: $OUT (모델 $MODEL, 동시상한 $MAX_CONCURRENT)"
  for rec in "${ANGLES[@]}"; do
    nn="${rec%%|*}"; rec="${rec#*|}"; slug="${rec%%|*}"; label="${rec#*|}"
    sess="${PREFIX}${nn}"
    wait_for_slot
    tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
    tmux new-session -d -s "$sess" -c "$ROOT"
    local ql="${label//\'/\'\\\'\'}"
    tmux send-keys -t "$sess" "bash '$SELF' -1 '$nn' '$slug' '$ql'; tmux kill-session -t '$sess'" Enter
    n=$((n+1)); printf '  ▶ %s_%s\n' "$nn" "$slug"
  done
  echo "투입: ${n}개.  현황: bash '$SELF' status   중단: bash '$SELF' stop"
}

status() {
  local tot=0 done=0 rec nn slug f
  for rec in "${ANGLES[@]}"; do
    nn="${rec%%|*}"; rec="${rec#*|}"; slug="${rec%%|*}"; tot=$((tot+1))
    f="$OUT/${nn}_${slug}.md"
    [ -f "$f" ] && [ "$(wc -m <"$f" 2>/dev/null||echo 0)" -ge 1500 ] && done=$((done+1))
  done
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | 충실(>1500자): ${done}/${tot}"
}

stop() { tmux ls 2>/dev/null|sed 's/:.*//'|grep "^${PREFIX}"|xargs -r -n1 tmux kill-session -t; echo stopped; }

case "${1:-run}" in
  run) run ;;
  status) status ;;
  stop) stop ;;
  -1) shift; worker "$@" ;;
  *) echo "run|status|stop" ;;
esac
