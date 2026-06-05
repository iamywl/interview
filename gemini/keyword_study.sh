#!/usr/bin/env bash
# =============================================================================
# keyword_study.sh — "키워드 발굴 → 키워드별 심화조사" 2단계 병렬 파이프라인
#
# 기존 research_gartner.sh / deep_themes.sh 패턴 차용:
#   - Vertex AI ADC 재사용(자격증명 하드코딩 금지)
#   - 작업 단위마다 전용 tmux 세션을 띄워 동시 실행, 끝나면 세션 자동 종료
#   - gemini -m MODEL --approval-mode plan -p PROMPT 헤드리스 호출
#     (plan=읽기전용 모드. pro 모델이 도구로 파일을 쓰지 않고 stdout로만 답하게 강제)
#
# 다른 스크립트와의 차이(핵심):
#   토픽 목록이 "고정"이 아니라, 1단계가 키워드를 발굴하고 그 개수(N 또는 M)에
#   맞춰 2단계가 키워드 1개당 에이전트 1개로 "동적 fan-out" 한다.
#
# 2단계 파이프라인:
#   [1단계 discover] 연도(2022~2026)마다 에이전트 1개 → 그해 핫했던 IT 키워드 발굴
#                    결과: kw_study/_discover/<연도>.md  (프로즈 + 기계판독 블록)
#   [merge]          모든 연도의 기계판독 블록을 파싱·slug 기준 dedup
#                    결과: kw_study/_keywords.txt        ("slug|한글라벨" 한 줄당 1키워드)
#   [2단계 study]    _keywords.txt를 읽어 키워드 1개당 에이전트 1개 → 심화조사
#                    결과: kw_study/keywords/<slug>.md
#                    (소개·개념·동작원리·장점·단점·한계점·수학개념·근거·PT발표설계)
#
# 사용법:
#   keyword_study.sh auto         # 완전 자동(논스톱): discover→(대기)→merge→study
#   keyword_study.sh discover     # 1단계만: 연도별 키워드 발굴
#   keyword_study.sh merge        # _discover/*.md → _keywords.txt 생성(dedup)
#   keyword_study.sh study        # 2단계만: _keywords.txt 기준 키워드별 fan-out
#   keyword_study.sh status       # 진행/완료 현황
#   keyword_study.sh stop         # 모든 세션(kwd_·kws_) 종료
#   keyword_study.sh retry        # 빈/부실(<MIN_CHARS) 키워드 문서만 재투입
#   keyword_study.sh -1 ...       # 내부 워커(직접 호출 금지)
#
# 환경변수:
#   GEMINI_MODEL    기본 gemini-2.5-pro
#   MAX_CONCURRENT  동시 세션 상한 (기본 8, 0=무제한)
#   YEARS           조사 연도(공백구분), 기본 "2022 2023 2024 2025 2026"
#   MAX_KEYWORDS    2단계 키워드 상한 (기본 0=무제한)
#   MIN_CHARS       retry/충실도 임계 글자수 (기본 3000)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SELF")" && pwd)"          # = .../interview/gemini
OUT="$ROOT/kw_study"
DISCOVER_DIR="$OUT/_discover"
KEYWORDS_FILE="$OUT/_keywords.txt"
KW_DIR="$OUT/keywords"
PRE_D="kwd_"     # 1단계(discover) 세션 prefix
PRE_S="kws_"     # 2단계(study) 세션 prefix

# --- Vertex AI 인증 (기존 ADC 재사용, 하드코딩 금지) ---
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true

MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
MAX_CONCURRENT="${MAX_CONCURRENT:-8}"
MAX_KEYWORDS="${MAX_KEYWORDS:-0}"
MIN_CHARS="${MIN_CHARS:-3000}"
read -ra YEARS <<< "${YEARS:-2022 2023 2024 2025 2026}"

CTX="$ROOT/_context.md"

die() { echo "오류: $*" >&2; exit 1; }

