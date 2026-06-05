#!/usr/bin/env bash
# =============================================================================
# build_research.sh — SSAFY PT면접 학습자료 v2 병렬 생성 (gemini CLI)
#
# 개념(research.sh 방식):
#   16주제 × 6년(2021~2026) = 96개 연도셀 + 16개 STUDY.md + 16개 README + 루트 README.
#   각 산출물 1개당 gemini 워커 1개를 병렬로 띄운다. gemini는 "조사/재구성한
#   마크다운 본문만 stdout으로 출력"하고, 이 스크립트가 그 출력을 해당 경로에 저장한다.
#   (파일쓰기 도구 비신뢰 회피 — 출력 캡처 방식이 research.sh와 동일하게 안정적.)
#
#   기존 연도파일은 이미 실제 출처 URL이 달린 v1 자료다. 워커 프롬프트에 그 내용을
#   그대로 넣어 "검증된 출처는 보존 + v2 10목차로 재구성 + 신규 섹션(1 한눈에보기/
#   4 신기술 개념설명/9 모범답안) 추가"를 시킨다. 강제 웹검색은 quota 경합 시 hang
#   되므로 사용하지 않는다(도구호출 없이 즉시 생성 → 빠르고 안정적).
#
# 사용:
#   build_research.sh years      # 96개 연도셀 병렬 재작성
#   build_research.sh studies     # 16개 STUDY.md + 주제 README (연도파일 선행 필요)
#   build_research.sh root        # 루트 research/README.md
#   build_research.sh all         # years -> studies -> root 순차
#   build_research.sh status      # 진행 현황(파일 존재/줄수)
#   build_research.sh -1 <kind> <slug> <label> <year>   # 워커(내부용)
#
# 환경변수:
#   MAX_CONCURRENT  동시 워커 수 (기본 4 — 다른 gemini 작업과 quota 공존)
#   CALL_TIMEOUT    워커 1개 타임아웃 초 (기본 300)
#   GEMINI_MODEL    기본 gemini-2.5-flash
# =============================================================================
set -uo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="/home/ywlee/interview/claude/research"

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"
MAXC="${MAX_CONCURRENT:-4}"
CALL_TIMEOUT="${CALL_TIMEOUT:-300}"

YEARS=(2021 2022 2023 2024 2025 2026)

# slug|label (16개)
TOPICS=(
  "genai|생성형 AI · LLM · 파운데이션 모델"
  "agent|AI 에이전트 · 에이전틱 AI"
  "semiconductor|반도체 · HBM · AI 인프라"
  "cloud|클라우드 · 쿠버네티스 · DevOps"
  "security|보안 · 제로트러스트 · 랜섬웨어"
  "bigtech|빅테크 전략 · 동향(M&A · 실적 · 규제)"
  "emergingtech|신기술 · 양자컴퓨팅 · 차세대 컴퓨팅"
  "korea_it|한국 IT · 삼성 (지원동기 연계)"
  "robotics|로봇 · 휴머노이드"
  "physical_ai|피지컬 AI · 임베디드 AI · 온디바이스"
  "data|데이터 · 빅데이터 · 벡터DB"
  "mobility|모빌리티 · 자율주행 · 전기차"
  "fintech|핀테크 · 블록체인 · 디지털자산"
  "ai_governance|AI 규제 · 거버넌스 · 윤리"
  "network|네트워크 · 엣지 · 6G"
  "opensource|오픈소스 · 개발자 생태계"
)

APPLICANT="지원자 배경: 컨테이너 보안, 시스템 콜 동적 관측(eBPF/strace류) 기반 이상탐지, Linux 커널 이해를 가진 SSAFY 지원자. 풀스택·코딩테스트로 역량을 확장하려 함. 일부 모범답안에 이 배경을 자연스럽게 연계한다(억지 연결 금지)."

