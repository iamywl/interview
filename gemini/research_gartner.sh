#!/usr/bin/env bash
# =============================================================================
# research_gartner.sh — Gartner 5년치 IT 트렌드/뉴스 "년도 x 주제" 병렬 조사
#
# 기존 research.sh / review.sh 패턴을 그대로 차용:
#   - Vertex AI ADC 재사용 (하드코딩 금지)
#   - 작업 단위마다 전용 tmux 세션을 띄워 동시 실행
#   - gemini -m MODEL -p PROMPT 헤드리스 호출, 마크다운 본문만 출력
#
# 격자: 연도(2022..2026) x 주제(ai,cloud,security,data,platform,emerging)
#   = 30개 에이전트. 각 에이전트는 (연도,주제) 한 칸만 깊게 조사한다.
#   결과: gemini/<연도>/<주제>.md
#
# 사용법:
#   research_gartner.sh run            # 30칸 병렬 시작
#   research_gartner.sh status         # 진행/완료 현황
#   research_gartner.sh stop           # 모든 세션 종료
#   research_gartner.sh -1 <year> <topic_slug> <topic_label>   # 워커(내부용)
#
# 환경변수:
#   GEMINI_MODEL    기본 gemini-2.5-pro
#   MAX_CONCURRENT  동시 세션 상한 (기본 8, 0=무제한)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
OUT_ROOT="$(cd "$(dirname "$SELF")" && pwd)"   # = .../interview/gemini
PREFIX="gart_"

# --- Vertex AI 인증 (기존 ADC 재사용, 하드코딩 금지) ---
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"
MAX_CONCURRENT="${MAX_CONCURRENT:-18}"

YEARS=(2022 2023 2024 2025 2026)
# slug|한글 라벨  (PT 면접 주제 선정용 광범위 세분화 — 30주제 x 5년 = 150 에이전트)
TOPICS=(
  # --- AI ---
  "genai|생성형 AI·LLM·파운데이션 모델"
  "agentic|AI 에이전트·자율 에이전트·AI 어시스턴트"
  "aiops|AI 엔지니어링·MLOps·AI 운영"
  "multimodal|멀티모달 AI·컴퓨터비전·음성 AI"
  "slm|소형언어모델(SLM)·온디바이스 AI"
  "airegulation|AI 규제·거버넌스·AI 윤리"
  # --- Cloud / Infra ---
  "cloud|멀티/하이브리드 클라우드·클라우드 네이티브"
  "finops|FinOps·클라우드 비용 최적화"
  "edge|엣지 컴퓨팅·IoT"
  "network|5G/6G·차세대 네트워크"
  "datacenter|데이터센터·AI 인프라·GPU 수요"
  # --- Security ---
  "security|사이버보안 동향·위협 인텔리전스"
  "zerotrust|제로트러스트·네트워크 보안"
  "ransomware|랜섬웨어·공급망 보안"
  "identity|신원·접근관리(IAM)·인증"
  "pqc|양자내성암호(PQC)·암호 보안"
  # --- Data ---
  "data|데이터 패브릭·데이터 메시·데이터 거버넌스"
  "analytics|애널리틱스·BI·의사결정 인텔리전스"
  "realtime|실시간 데이터·스트리밍·이벤트 처리"
  # --- Dev / Platform ---
  "platform|플랫폼 엔지니어링·개발자 경험(DevEx)"
  "devsecops|DevOps·DevSecOps·CI/CD"
  "lowcode|로우코드/노코드·시민 개발자"
  "opensource|오픈소스·소프트웨어 공급망"
  # --- Emerging ---
  "quantum|양자컴퓨팅"
  "spatial|공간컴퓨팅·AR/VR·메타버스"
  "digitaltwin|디지털 트윈·시뮬레이션"
  "blockchain|블록체인·Web3·디지털 자산"
  "robotics|로보틱스·휴머노이드·자율주행"
  "sustainability|지속가능 기술·그린 IT·에너지 효율"
  "hyperautomation|하이퍼오토메이션·RPA·비즈니스 자동화"
)

