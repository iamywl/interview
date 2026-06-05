#!/usr/bin/env bash
# =============================================================================
# review_all.sh — 저장소 전체(.md)를 Gemini로 병렬 리뷰하여 reviewedbygemini/ 에 저장
#
# 기존 research_gartner.sh / keyword_study.sh / novel review.sh 패턴 차용:
#   - Vertex AI ADC 재사용(자격증명 하드코딩 금지)
#   - 리뷰 대상 .md 1개당 전용 tmux 세션을 띄워 병렬 실행, 끝나면 세션 자동 종료
#   - gemini -m MODEL --approval-mode plan -p PROMPT 헤드리스 호출(읽기전용→파일 미생성)
#
# 동작:
#   대상 경로(기본=프로젝트 루트) 아래 모든 .md 를 순회하며, 각 문서를 Gemini가
#   "사실 정확성·최신성·누락·추가 조사 주제 제안·PT 발표 활용도" 관점으로 리뷰한다.
#   결과는 원본 트리 구조를 그대로 미러링해 reviewedbygemini/<상대경로> 에 저장한다.
#   예) gemini/2024/genai.md  →  reviewedbygemini/gemini/2024/genai.md
#
# 사용법:
#   review_all.sh                     # 프로젝트 전체 .md 병렬 리뷰
#   review_all.sh run [대상경로]      # 대상경로(폴더/파일)만 리뷰 (예: gemini/kw_study)
#   review_all.sh status              # 진행/완료 현황
#   review_all.sh stop                # 모든 리뷰 세션 종료
#   review_all.sh retry               # 빈/부실(<MIN_CHARS) 리뷰만 재실행
#   review_all.sh -1 <상대경로>       # 내부 워커(직접 호출 금지)
#
# 환경변수:
#   GEMINI_MODEL    기본 gemini-2.5-flash (대량 문서라 기본 flash; pro는 GEMINI_MODEL로)
#   MAX_CONCURRENT  동시 세션 상한 (기본 8, 0=무제한)
#   MIN_CHARS       retry/충실도 임계 글자수 (기본 1200)
#   FORCE           1이면 이미 리뷰된 문서도 다시 리뷰(기본 0=건너뜀)
#   MAX_SRC_CHARS   이보다 큰 원본은 건너뜀(토큰 보호, 기본 200000)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
PROJ_ROOT="$(cd "$(dirname "$SELF")/.." && pwd)"   # = .../interview
OUT="$PROJ_ROOT/reviewedbygemini"
PREFIX="grev_"

# --- Vertex AI 인증 (기존 ADC 재사용, 하드코딩 금지) ---
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true

MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"
MAX_CONCURRENT="${MAX_CONCURRENT:-8}"
MIN_CHARS="${MIN_CHARS:-1200}"
FORCE="${FORCE:-0}"
MAX_SRC_CHARS="${MAX_SRC_CHARS:-200000}"

