#!/usr/bin/env bash
# =============================================================================
# study_docs.sh — claude/research/<주제>/STUDY.md 생성 (6년치 종합 학습문서)
#   CLAUDE.md §4-1 사양(A~H 목차). 주제 1개당 6개 연도 문서를 묶어 Gemini가 종합.
#   기존 enrich_research.sh / deep_themes.sh 패턴 차용(Vertex ADC, tmux 병렬, 헤드리스).
# 사용법:  study_docs.sh run | status | retry | stop | -1 <slug> <label>
# 환경변수: GEMINI_MODEL(기본 gemini-2.5-pro), MAX_CONCURRENT(기본 6)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
CROOT="$(cd "$(dirname "$SELF")" && pwd)"
RROOT="$CROOT/research"
CTX="$(cd "$CROOT/.." && pwd)/gemini/_context.md"
PREFIX="std_"
MARK="모범답안집"

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

die() { echo "오류: $*" >&2; exit 1; }

build_prompt() {  # <slug> <label> <combined_years>
  local slug="$1" label="$2" body="$3" ctx=""
  [ -f "$CTX" ] && ctx="$(cat "$CTX")"
  cat <<EOP
당신은 SSAFY(삼성 청년 SW 아카데미) PT(발표)면접 준비생의 학습 코치입니다.
아래 [연도별 자료(2021~2026)]를 종합해, 이 주제의 **메인 공부자료 STUDY.md** 한 편을 씁니다.
목적: 최신 IT 이슈 학습 + 개념 이해 + 모범답안·예상질문으로 PT면접 대비.

[지원자 배경 — F 섹션과 모범답안에 자연스럽게 반영]
${ctx:-(배경 파일 없음 — 일반 SSAFY 지원자 기준)}

[규칙]
- 웹 검색 불가: 새 출처 링크(URL)를 지어내지 마세요. 링크는 아래 자료에 이미 있는 것만 인용.
- 한국어, 비유·유추 금지, 직접 기술. 모범답안은 면접장에서 말하는 구어체 대본.
- 6년 흐름을 관통하는 큰 그림을 잡아주되, 중복은 압축하고 핵심만 진하게.

[목차 — 아래 A~H를 그대로 사용]
# ${label} — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가 (3줄)
## B. 반드시 아는 핵심 개념 사전
- 이 주제 면접 빈출 용어·기술 8개 이상. 각각 (1)정의 (2)왜 필요한가 (3)동작 원리 (4)의의/한계 로 설명.
## C. 연도별 흐름 한눈에 (2021 → 2026)
- 각 연도 한 줄 요약 + 연도파일 링크(예: [2024](./2024.md)).
## D. PT 발표 주제 추천 (3~5개)
- 각: 제목 / 핵심 메시지 / 발표 3단 구조(문제 → 근거 → 제언).
## E. 모범답안집
- 예상질문 8개 이상. 각 질문 아래 면접장 대본형 모범답안(3~6문장, 두괄식).
## F. 지원자 경험 연계 포인트
- 컨테이너 보안·시스템콜 동적관측 이상탐지·Linux 커널 경험을 이 주제와 잇는 멘트 모음.
## G. 빠른 암기 카드
- 핵심 수치·날짜·키워드를 표로 정리.
## H. 참고
- 연도파일 링크 목록 + 자료에 등장한 주요 출처.

마크다운 본문만 출력(인사말·메타 없이 '# ${label}' 부터 바로). 분량은 길게.

[연도별 자료(2021~2026)]
${body}
EOP
}

worker() {  # <slug> <label>
  local slug="$1" label="$2" dir f body="" y yf tmp ts
  dir="$RROOT/$slug"; f="$dir/STUDY.md"; ts="$(date +%Y%m%d-%H%M)"
  [ -d "$dir" ] || { echo "[std] 주제 없음: $slug" >&2; return 0; }
  for y in "${YEARS[@]}"; do
    yf="$dir/${y}.md"
    [ -f "$yf" ] && body+="$(printf '\n\n===== %s =====\n' "$y")$(cat "$yf")"
  done
  [ -n "$body" ] || { echo "[std] 연도자료 없음: $slug" >&2; return 0; }
  tmp="$(mktemp "${TMPDIR:-/tmp}/std_XXXXXX.md")"
  echo "[std] $slug" >&2
  { echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI) | 6년 종합 -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$slug" "$label" "$body")" 2>/dev/null
  } > "$tmp"
  if [ "$(wc -m <"$tmp" 2>/dev/null||echo 0)" -ge 1500 ] && grep -q "$MARK" "$tmp"; then
    mv "$tmp" "$f"; echo "[std] 완료: $f" >&2
  else
    rm -f "$tmp"; echo "[std] 실패: $slug" >&2
  fi
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

iterate() {  # run|retry
  local mode="$1" rec slug label f sess n=0
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"; label="${rec#*|}"; f="$RROOT/$slug/STUDY.md"
    [ -d "$RROOT/$slug" ] || continue
    if [ "$mode" = retry ]; then [ -f "$f" ] && grep -q "$MARK" "$f" 2>/dev/null && continue; fi
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
  local tot=0 done=0 rec slug f
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"; [ -d "$RROOT/$slug" ] || continue; tot=$((tot+1))
    f="$RROOT/$slug/STUDY.md"; [ -f "$f" ] && grep -q "$MARK" "$f" 2>/dev/null && done=$((done+1))
  done
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | STUDY 완료: ${done}/${tot}"
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
