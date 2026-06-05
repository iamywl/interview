#!/usr/bin/env bash
# =============================================================================
# enrich_research.sh — claude/research/<주제>/<연도>.md 를 Gemini 병렬로 보강
#
#   기존 deep_themes.sh 패턴 차용(Vertex ADC, tmux 병렬, 헤드리스 gemini).
#   목적: SSAFY PT면접 공부자료로서 부족한 부분을 Gemini가 보충한다.
#     - 기존 문서를 프롬프트에 그대로 넣고, 아래 신규 섹션을 추가해 "전체 문서 재출력".
#       ★ 신규 [신기술 개념 설명(쉽게)]  — 비전공자 눈높이 정의·동작원리
#       ★ 신규 [모범답안(완성형)]        — 외워 말하는 구어체 완성 답변(지원자 경험 연계)
#       ☆ 확장 [예상 꼬리질문]           — 7개 이상으로 늘림
#     - 기존 '대표 뉴스·사건' 출처 링크와 '참고문헌'은 절대 변경/삭제 금지(웹검색 불가 →
#       새 링크를 지어내지 말 것). 기존 사실·수치는 보존하며 설명만 보강.
#   결과: 같은 파일을 in-place 로 덮어씀(원본은 git 으로 복구 가능).
#
# 사용법:  enrich_research.sh run | status | retry | stop
#          enrich_research.sh -1 <file> <slug> <year> <label>   (워커, 내부용)
# 환경변수: GEMINI_MODEL(기본 gemini-2.5-pro), MAX_CONCURRENT(기본 6, 0=무제한)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
CROOT="$(cd "$(dirname "$SELF")" && pwd)"        # = .../interview/claude
RROOT="$CROOT/research"                           # = .../interview/claude/research
CTX="$(cd "$CROOT/.." && pwd)/gemini/_context.md" # 지원자 배경(재사용)
PREFIX="enr_"
MARK="한눈에 보기"                                # v2 보강 완료 판정용 마커(섹션1)

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
MAX_CONCURRENT="${MAX_CONCURRENT:-6}"

YEARS=(2021 2022 2023 2024 2025 2026)
# slug|라벨 (CLAUDE.md 의 16개 주제)
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

build_prompt() {  # <year> <label> <original_doc>
  local year="$1" label="$2" orig="$3" ctx=""
  [ -f "$CTX" ] && ctx="$(cat "$CTX")"
  cat <<EOP
당신은 SSAFY(삼성 청년 SW 아카데미) PT(발표)면접을 준비하는 지원자의 IT시사 공부자료를
보강하는 전문가입니다. 아래 [기존 문서]를 받아, 부족한 부분을 채워 **문서 전체를 다시
출력**합니다. 목적은 "최신 뉴스·이슈를 공부하고, 개념을 이해하고, 모범답안과 예상질문으로
면접을 준비"하는 것입니다.

[지원자 배경 — 모범답안과 꼬리질문에 자연스럽게 반영]
${ctx:-(배경 파일 없음 — 일반 SSAFY 지원자 기준)}

[절대 규칙 — 매우 중요]
- 웹 검색은 불가합니다. **새로운 출처 링크(URL)를 절대 지어내지 마세요.**
- [기존 문서]의 '대표 뉴스·사건' 항목의 사실·날짜·출처 링크, 그리고 '참고문헌' 링크 목록은
  **그대로 보존**합니다(문장 다듬기는 허용, 링크·수치·날짜 변경 금지). 기억나는 사실을 더
  보탤 수 있으나 출처가 불확실하면 링크 없이 서술하고 "추정/전망"으로 표기합니다.
- 한국어로 작성하고 비유·유추를 쓰지 않습니다. 면접에서 말로 할 수 있는 구어체를 씁니다.

[보강 지시 — 아래 v2 10목차를 '그대로' 사용해 문서 전체를 재구성해 출력]
## ${year} · ${label}
### 1. 한눈에 보기                 ★신규: 그해 그 주제의 핵심을 3~4줄로 압축.
### 2. 그해 핵심 트렌드            기존 유지·보강(불릿 4~6개).
### 3. 대표 뉴스·사건              기존 항목·출처 링크 그대로 보존(불릿 6개 이상, 각 끝에 매체·날짜·링크).
### 4. 신기술 개념설명             ★핵심: 그해 처음 등장/부상한 핵심 기술·용어 2~3개를 골라
   각 기술마다 네 가지를 직접 설명(비유 금지, 비전공 면접관도 이해하게):
   (1) 한 줄 정의 (2) 왜 나왔나(기존 방식의 한계) (3) 어떻게 동작하나(원리) (4) 무엇이 달라지나(의의·한계).
### 5. 핵심 기업·제품·기술 키워드  기존 유지·보강.
### 6. 시장 수치·전망              기존 유지, 미확정·전망치는 "전망/추정" 표기.
### 7. 전년 대비 변화점            새로 뜬 것 / 식은 것.
### 8. PT 발표 주제 후보           2~3개. 각: 제목 + 한 줄 메시지 + 발표 3단 구조(문제 → 근거 → 제언).
### 9. 예상 질문 + 모범답안        ★강화: 질문 4개 이상, 각 질문 아래 면접장에서 그대로 말할
   모범답안(3~6문장, 두괄식). 일부 답변에 지원자 경험(컨테이너 보안·syscall 동적관측 이상탐지·
   Linux 커널)을 자연스럽게 연계(과장·거짓 금지).
### 10. 참고문헌                   기존 링크 목록 그대로 보존.

마크다운 본문만 출력합니다(인사말·메타 설명 없이 '## ${year}' 부터 바로). 분량은 길수록 좋습니다.

[기존 문서]
${orig}
EOP
}