# slug 정규화: 영소문자/숫자/하이픈만 남김
norm_slug() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -e 's/[^a-z0-9-]/-/g' -e 's/-\{2,\}/-/g' -e 's/^-//' -e 's/-$//'
}

# 동시 실행 상한 게이트 (인자: 세션 prefix)
wait_for_slot() {
  local pre="$1" n
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do
    n="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${pre}" || true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0
    sleep 3
  done
}

# 공통: 세션에서 워커 실행 후 자동 종료
launch() {  # <prefix> <session_suffix> <worker args...>
  local pre="$1" suf="$2"; shift 2
  local sess="${pre}${suf}" q args=()
  for a in "$@"; do q="${a//\'/\'\\\'\'}"; args+=("'$q'"); done
  wait_for_slot "$pre"
  tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
  tmux new-session -d -s "$sess" -c "$ROOT"
  tmux send-keys -t "$sess" "bash '$SELF' -1 ${args[*]}; tmux kill-session -t '$sess'" Enter
}

# -----------------------------------------------------------------------------
# 1단계 프롬프트 — 한 해의 핫한 IT 키워드 발굴
# -----------------------------------------------------------------------------
build_discover_prompt() {
  local year="$1"
  cat <<EOP
당신은 IT 트렌드 분석가이자 취업 발표(PT) 면접 코치입니다. 결과물은 SSAFY(삼성 청년 SW
아카데미) 지원자가 **PT 면접 발표 주제 후보**를 고르는 데 쓰입니다. 비유·유추 없이
직접적으로 기술하고, 본문은 한국어로 작성합니다(고유명사·제품명·보고서명은 원문 유지).

[전제 — 웹 검색 없음]
- 웹 검색은 사용할 수 없습니다. 학습한 지식으로 작성하세요.
- 정확한 수치가 불확실하면 "추정"이라고만 표기하고 자연스럽게 서술합니다.

[작업 — ${year}년 한 해]
${year}년 한 해 동안 한국·글로벌에서 **핫했던 IT 이슈/기술 키워드**를 발굴하세요.
(Gartner 전략기술 트렌드/Hype Cycle, 대표 제품·사건·기업 동향을 기억나는 범위에서 반영.)
키워드는 PT 발표 주제로 쓸 만큼 구체적이어야 합니다(너무 광범위한 "AI" 대신 "생성형 AI",
"AI 에이전트"처럼 세분화).

[출력 — 두 부분]
1) 프로즈 본문: 그해 핵심 키워드 12~20개를 골라, 각 키워드마다 한 줄로 "왜 그해 떴는지"
   근거(대표 사건/제품/보고서명)를 적습니다.
2) 본문 마지막에 **기계판독 블록을 반드시** 아래 형식 그대로 출력합니다(다른 텍스트 금지):

<<<KEYWORDS
slug|한글라벨
slug|한글라벨
KEYWORDS>>>

- slug 규칙: 영소문자/숫자/하이픈만. 가능하면 통용 슬러그를 재사용하세요. 예시:
  genai(생성형 AI) · agentic(AI 에이전트) · multimodal(멀티모달) · slm(소형언어모델) ·
  rag(검색증강생성) · aiops(MLOps) · airegulation(AI 규제) · cloud(클라우드 네이티브) ·
  finops(클라우드 비용) · edge(엣지) · datacenter(AI 인프라/GPU) · zerotrust(제로트러스트) ·
  pqc(양자내성암호) · ransomware(랜섬웨어/공급망) · identity(IAM) · quantum(양자컴퓨팅) ·
  platform(플랫폼 엔지니어링) · devsecops(DevSecOps) · lowcode(로우코드) · vectordb(벡터DB) ·
  spatial(공간컴퓨팅/AR/VR) · digitaltwin(디지털 트윈) · robotics(로보틱스) · uam(UAM) 등.