die() { echo "오류: $*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# 리뷰 대상 .md 상대경로(프로젝트 루트 기준) 목록 출력
#   제외: .git, reviewedbygemini(자기 출력), 각종 메타/임시 파일
# -----------------------------------------------------------------------------
list_targets() {
  local base="$1"
  find "$base" -type f -name '*.md' \
    ! -path '*/.git/*' \
    ! -path "$OUT/*" \
    ! -name 'prompt.txt' \
    2>/dev/null | sed "s#^$PROJ_ROOT/##" | sort
}

# -----------------------------------------------------------------------------
# 리뷰 프롬프트
# -----------------------------------------------------------------------------
build_review_prompt() {
  local rel="$1"
  cat <<EOP
당신은 IT 기술 자료 팩트체커이자 SSAFY(삼성 청년 SW 아카데미) PT 면접 코치입니다.
아래에 마크다운 문서 1개("${rel}")가 주어집니다. 이 문서는 면접 준비용 조사/정리 자료입니다.
오늘은 2026년 기준입니다. 비판적이고 구체적으로 리뷰하세요.

[작성 규칙]
- 한국어. 비유·유추 금지, 직접적으로 기술.
- 모든 지적은 문서의 해당 위치/원문을 인용해 근거를 댄다. 칭찬만 나열하지 않는다.
- 리뷰 본문(마크다운)만 출력한다. 파일을 생성하거나 도구를 호출하지 말 것.

[리뷰 목차 — 그대로 사용]
## 0. 문서 요지 (3줄 이내)
## 1. 사실 정확성 점검
표로: | 위치 | 원문 주장 | 문제(오류/과장/근거부족) | 수정안 |  (문제 없으면 "발견되지 않음")
## 2. 최신성 점검 (2026년 기준 시점 어긋남, 오래된 수치·동향, 보강할 최신 사건)
## 3. 누락·보완 필요 (이 주제에서 빠진 핵심 개념·쟁점·수치)
## 4. 추가 조사 주제 제안 (이 자료를 보충할 새 조사 주제 5개)
각 주제: slug 형태 키워드 + 한 줄 이유. (이 문서가 다룬 깊이만큼 새로 파고들 주제)
## 5. PT 발표 활용도 (강점 / 약점 / 발표 시 주의점)
## 6. 종합 평가 (정확성·완성도·발표적합도 각각 상/중/하 + 한 줄 총평)

[리뷰 대상 문서 — 아래 코드블록 전체]
EOP
}

# -----------------------------------------------------------------------------
# 워커: 문서 1개 리뷰 (-1 <상대경로>)
# -----------------------------------------------------------------------------
worker() {
  local rel="$1" src out ts content prompt
  src="$PROJ_ROOT/$rel"
  out="$OUT/$rel"
  [ -f "$src" ] || die "원본 없음: $src"
  mkdir -p "$(dirname "$out")"
  ts="$(date +%Y%m%d-%H%M)"
  content="$(cat "$src")"
  prompt="$(build_review_prompt "$rel")
\`\`\`markdown
$content
\`\`\`"
  echo "[review] $rel" >&2
  {
    echo "<!-- 리뷰 생성:${ts} 모델:${MODEL} (Vertex AI/${GOOGLE_CLOUD_PROJECT}) -->"
    echo "<!-- 원본: ${rel} -->"
    echo
    gemini -m "$MODEL" --approval-mode plan -p "$prompt" 2>/dev/null
  } > "$out"
  echo "[review] 완료: $out" >&2
}

# 동시 실행 상한 게이트
wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  local n
  while :; do
    n="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0
    sleep 3
  done
}

# -----------------------------------------------------------------------------
# 실행: 대상 순회 → 세션 투입
# -----------------------------------------------------------------------------
run_all() {
  local base="${1:-$PROJ_ROOT}"
  base="$(cd "$(dirname "$base")" 2>/dev/null && pwd)/$(basename "$base")"
  [ -e "$base" ] || die "대상 경로 없음: $1"
  mkdir -p "$OUT"

  local i=0 launched=0 skipped=0 toobig=0 rel src out sz
  echo "대상 스캔: $base"
  echo "모델 $MODEL | 동시상한 $MAX_CONCURRENT | FORCE=$FORCE"
  while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    src="$PROJ_ROOT/$rel"; out="$OUT/$rel"
    # 너무 큰 원본은 토큰 보호를 위해 건너뜀
    sz="$(wc -m < "$src" 2>/dev/null || echo 0)"
    if [ "$sz" -gt "$MAX_SRC_CHARS" ] 2>/dev/null; then
      toobig=$((toobig+1)); printf '  ✖ 너무 큼(%s자) 건너뜀: %s\n' "$sz" "$rel"; continue
    fi
    # 이미 리뷰됐고 FORCE 아니면 건너뜀
    if [ "$FORCE" != "1" ] && [ -f "$out" ] && [ "$(wc -m < "$out" 2>/dev/null || echo 0)" -ge "$MIN_CHARS" ]; then
      skipped=$((skipped+1)); continue
    fi
    i=$((i+1))
    wait_for_slot
    local sess; sess="$(printf '%s%05d' "$PREFIX" "$i")"
    tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
    tmux new-session -d -s "$sess" -c "$PROJ_ROOT"
    local q="${rel//\'/\'\\\'\'}"
    tmux send-keys -t "$sess" "bash '$SELF' -1 '$q'; tmux kill-session -t '$sess'" Enter
    launched=$((launched+1)); printf '  ▶ %s\n' "$rel"
  done < <(list_targets "$base")

  echo
  echo "투입 ${launched}개 | 건너뜀(이미리뷰) ${skipped}개 | 큼제외 ${toobig}개"
  echo "현황:  bash '$SELF' status   | 중단:  bash '$SELF' stop"
  echo "결과:  $OUT/<상대경로>"
}

# -----------------------------------------------------------------------------
# retry: 없거나 MIN_CHARS 미만인 리뷰만 재실행 (대상=프로젝트 전체)
# -----------------------------------------------------------------------------
run_retry() {
  mkdir -p "$OUT"
  local i=0 n=0 rel src out sz
  echo "재시도: 리뷰 < ${MIN_CHARS}자 또는 없음 | 동시상한 $MAX_CONCURRENT"
  while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    src="$PROJ_ROOT/$rel"; out="$OUT/$rel"
    sz="$(wc -m < "$src" 2>/dev/null || echo 0)"
    [ "$sz" -gt "$MAX_SRC_CHARS" ] 2>/dev/null && continue
    if [ ! -f "$out" ] || [ "$(wc -m < "$out" 2>/dev/null || echo 0)" -lt "$MIN_CHARS" ]; then
      i=$((i+1)); wait_for_slot
      local sess; sess="$(printf '%s%05d' "$PREFIX" "$i")"
      tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
      tmux new-session -d -s "$sess" -c "$PROJ_ROOT"
      local q="${rel//\'/\'\\\'\'}"
      tmux send-keys -t "$sess" "bash '$SELF' -1 '$q'; tmux kill-session -t '$sess'" Enter
      n=$((n+1)); printf '  ↻ %s\n' "$rel"
    fi
  done < <(list_targets "$PROJ_ROOT")
  echo "재시도 ${n}개 투입."
}

# -----------------------------------------------------------------------------
# status / stop
# -----------------------------------------------------------------------------
show_status() {
  local active total done_cnt=0 rel out
  active="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
  total="$(list_targets "$PROJ_ROOT" | wc -l | tr -d ' ')"
  while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    out="$OUT/$rel"
    [ -f "$out" ] && [ "$(wc -m < "$out" 2>/dev/null || echo 0)" -ge "$MIN_CHARS" ] && done_cnt=$((done_cnt+1))
  done < <(list_targets "$PROJ_ROOT")
  echo "활성 세션: ${active}개 (prefix ${PREFIX})"
  echo "리뷰 완료(충실 >${MIN_CHARS}자): ${done_cnt}/${total}"
}

stop_all() {
  tmux ls 2>/dev/null | sed 's/:.*//' | grep "^${PREFIX}" \
    | xargs -r -n1 tmux kill-session -t 2>/dev/null || true
  echo "모든 review_all 세션(${PREFIX})을 종료했습니다."
}

# =============================================================================
# 엔트리포인트
# =============================================================================
case "${1:-run}" in
  run)      shift || true; run_all "${1:-$PROJ_ROOT}" ;;
  status)   show_status ;;
  stop)     stop_all ;;
  retry)    run_retry ;;
  -1)       shift; worker "$@" ;;
  -h|--help) sed -n '2,45p' "$SELF" | sed 's/^# \{0,1\}//' ;;
  *)        # 인자가 명령이 아니면 대상 경로로 간주
            run_all "$1" ;;
esac