die() { echo "오류: $*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# 프롬프트 생성 — (연도, 주제) 한 칸 전담
# -----------------------------------------------------------------------------
build_prompt() {
  local year="$1" topic_label="$2"
  cat <<EOP
당신은 IT 트렌드 분석가이자 취업 발표(PT) 면접 코치입니다. 결과물은 SSAFY(삼성 청년 SW
아카데미) 지원자가 **PT 면접에서 발표 주제로 선정**할 후보를 고르는 데 쓰입니다.
글쓰기에서 비유·유추를 쓰지 말고 직접적으로 기술하세요. 모든 본문은 한국어로 작성합니다
(고유명사·제품명·보고서명은 원문 유지).

[전제 — 웹 검색 없음]
- 웹 검색은 사용할 수 없습니다. 당신이 **학습한 지식**으로 작성하세요.
- 사실 기반으로 쓰되, 정확한 수치가 불확실하면 "대략/추정"이라고만 표기하고 자연스럽게
  서술합니다(과도한 '확인 필요' 남발은 하지 말 것). 실제로 있었던 보고서명/제품명/사건은
  최대한 구체적으로 적습니다.

[조사 범위 — 이 한 칸만 깊고 길게]
- 연도: ${year}년 / 주제: ${topic_label}
- ${year}년 전후로 이 주제에서 실제 일어난 흐름·사건·대표 제품·기업 동향·시장 전망을
  **분량을 최대한 길고 풍부하게** 정리합니다(짧게 끝내지 말 것, 항목마다 충분히 서술).

[반드시 포함 — 각 항목을 길게]
1. 그해 이 주제의 핵심 트렌드(Gartner 전략기술 트렌드/Hype Cycle 포함, 기억나는 범위에서).
2. 그해 대표 뉴스·사건·발표·제품·인수합병을 가능한 한 많이 나열(불릿으로 5개 이상).
3. 핵심 기업·제품·기술 키워드.
4. 시장 규모·도입률·성장률 등 기억나는 수치(추정 표기 가능).
5. 전년 대비 무엇이 새로 떠올랐고 무엇이 식었는지.

[PT 면접 주제화 — 가장 중요]
6. 이 주제를 PT 면접 발표 주제로 쓸 때의 **후보 발표 제목 3개**(끌리는 카피로).
7. 각 후보에 대해: 발표 한 줄 메시지 / 서론-본론-결론 3단 개요 / 예상 꼬리질문 2개와 답변 방향 /
   기술적 깊이를 보여줄 포인트 / 지원자가 엮을 수 있는 경험·프로젝트 각도.
8. 이 주제의 PT 적합도 평가: 난이도, 청중(면접관) 흥미도, 차별화 가능성을 각각 상/중/하로.

[작성 규칙]
- 마크다운 본문만 출력합니다(인사말·메타설명 없이 바로 본론).
- 분량은 길수록 좋습니다. 각 섹션을 풍부하게 채우세요.

[목차 — 그대로 사용]
## ${year} · ${topic_label}
### 1. 그해 핵심 트렌드
### 2. 대표 뉴스·사건 (불릿 5개 이상)
### 3. 핵심 기업·제품·기술 키워드
### 4. 시장 수치·전망
### 5. 전년 대비 변화점
### 6. PT 발표 주제 후보 (제목 3개)
### 7. 후보별 발표 설계 (메시지/3단개요/꼬리질문/깊이포인트/경험연결)
### 8. PT 적합도 평가 (난이도·흥미도·차별화)
EOP
}

# -----------------------------------------------------------------------------
# 워커: (연도, 주제) 한 칸 조사
#   인자: <year> <topic_slug> <topic_label>
# -----------------------------------------------------------------------------
research_one() {
  local year="$1" slug="$2" label="$3" dir out_file ts prompt
  dir="$OUT_ROOT/$year"
  mkdir -p "$dir"
  out_file="$dir/${slug}.md"
  ts="$(date +%Y%m%d-%H%M)"
  prompt="$(build_prompt "$year" "$label")"
  echo "[gartner] ${year}/${slug} -> $out_file" >&2
  {
    echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI/${GOOGLE_CLOUD_PROJECT}) -->"
    echo
    gemini -m "$MODEL" --skip-trust -y -p "$prompt" 2>/dev/null
  } > "$out_file"
  echo "[gartner] 완료: $out_file" >&2
}