- 그해와 무관한 키워드는 넣지 마세요. 블록에는 slug|라벨 줄만, 12~20줄.
- **절대 파일을 생성·저장하지 말 것. 어떤 도구도 호출하지 말 것. 전체 결과를 이 응답의
  텍스트(stdout)로만 직접 출력한다.** (파일에 쓰면 결과가 유실된다.)

[목차 — 그대로 사용]
## ${year} · 핫한 IT 키워드
### 1. 그해 큰 흐름 요약
### 2. 핵심 키워드와 근거 (불릿 12~20개, 각 1~2줄)
### 3. 전년 대비 새로 뜬 것 / 식은 것

(그리고 본문 맨 끝에 위 <<<KEYWORDS ... KEYWORDS>>> 블록)
EOP
}

# -----------------------------------------------------------------------------
# 2단계 프롬프트 — 키워드 1개 심화조사 (소개·장점·단점·한계·수학개념·근거)
# -----------------------------------------------------------------------------
build_study_prompt() {
  local slug="$1" label="$2"
  cat <<EOP
$( [ -s "$CTX" ] && cat "$CTX" )

[작업] IT PT 면접 심화 자료로 키워드 "[${label}]" (slug: ${slug}) 를 매우 깊고 길게
정리하라. SSAFY 지원자가 발표 주제로 선정·발표할 수 있도록 돕는 자료다.

[작성 규칙]
- 비유·유추 금지. 대학 1학년도 이해하도록 등장 개념·용어를 그 자리에서 정의(하향식).
- 2022~2026년 중심의 흐름(학습 지식 기반, 웹검색 불가, 불확실 수치는 "추정" 표기).
- **모든 장점·단점·한계 주장에는 근거(대표 사례·제품·기업·보고서명)를 함께 적는다.**
- 분량은 길수록 좋다. 각 섹션을 충분히 채운다.
- **절대 파일을 생성·저장하지 말 것. 어떤 도구도 호출하지 말 것. 보고서 전문을 이 응답의
  텍스트(stdout)로만 직접 출력한다.** (파일에 쓰면 결과가 유실된다.)

[목차 — 그대로 사용]
## ${label} (${slug})
### 1. 한 줄 정의와 큰 그림 (무엇을 푸는 기술/이슈인가, 왜 중요한가)
### 2. 핵심 개념·용어 정의 (하향식, 충분히 많이)
### 3. 동작 원리·구조 (단계별로 자세히)
### 4. 등장·부상 시점 (2022~2026 중 어느 해에 왜 떴는지, 연도별 흐름)
### 5. 장점 (근거: 대표 사례·제품·기업·보고서명 명시)
### 6. 단점·비용·리스크 (근거 명시)
### 7. 한계점·미해결 난제 (기술적/윤리적/규제)
### 8. 필요한 수학적·이론적 개념 (해당하면 수식 포함. 예: 어텐션 softmax(QKᵀ/√d)V,
       복잡도 O(n²), 확률·정보이론·암호학 기초 등 — 이 키워드에 맞는 것만)
### 9. PT 발표 주제화 (제목 후보 2~3개 / 서론-본론-결론 개요 / 예상 꼬리질문 3개+답변 방향)
### 10. 지원자 경험 연결 각도 (컨테이너 보안·커널·syscall 이상탐지·인프라 관점에서 엮는 법)
### 11. PT 적합도 평가 (난이도·흥미도·차별화 각각 상/중/하 + 이유)
EOP
}

# -----------------------------------------------------------------------------
# 워커 (-1 로 내부 호출)
#   discover <year>            → _discover/<year>.md
#   study <slug> <label>       → keywords/<slug>.md
# -----------------------------------------------------------------------------
worker_discover() {
  local year="$1" f ts
  mkdir -p "$DISCOVER_DIR"
  f="$DISCOVER_DIR/${year}.md"; ts="$(date +%Y%m%d-%H%M)"
  echo "[discover] ${year} -> $f" >&2
  {
    echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI/${GOOGLE_CLOUD_PROJECT}) -->"
    echo
    gemini -m "$MODEL" --approval-mode plan -p "$(build_discover_prompt "$year")" 2>/dev/null
  } > "$f"
  echo "[discover] 완료: $f" >&2
}