RULES="작성 규칙(필수):
- 한국어로 작성. 비유·유추 금지, 직접적으로 기술한다.
- 도구(웹검색·파일)를 호출하지 말고, 아래 제공된 기존 자료와 너의 지식만으로 즉시 작성한다.
- 대표 뉴스·사건의 각 항목 끝에는 (매체명, YYYY-MM-DD, 마크다운 링크) 형식 출처를 붙인다. 제공된 기존 자료의 실제 URL은 그대로 보존한다. 출처가 불확실하면 날짜·매체만 적고 추측 URL을 지어내지 않는다.
- 미확정·전망치는 본문에 '전망' 또는 '추정'으로 표기한다. 2026년은 진행 중이므로 상반기 사실 위주로 적고 나머지는 전망으로 명시한다.
- 마크다운 본문만 출력한다. 인사말·메타설명·코드펜스(\`\`\`) 없이 바로 '## '로 시작한다."

# -----------------------------------------------------------------------------
# 프롬프트 빌더
# -----------------------------------------------------------------------------
year_prompt() {
  local slug="$1" label="$2" year="$3" existing="$4"
  cat <<EOP
너는 SSAFY PT면접(발표면접) 대비 IT 시사 학습자료를 만드는 전문 리서처다.
주제 "${label}"(slug=${slug})의 ${year}년 자료를 아래 v2 10목차로 전면 재작성한다.
기존 자료보다 분량·깊이·실전성(개념설명·모범답안)을 모두 향상시킨다.

${APPLICANT}

${RULES}

[기존 자료 — 이 출처/사실을 보존·검증의 출발점으로 삼고 더 깊게 보강하라]
<<<EXISTING
${existing:-（기존 파일 없음: 너의 지식으로 ${year}년 ${label} 자료를 새로 작성하라）}
EXISTING

[아래 10목차를 정확히 이 제목/순서로 사용하라]
## ${year} · ${label}

### 1. 한눈에 보기
- 그해 그 주제의 핵심을 3~4줄로 압축.

### 2. 그해 핵심 트렌드
- 불릿 4~6개.

### 3. 대표 뉴스·사건
- 불릿 6개 이상. 각 항목 끝에 (매체·날짜·마크다운 링크) 출처 필수.

### 4. 신기술 개념설명
- 그해 처음 등장했거나 부상한 핵심 기술·용어 2~3개를 고른다.
- 각 기술마다 네 가지를 비전공 면접관도 이해하게 직접 설명한다(비유 금지):
  (1) 한 줄 정의  (2) 왜 나왔나(기존 방식의 한계)  (3) 어떻게 동작하나(원리)  (4) 무엇이 달라지나(의의·한계).

### 5. 핵심 기업·제품·기술 키워드

### 6. 시장 수치·전망
- 미확정·전망치는 '전망/추정' 표기.

### 7. 전년 대비 변화점
- 새로 뜬 것 / 식은 것.

### 8. PT 발표 주제 후보
- 2~3개. 각 항목: 제목 + 한 줄 메시지 + 발표 3단 구조(문제 → 근거 → 제언).

### 9. 예상 질문 + 모범답안
- 4개 이상. 각 질문에 면접장에서 그대로 말할 수 있는 대본형 모범답안(3~6문장).
- 일부 답변에 지원자 경험(컨테이너 보안·시스템콜 동적관측 이상탐지·Linux 커널)을 자연스럽게 연계.

### 10. 참고문헌
- 본문에서 인용한 출처 링크를 매체·날짜와 함께 목록으로 정리.
EOP
}

study_prompt() {
  local slug="$1" label="$2"
  # 연도파일은 argv 128KB 한도를 피하려고 @상대경로로 참조한다(gemini가 직접 읽음).
  # 이 워커는 /home/ywlee/interview 에서 실행되므로 claude/research/... 로 해석된다.
  local refs="" y
  for y in "${YEARS[@]}"; do refs+="@claude/research/${slug}/${y}.md "; done
  cat <<EOP
너는 SSAFY PT면접 대비 IT 시사 학습자료를 만드는 전문 리서처다.
주제 "${label}"(slug=${slug})의 6년치(2021~2026) 연도자료를 종합한 메인 공부자료 STUDY.md를 작성한다.

${APPLICANT}

${RULES}

[종합 대상 — 아래 6개 연도자료 파일을 모두 읽고 종합하라]
${refs}

[아래 목차를 정확히 이 제목/순서로 사용하라]
# ${label} — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
- 3줄로 핵심만.

## B. 반드시 아는 핵심 개념 사전
- 면접 빈출 용어·기술 6개 이상을 각각 정의 / 원리 / 의의로 설명(비유 금지, 비전공자도 이해하게).

## C. 연도별 흐름 한눈에
- 2021 → 2026 각 한 줄 요약 + 연도파일 상대링크([2024](2024.md) 형식).

## D. PT 발표 주제 추천
- 3~5개. 각: 제목 / 핵심 메시지 / 발표 3단 구조(문제 → 근거 → 제언).

## E. 모범답안집
- 예상질문 8개 이상 + 면접장에서 그대로 말할 대본형 모범답안. 일부는 지원자 경험 연계.

## F. 지원자 경험 연계 포인트
- 컨테이너 보안·시스템콜 이상탐지·커널을 이 주제와 잇는 멘트 모음(3~5개).

## G. 빠른 암기 카드
- 핵심 수치·날짜·키워드를 표로 정리.

## H. 참고
- 연도파일 링크(2021~2026.md) + 본문에서 쓴 주요 출처.

[매우 중요] A부터 H까지 8개 섹션을 빠짐없이 각각 "정확히 한 번씩만" 작성한다. H. 참고까지 끝내면 즉시 출력을 종료하고, 같은 문서를 두 번 반복 출력하지 않는다.
EOP
}

readme_prompt() {
  local slug="$1" label="$2"
  cat <<EOP
주제 "${label}"(slug=${slug}) 디렉토리의 README.md(연도별 인덱스)를 작성한다.
${RULES}

[구성]
# ${label}

한 문단으로 이 주제가 SSAFY PT면접에서 왜 중요한지 설명.

## 메인 공부자료
- [STUDY.md](STUDY.md) — 6년 종합 학습문서(개념사전·모범답안집·암기카드)

## 연도별 자료
- [2021](2021.md) — (한 줄 설명)
- [2022](2022.md) — (한 줄 설명)
- [2023](2023.md) — (한 줄 설명)
- [2024](2024.md) — (한 줄 설명)
- [2025](2025.md) — (한 줄 설명)
- [2026](2026.md) — (한 줄 설명, 진행중)

각 연도 한 줄 설명은 일반적 흐름 기준으로 적되 과장하지 않는다. 마크다운만 출력.
EOP
}

root_prompt() {
  local list="$1"
  cat <<EOP
SSAFY PT면접 학습자료의 루트 인덱스 research/README.md를 작성한다.
${RULES}

[구성]
# SSAFY PT면접 — IT 시사 학습자료

## 이 자료는
- 목적·구성·사용법을 한 문단으로. (주제별 디렉토리 → 연도별 파일 + STUDY.md 구조, 2021~2026, v2 10목차)

## 주제 인덱스 (16개)
아래 16개 주제를 표로 정리한다. 열: 번호 / 주제 / 핵심 / 바로가기([STUDY](slug/STUDY.md)).
${list}

## 면접 활용 가이드
- 발표 준비 순서를 단계로 제시: (1) STUDY.md 개념사전으로 용어 정리 → (2) 연도파일 3·4번으로 최신 뉴스·신기술 개념 흡수 → (3) 8번 발표주제 후보에서 PT 골격 잡기 → (4) 9번/E 모범답안으로 예상질문 대비.
- 빈출/추천 주제 3~4개를 콕 집어 추천.
- 지원자 배경(컨테이너 보안·시스템콜 이상탐지·커널)을 어떤 주제와 엮으면 좋은지 2~3개 제안.
마크다운만 출력.
EOP
}

# -----------------------------------------------------------------------------
# 워커: 출력 검증 후 저장
# -----------------------------------------------------------------------------
run_worker() {
  local kind="$1" slug="$2" label="$3" year="${4:-}"
  local dir="$ROOT/$slug" out prompt target tmp
  mkdir -p "$dir"

  case "$kind" in
    year)
      target="$dir/$year.md"
      prompt="$(year_prompt "$slug" "$label" "$year" "$(cat "$target" 2>/dev/null)")"
      ;;
    study)
      target="$dir/STUDY.md"
      cd /home/ywlee/interview || true   # @상대경로(claude/research/...) 해석 기준
      prompt="$(study_prompt "$slug" "$label")"
      ;;
    readme)
      target="$dir/README.md"
      prompt="$(readme_prompt "$slug" "$label")"
      ;;
    root)
      target="$ROOT/README.md"
      prompt="$(root_prompt "$label")"   # label로 list 전달
      ;;
    *) echo "[worker] unknown kind: $kind" >&2; return 2 ;;
  esac

  tmp="$(mktemp)"
  timeout "$CALL_TIMEOUT" gemini -m "$MODEL" -p "$prompt" >"$tmp" 2>/dev/null
  local rc=$?

  # 코드펜스 제거(혹시 ```markdown ... ``` 로 감싼 경우)
  sed -i '1{/^```/d}; ${/^```$/d}' "$tmp"

  # 검증: 비어있지 않고, 최소 줄수 이상, 헤딩으로 시작
  local lines first
  lines="$(wc -l < "$tmp")"
  first="$(head -1 "$tmp")"
  local minlines=25
  [ "$kind" = "readme" ] && minlines=8
  [ "$kind" = "root" ] && minlines=15

  if [ "$rc" -ne 0 ] && [ "$lines" -lt "$minlines" ]; then
    echo "[FAIL rc=$rc] $target (timeout/empty, ${lines}줄) — 기존 유지" >&2
    rm -f "$tmp"; return 1
  fi
  if [ "$lines" -lt "$minlines" ] || ! echo "$first" | grep -q '^#'; then
    echo "[FAIL] $target (검증실패 ${lines}줄, 시작='${first:0:30}') — 기존 유지" >&2
    rm -f "$tmp"; return 1
  fi

  mv "$tmp" "$target"
  echo "[OK] $target (${lines}줄)" >&2
  return 0
}

# -----------------------------------------------------------------------------
# 동시 실행 게이트
# -----------------------------------------------------------------------------
gate() { while [ "$(jobs -rp | wc -l)" -ge "$MAXC" ]; do wait -n 2>/dev/null || sleep 1; done; }

label_of() { local t; for t in "${TOPICS[@]}"; do [ "${t%%|*}" = "$1" ] && { echo "${t#*|}"; return; }; done; }

do_years() {
  echo ">> 연도셀 96개 병렬 재작성 (동시=$MAXC, 타임아웃=${CALL_TIMEOUT}s, 모델=$MODEL)"
  local t slug label y
  for t in "${TOPICS[@]}"; do
    slug="${t%%|*}"; label="${t#*|}"
    for y in "${YEARS[@]}"; do
      gate
      bash "$SELF" -1 year "$slug" "$label" "$y" &
    done
  done
  wait
  echo ">> 연도셀 완료"
}

do_studies() {
  echo ">> STUDY.md 16개 + 주제 README 16개 병렬 생성 (동시=$MAXC)"
  local t slug label
  for t in "${TOPICS[@]}"; do
    slug="${t%%|*}"; label="${t#*|}"
    gate; bash "$SELF" -1 study  "$slug" "$label" &
    gate; bash "$SELF" -1 readme "$slug" "$label" &
  done
  wait
  echo ">> STUDY/README 완료"
}

do_root() {
  echo ">> 루트 README 생성"
  # 주제 목록 텍스트를 label 인자로 실어 보낸다
  local list="" i=1 t slug label
  for t in "${TOPICS[@]}"; do
    slug="${t%%|*}"; label="${t#*|}"
    list+="${i}. ${slug} — ${label} (바로가기: ${slug}/STUDY.md , 연도: ${slug}/2021.md ~ ${slug}/2026.md)"$'\n'
    i=$((i+1))
  done
  bash "$SELF" -1 root "_root_" "$list"
}

show_status() {
  echo "주제 | 연도파일(채워진수/6) | STUDY | README"
  local t slug filled y st rm
  for t in "${TOPICS[@]}"; do
    slug="${t%%|*}"; filled=0
    for y in "${YEARS[@]}"; do
      [ "$(wc -l < "$ROOT/$slug/$y.md" 2>/dev/null || echo 0)" -ge 40 ] && filled=$((filled+1))
    done
    st="-"; [ -f "$ROOT/$slug/STUDY.md" ] && st="✓($(wc -l < "$ROOT/$slug/STUDY.md")줄)"
    rm="-"; [ -f "$ROOT/$slug/README.md" ] && rm="✓"
    printf '%-16s | %s/6 | %s | %s\n' "$slug" "$filled" "$st" "$rm"
  done
  echo "루트 README: $([ -f "$ROOT/README.md" ] && echo ✓ || echo -)"
}

case "${1:-}" in
  -1)       shift; run_worker "$@"; exit $? ;;
  years)    do_years ;;
  studies)  do_studies ;;
  root)     do_root ;;
  all)      do_years && do_studies && do_root ;;
  status)   show_status ;;
  *) sed -n '2,40p' "$SELF" | sed 's/^# \{0,1\}//'; exit 0 ;;
esac