# 동시 실행 상한 게이트
wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do
    local n
    n="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0
    sleep 3
  done
}

run_all() {
  echo "출력 루트: $OUT_ROOT"
  echo "모델: $MODEL | 동시상한: $( [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null && echo "$MAX_CONCURRENT" || echo 무제한 )"
  echo "격자: ${#YEARS[@]}연도 x ${#TOPICS[@]}주제 = $(( ${#YEARS[@]} * ${#TOPICS[@]} ))칸"
  echo
  local y t slug label sess q_label
  for y in "${YEARS[@]}"; do
    for t in "${TOPICS[@]}"; do
      slug="${t%%|*}"; label="${t#*|}"
      sess="${PREFIX}${y}_${slug}"
      wait_for_slot
      tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
      tmux new-session -d -s "$sess" -c "$OUT_ROOT"
      q_label="${label//\'/\'\\\'\'}"
      tmux send-keys -t "$sess" \
        "bash '$SELF' -1 '$y' '$slug' '$q_label'; tmux kill-session -t '$sess'" Enter
      printf '  ▶ %s/%s\n' "$y" "$slug"
    done
  done
  echo
  echo "현황: bash '$SELF' status   | 중단: bash '$SELF' stop"
}

show_status() {
  local active total done_cnt=0 expected
  active="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
  expected=$(( ${#YEARS[@]} * ${#TOPICS[@]} ))
  for y in "${YEARS[@]}"; do
    for t in "${TOPICS[@]}"; do
      slug="${t%%|*}"
      [ -s "$OUT_ROOT/$y/${slug}.md" ] && done_cnt=$((done_cnt+1))
    done
  done
  echo "활성 세션: ${active}개 | 완료 파일: ${done_cnt}/${expected}"
  for y in "${YEARS[@]}"; do
    printf '  %s: ' "$y"
    for t in "${TOPICS[@]}"; do
      slug="${t%%|*}"
      if [ -s "$OUT_ROOT/$y/${slug}.md" ]; then printf '%s✔ ' "$slug"; else printf '%s· ' "$slug"; fi
    done
    echo
  done
}

stop_all() {
  tmux ls 2>/dev/null | sed 's/:.*//' | grep "^${PREFIX}" | while read -r s; do
    tmux kill-session -t "$s" 2>/dev/null && echo "  종료: $s"
  done
  echo "모든 gartner 세션을 종료했습니다."
}

# -----------------------------------------------------------------------------
# 재시도: 본문이 비었거나(임계 미만) 누락된 셀만 다시 조사
#   임계: 파일 글자수 < MIN_CHARS (기본 1500)
# -----------------------------------------------------------------------------
retry_empty() {
  local min="${MIN_CHARS:-1500}" y t slug label sess f n=0
  echo "재시도 대상 탐색 (본문 < ${min}자 또는 없음), 동시상한 ${MAX_CONCURRENT}"
  for y in "${YEARS[@]}"; do
    for t in "${TOPICS[@]}"; do
      slug="${t%%|*}"; label="${t#*|}"
      f="$OUT_ROOT/$y/${slug}.md"
      if [ ! -f "$f" ] || [ "$(wc -m < "$f" 2>/dev/null || echo 0)" -lt "$min" ]; then
        sess="${PREFIX}${y}_${slug}"
        wait_for_slot
        tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
        tmux new-session -d -s "$sess" -c "$OUT_ROOT"
        local q_label="${label//\'/\'\\\'\'}"
        tmux send-keys -t "$sess" \
          "bash '$SELF' -1 '$y' '$slug' '$q_label'; tmux kill-session -t '$sess'" Enter
        n=$((n+1)); printf '  ↻ %s/%s\n' "$y" "$slug"
      fi
    done
  done
  echo "재시도 ${n}칸 투입 완료."
}

case "${1:-}" in
  run|"")  run_all ;;
  status)  show_status ;;
  stop)    stop_all ;;
  retry)   retry_empty ;;
  -1)      shift; research_one "$@" ;;
  *)       die "알 수 없는 명령: $1 (run|status|stop|retry)" ;;
esac