worker_study() {
  local slug="$1" label="$2" f ts
  mkdir -p "$KW_DIR"
  f="$KW_DIR/${slug}.md"; ts="$(date +%Y%m%d-%H%M)"
  echo "[study] ${slug} -> $f" >&2
  {
    echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI/${GOOGLE_CLOUD_PROJECT}) -->"
    echo
    gemini -m "$MODEL" --approval-mode plan -p "$(build_study_prompt "$slug" "$label")" 2>/dev/null
  } > "$f"
  echo "[study] 완료: $f" >&2
}

worker() {  # <kind> <args...>
  local kind="$1"; shift
  case "$kind" in
    discover) worker_discover "$@" ;;
    study)    worker_study "$@" ;;
    *)        die "알 수 없는 워커: $kind" ;;
  esac
}

# -----------------------------------------------------------------------------
# 1단계: 연도별 발굴 투입
# -----------------------------------------------------------------------------
run_discover() {
  mkdir -p "$DISCOVER_DIR"
  echo "1단계 발굴: ${#YEARS[@]}개 연도 (${YEARS[*]}) | 모델 $MODEL | 동시상한 $MAX_CONCURRENT"
  local y
  for y in "${YEARS[@]}"; do
    launch "$PRE_D" "$y" discover "$y"
    printf '  ▶ discover %s\n' "$y"
  done
  echo "완료 대기/현황:  bash '$SELF' status   | 중단:  bash '$SELF' stop"
}