worker() {  # <file> <slug> <year> <label>
  local f="$1" slug="$2" year="$3" label="$4" orig tmp ts
  [ -f "$f" ] || { echo "[enr] 없음 건너뜀: $f" >&2; return 0; }
  orig="$(cat "$f")"; ts="$(date +%Y%m%d-%H%M)"
  tmp="$(mktemp "${TMPDIR:-/tmp}/enr_XXXXXX.md")"
  echo "[enr] ${slug}/${year}" >&2
  { echo "<!-- 보강:${ts} 모델:${MODEL} (Vertex AI) | 원본 뉴스·출처 보존 -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$year" "$label" "$orig")" 2>/dev/null
  } > "$tmp"
  # 보강 결과가 비정상(너무 짧거나 마커 없음)이면 원본 보존
  if [ "$(wc -m <"$tmp" 2>/dev/null||echo 0)" -ge 1500 ] && grep -q "$MARK" "$tmp"; then
    mv "$tmp" "$f"; echo "[enr] 완료: $f" >&2
  else
    rm -f "$tmp"; echo "[enr] 실패(원본 유지): $f" >&2
  fi
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

iterate() {  # run|retry
  local mode="$1" rec slug label year f sess n=0
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"; label="${rec#*|}"
    for year in "${YEARS[@]}"; do
      f="$RROOT/$slug/${year}.md"
      [ -f "$f" ] || continue
      if [ "$mode" = retry ]; then grep -q "$MARK" "$f" 2>/dev/null && continue; fi
      sess="${PREFIX}${slug}_${year}"
      wait_for_slot
      tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
      tmux new-session -d -s "$sess" -c "$CROOT"
      local qf="${f//\'/\'\\\'\'}" ql="${label//\'/\'\\\'\'}"
      tmux send-keys -t "$sess" "bash '$SELF' -1 '$qf' '$slug' '$year' '$ql'; tmux kill-session -t '$sess'" Enter
      n=$((n+1)); printf '  ▶ %s/%s\n' "$slug" "$year"
    done
  done
  echo "${mode}: ${n}칸 투입 (모델 $MODEL, 동시상한 $MAX_CONCURRENT)."
  echo "현황: bash '$SELF' status   재시도: bash '$SELF' retry   중단: bash '$SELF' stop"
}

status() {
  local tot=0 done=0 rec slug year f
  for rec in "${TOPICS[@]}"; do
    slug="${rec%%|*}"
    for year in "${YEARS[@]}"; do
      f="$RROOT/$slug/${year}.md"; [ -f "$f" ] || continue; tot=$((tot+1))
      grep -q "$MARK" "$f" 2>/dev/null && done=$((done+1))
    done
  done
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | 보강완료: ${done}/${tot}"
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
