#!/usr/bin/env bash
# =============================================================================
# build_study.sh — claude/research/<주제>/STUDY.md 를 Gemini 병렬 생성
#   enrich_research.sh 패턴 차용(Vertex ADC, tmux 병렬, 헤드리스 gemini).
#   목적: 각 주제의 6년치(2021~2026) 보강 문서를 gemini가 종합해
#         PT면접 메인 공부자료(STUDY.md)로 재구성한다.
#         - 개념 사전 + 모범답안집 + 예상질문 + 발표주제 + 암기카드.
#         - 웹검색 불가 → 새 링크 지어내기 금지. 연도파일의 사실·출처만 활용.
# 사용법: build_study.sh run | status | retry | stop
#         build_study.sh -1 <slug> <label>   (워커, 내부용)
# 환경변수: GEMINI_MODEL(기본 gemini-2.5-pro), MAX_CONCURRENT(기본 6)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
CROOT="$(cd "$(dirname "$SELF")" && pwd)"
RROOT="$CROOT/research"
CTX="$(cd "$CROOT/.." && pwd)/gemini/_context.md"
PREFIX="std_"
MARK="모범답안집"      # gemini 출력 유효성 검증용(섹션 E 존재)
DONE="6년치 종합"     # 생성 완료 판정용(워커가 붙이는 헤더 마커)

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
MAX_CONCURRENT="${MAX_CONCURRENT:-6}"

YEARS=(2021 2022 2023 2024 2025 2026)
TOPICS=(
  "genai|생성형 AI · LLM · 파운데이션 모델"
  "agent|AI 에이전트 · 에이전틱 AI"
  "semiconductor|반도체 · HBM · AI 인프라"
  "cloud|클라우드 · 쿠버네티스 · DevOps"
  "security|보안 · 제로트러스트 · 랜섬웨어"
  "bigtech|빅테크 전략 · 동향(M&A · 실적 · 규제)"
  "emergingtech|신기술 · 양자컴퓨팅 · 차세대 컴퓨팅"
  "korea_it|한국 IT · 삼성(지원동기 연계)"
  "robotics|로봇 · 휴머노이드"
  "physical_ai|피지컬 AI · 임베디드 AI · 온디바이스"
  "data|데이터 · 빅데이터 · 벡터DB"
  "mobility|모빌리티 · 자율주행 · 전기차"
  "fintech|핀테크 · 블록체인 · 디지털자산"
  "ai_governance|AI 규제 · 거버넌스 · 윤리"
  "network|네트워크 · 엣지 · 6G"
  "opensource|오픈소스 · 개발자 생태계"
)

build_prompt() {  # <slug> <label>
  local slug="$1" label="$2" ctx="" y combined=""
  [ -f "$CTX" ] && ctx="$(cat "$CTX")"
  for y in "${YEARS[@]}"; do
    [ -f "$RROOT/$slug/$y.md" ] || continue
    combined="${combined}

===== [${y}.md] =====
$(cat "$RROOT/$slug/$y.md")"
  done
  cat <<EOP
당신은 SSAFY(삼성 청년 SW 아카데미) PT(발표)면접을 준비하는 지원자의 IT시사 공부자료를
만드는 전문가입니다. 아래 [연도별 문서들]은 "${label}" 주제의 2021~2026년 6개 파일입니다.
이 6년치를 **종합**해, 면접 직전에 보는 메인 공부자료 STUDY.md 한 편을 작성하세요.

[지원자 배경 — 모범답안과 경험 연계에 반영]
${ctx:-(배경 파일 없음 — 일반 SSAFY 지원자 기준)}

[절대 규칙]
- 웹 검색 불가. 새 출처 링크(URL)를 지어내지 마세요. 연도 문서에 있는 사실·수치·링크만 사용.
- 한국어, 비유·유추 금지, 면접에서 말로 할 수 있는 구어체.
- 분량은 길수록 좋습니다(깊고 풍부하게).

[출력 목차 — 아래 구조로 마크다운 본문만 출력]
# ${label} — SSAFY PT면접 학습문서
## A. 왜 이 주제가 중요한가 (3줄 요약)
## B. 반드시 아는 핵심 개념 사전 (빈출 용어·기술 8개 이상, 각: 정의 → 동작원리 → 면접 의의)
## C. 연도별 흐름 한눈에 (2021 → 2026, 각 연도 2~3줄 핵심 + 연도파일 상대링크 [2024](2024.md))
## D. PT 발표 주제 추천 (4개 이상, 각: 제목 / 핵심 메시지 / 발표 3단 구조(문제→근거→제언))
## E. 모범답안집 (예상질문 10개 이상 + 외워 말하는 완성형 답변, 일부는 지원자 경험 연계)
## F. 지원자 경험 연계 포인트 (컨테이너 보안·syscall 동적관측 이상탐지·Linux 커널을 이 주제와 잇는 멘트 모음)
## G. 빠른 암기 카드 (핵심 수치·날짜·키워드를 표 또는 불릿으로)
## H. 참고 (연도파일 링크 + 연도 문서에 등장한 주요 출처)

인사말·메타설명 없이 '# ${label}' 부터 바로 출력하세요.

[연도별 문서들]
${combined}
EOP
}

worker() {  # <slug> <label>
  local slug="$1" label="$2" out tmp ts
  out="$RROOT/$slug/STUDY.md"
  ts="$(date +%Y%m%d-%H%M)"
  tmp="$(mktemp "${TMPDIR:-/tmp}/std_XXXXXX.md")"
  echo "[std] ${slug}" >&2
  { echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI) | 6년치 종합 -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$slug" "$label")" 2>/dev/null
  } > "$tmp"
  if [ "$(wc -m <"$tmp" 2>/dev/null||echo 0)" -ge 1500 ] && grep -q "$MARK" "$tmp"; then
    mv "$tmp" "$out"; echo "[std] 완료: $out" >&2
  else
    rm -f "$tmp"; echo "[std] 실패(기존 유지): $out" >&2
  fi
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

iterate() {  # run|retry
  local mode="$1" rec slug label sess n=0 out
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"; label="${rec#*|}"; out="$RROOT/$slug/STUDY.md"
    if [ "$mode" = retry ]; then grep -q "$DONE" "$out" 2>/dev/null && continue; fi
    sess="${PREFIX}${slug}"
    wait_for_slot
    tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
    tmux new-session -d -s "$sess" -c "$CROOT"
    local ql="${label//\'/\'\\\'\'}"
    tmux send-keys -t "$sess" "bash '$SELF' -1 '$slug' '$ql'; tmux kill-session -t '$sess'" Enter
    n=$((n+1)); printf '  ▶ %s\n' "$slug"
  done
  echo "${mode}: ${n}개 투입 (모델 $MODEL, 동시상한 $MAX_CONCURRENT)."
  echo "현황: bash '$SELF' status   재시도: bash '$SELF' retry   중단: bash '$SELF' stop"
}

status() {
  local tot=0 done=0 rec slug out
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"; out="$RROOT/$slug/STUDY.md"; tot=$((tot+1))
    grep -q "$DONE" "$out" 2>/dev/null && done=$((done+1))
  done
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | STUDY완료: ${done}/${tot}"
}

stop() { tmux ls 2>/dev/null|sed 's/:.*//'|grep "^${PREFIX}"|xargs -r -n1 tmux kill-session -t; echo stopped; }

case "${1:-run}" in
  run) iterate run ;;
  retry) iterate retry ;;
  status) status ;;
  stop) stop ;;
  -1) shift; worker "$@" ;;
  *) echo "run|status|retry|stop" ;;
esac