# -----------------------------------------------------------------------------
# merge: 발굴 결과 → _keywords.txt (slug 기준 dedup)
# -----------------------------------------------------------------------------
run_merge() {
  [ -d "$DISCOVER_DIR" ] || die "발굴 결과가 없습니다. 먼저 discover 를 실행하세요."
  local tmp f raw slug label seen="" n=0
  tmp="$(mktemp)"
  for f in "$DISCOVER_DIR"/*.md; do
    [ -f "$f" ] || continue
    # <<<KEYWORDS ~ KEYWORDS>>> 사이의 slug|라벨 줄만 추출
    awk '/<<<KEYWORDS/{flag=1;next} /KEYWORDS>>>/{flag=0} flag' "$f"
  done | while IFS= read -r raw; do
    printf '%s\n' "$raw"
  done > "$tmp"

  : > "$KEYWORDS_FILE"
  while IFS='|' read -r slug label; do
    slug="$(norm_slug "${slug:-}")"
    label="$(printf '%s' "${label:-}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    [ -n "$slug" ] || continue
    [ -n "$label" ] || label="$slug"
    case " $seen " in *" $slug "*) continue ;; esac   # slug dedup(첫 등장 채택)
    seen="$seen $slug"
    printf '%s|%s\n' "$slug" "$label" >> "$KEYWORDS_FILE"
    n=$((n+1))
    if [ "$MAX_KEYWORDS" -gt 0 ] 2>/dev/null && [ "$n" -ge "$MAX_KEYWORDS" ]; then break; fi
  done < <(sort "$tmp")
  rm -f "$tmp"

  [ "$n" -gt 0 ] || die "키워드를 추출하지 못했습니다(기계판독 블록 확인 필요)."
  echo "merge 완료: ${n}개 키워드 → $KEYWORDS_FILE"
}

# -----------------------------------------------------------------------------
# 2단계: 키워드별 fan-out
# -----------------------------------------------------------------------------
run_study() {
  [ -s "$KEYWORDS_FILE" ] || die "키워드 파일이 없습니다. merge 를 먼저 실행하세요: $KEYWORDS_FILE"
  mkdir -p "$KW_DIR"
  local total slug label n=0
  total="$(grep -c '|' "$KEYWORDS_FILE" || echo 0)"
  echo "2단계 조사: ${total}개 키워드 fan-out | 모델 $MODEL | 동시상한 $MAX_CONCURRENT"
  while IFS='|' read -r slug label; do
    [ -n "$slug" ] || continue
    launch "$PRE_S" "$slug" study "$slug" "$label"
    n=$((n+1)); printf '  ▶ study %s\n' "$slug"
  done < "$KEYWORDS_FILE"
  echo "총 ${n}개 투입. 현황:  bash '$SELF' status"
}

# -----------------------------------------------------------------------------
# auto: 완전 자동(논스톱) — discover → (kwd_ 세션 종료 대기) → merge → study
# -----------------------------------------------------------------------------
run_auto() {
  run_discover
  echo "1단계 종료 대기 중..."
  while [ "$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PRE_D}" || true)" -gt 0 ]; do
    sleep 5
  done
  echo "1단계 완료. merge 진행."
  run_merge
  run_study
}

# -----------------------------------------------------------------------------
# retry: 없거나 MIN_CHARS 미만인 키워드 문서만 재투입
# -----------------------------------------------------------------------------
run_retry() {
  [ -s "$KEYWORDS_FILE" ] || die "키워드 파일이 없습니다: $KEYWORDS_FILE"
  local slug label f n=0
  echo "재시도: 본문 < ${MIN_CHARS}자 또는 없음 | 동시상한 $MAX_CONCURRENT"
  while IFS='|' read -r slug label; do
    [ -n "$slug" ] || continue
    f="$KW_DIR/${slug}.md"
    if [ ! -f "$f" ] || [ "$(wc -m < "$f" 2>/dev/null || echo 0)" -lt "$MIN_CHARS" ]; then
      launch "$PRE_S" "$slug" study "$slug" "$label"
      n=$((n+1)); printf '  ↻ %s\n' "$slug"
    fi
  done < "$KEYWORDS_FILE"
  echo "재시도 ${n}개 투입."
}

# -----------------------------------------------------------------------------
# status / stop
# -----------------------------------------------------------------------------
show_status() {
  local ad as kn=0 kdone=0 slug f
  ad="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PRE_D}" || true)"
  as="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PRE_S}" || true)"
  echo "활성 세션 — 발굴(${PRE_D}): ${ad}개 | 조사(${PRE_S}): ${as}개"
  if [ -d "$DISCOVER_DIR" ]; then
    echo "발굴 결과: $(find "$DISCOVER_DIR" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')/${#YEARS[@]}개 연도"
  fi
  if [ -s "$KEYWORDS_FILE" ]; then
    kn="$(grep -c '|' "$KEYWORDS_FILE" || echo 0)"
    while IFS='|' read -r slug _; do
      [ -n "$slug" ] || continue
      f="$KW_DIR/${slug}.md"
      [ -f "$f" ] && [ "$(wc -m < "$f" 2>/dev/null || echo 0)" -ge "$MIN_CHARS" ] && kdone=$((kdone+1))
    done < "$KEYWORDS_FILE"
    echo "키워드 문서(충실 >${MIN_CHARS}자): ${kdone}/${kn}"
  fi
}

stop_all() {
  tmux ls 2>/dev/null | sed 's/:.*//' | grep -E "^(${PRE_D}|${PRE_S})" \
    | xargs -r -n1 tmux kill-session -t 2>/dev/null || true
  echo "모든 keyword_study 세션(${PRE_D}·${PRE_S})을 종료했습니다."
}

# =============================================================================
# 엔트리포인트
# =============================================================================
case "${1:-auto}" in
  auto)     run_auto ;;
  discover) run_discover ;;
  merge)    run_merge ;;
  study)    run_study ;;
  retry)    run_retry ;;
  status)   show_status ;;
  stop)     stop_all ;;
  -1)       shift; worker "$@" ;;
  -h|--help) sed -n '2,57p' "$SELF" | sed 's/^# \{0,1\}//' ;;
  *)        die "알 수 없는 명령: $1 (auto|discover|merge|study|retry|status|stop)" ;;
esac
