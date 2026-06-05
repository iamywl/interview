#!/usr/bin/env bash
# =============================================================================
# pt_examples.sh — 주제/키워드별 "완전 실전형 PT 예시(발표 대본 포함)" 병렬 생성
#
#   기존 research_gartner.sh(30 Gartner 주제) + deep_themes.sh(7영역x세부주제) 패턴 차용.
#   두 그리드를 합쳐 순회하며 워커 1개당 PT 예시 1편을 생성한다.
#     - Gartner 30주제  -> gemini/pt_exam/examples/gartner/<slug>.md
#     - 심화 42세부주제 -> gemini/pt_exam/examples/deep/<area>/<sub>.md
#   각 문서는 주제선정→목차→슬라이드별 핵심→실제 발표 대본→예상 꼬리질문→지원자 경험연결.
#
# 사용법:  pt_examples.sh run | status | retry | stop
# 환경변수: GEMINI_MODEL(기본 gemini-2.5-pro), MAX_CONCURRENT(기본 6, 0=무제한)
#           MIN_CHARS(retry/status 충실 기준, 기본 2000)
# =============================================================================
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SELF")" && pwd)"   # = .../interview/gemini
OUT="$ROOT/pt_exam/examples"
CTX="$ROOT/_context.md"
PREFIX="ptx_"

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
MAX_CONCURRENT="${MAX_CONCURRENT:-6}"
MIN_CHARS="${MIN_CHARS:-2000}"

# --- 그리드 A: Gartner 30주제 (research_gartner.sh 의 TOPICS 그대로) ---
GARTNER=(
  "genai|생성형 AI·LLM·파운데이션 모델"
  "agentic|AI 에이전트·자율 에이전트·AI 어시스턴트"
  "aiops|AI 엔지니어링·MLOps·AI 운영"
  "multimodal|멀티모달 AI·컴퓨터비전·음성 AI"
  "slm|소형언어모델(SLM)·온디바이스 AI"
  "airegulation|AI 규제·거버넌스·AI 윤리"
  "cloud|멀티/하이브리드 클라우드·클라우드 네이티브"
  "finops|FinOps·클라우드 비용 최적화"
  "edge|엣지 컴퓨팅·IoT"
  "network|5G/6G·차세대 네트워크"
  "datacenter|데이터센터·AI 인프라·GPU 수요"
  "security|사이버보안 동향·위협 인텔리전스"
  "zerotrust|제로트러스트·네트워크 보안"
  "ransomware|랜섬웨어·공급망 보안"
  "identity|신원·접근관리(IAM)·인증"
  "pqc|양자내성암호(PQC)·암호 보안"
  "data|데이터 패브릭·데이터 메시·데이터 거버넌스"
  "analytics|애널리틱스·BI·의사결정 인텔리전스"
  "realtime|실시간 데이터·스트리밍·이벤트 처리"
  "platform|플랫폼 엔지니어링·개발자 경험(DevEx)"
  "devsecops|DevOps·DevSecOps·CI/CD"
  "lowcode|로우코드/노코드·시민 개발자"
  "opensource|오픈소스·소프트웨어 공급망"
  "quantum|양자컴퓨팅"
  "spatial|공간컴퓨팅·AR/VR·메타버스"
  "digitaltwin|디지털 트윈·시뮬레이션"
  "blockchain|블록체인·Web3·디지털 자산"
  "robotics|로보틱스·휴머노이드·자율주행"
  "sustainability|지속가능 기술·그린 IT·에너지 효율"
  "hyperautomation|하이퍼오토메이션·RPA·비즈니스 자동화"
)

# --- 그리드 B: 심화 7영역 x 세부주제 (deep_themes.sh 의 AREAS 그대로) ---
AREAS=(
"ai|인공지능|genai:생성형 AI·LLM/agent:AI 에이전트·에이전틱 AI/ondevice:온디바이스 AI·SLM/aiethics:AI 윤리·규제·거버넌스/aiinfra:AI 인프라·GPU·반도체/rag:RAG·검색증강생성"
"bigdata|빅데이터|dataeng:데이터 엔지니어링·파이프라인/streaming:실시간 스트리밍 처리/governance:데이터 거버넌스·품질/vectordb:벡터 데이터베이스/lakehouse:데이터 레이크하우스"
"blockchain|블록체인|defi:디파이(DeFi)/rwa:실물자산 토큰화(RWA)·NFT/stablecoin:스테이블코인·CBDC/chainsec:블록체인 보안·스마트컨트랙트 감사/l2:확장성·레이어2"
"fintech|핀테크|pay:간편결제·디지털지갑/mydata:마이데이터·오픈뱅킹/insurtech:인슈어테크/regtech:레그테크·이상거래탐지/embedded:임베디드 금융"
"mobility|모빌리티|ad:자율주행/uam:도심항공교통 UAM/ev:전기차·배터리/v2x:V2X·커넥티드카/mobplatform:모빌리티 플랫폼 MaaS"
"metaverse|메타버스·게임|engine:게임 엔진·실시간 렌더링/xr:XR·AR·VR 하드웨어/gameai:게임 AI·생성형 콘텐츠/blockchaingame:블록체인 게임·P2E/digitalhuman:디지털 휴먼·가상인간"
"cloud|클라우드|k8s:클라우드 네이티브·쿠버네티스/serverless:서버리스/multicloud:멀티·하이브리드 클라우드/cloudsec:클라우드 보안/edge:엣지 클라우드/finops:FinOps·비용최적화"
)

die() { echo "오류: $*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# 프롬프트 — 한 주제에 대한 완전 실전형 PT 예시(발표 대본 포함)
# -----------------------------------------------------------------------------
build_prompt() {
  local topic_label="$1" ctx=""
  [ -f "$CTX" ] && ctx="$(cat "$CTX")"
  cat <<EOP
당신은 SSAFY(삼성 청년 SW 아카데미) PT(발표)면접을 준비하는 지원자의 발표 코치입니다.
아래 주제로 **그대로 외워서 발표할 수 있는 완전한 실전 PT 예시 한 편**을 작성하세요.

[지원자 배경 — 발표·답변을 반드시 이 사람 기준으로 구체화]
${ctx:-(배경 파일 없음 — 일반 SSAFY 지원자 기준으로 작성)}

[발표 주제]
${topic_label}

[전제]
- 웹 검색 불가. 학습한 지식으로 사실 기반 작성, 불확실 수치는 "대략/추정"으로만 표기.
- 한국어. 비유·유추 금지, 직접적으로 기술. 발표 대본은 면접장에서 말로 하는 구어체.
- 분량은 충분히 길게(최소 3000자 이상). 각 섹션을 실하게 채웁니다.

[목차 — 아래 형식을 그대로 사용]
## (끌리는 발표 제목 1개)
### 0. 한 줄 핵심 메시지 / 발표 시간 배분(예: 총 3분 = 서론 30초·본론 2분·결론 30초)
### 1. 주제 선정 이유 (면접관의 흥미 포인트 + 지원자 강점과의 연결)
### 2. 발표 목차 (서론-본론-결론 한눈에)
### 3. 슬라이드별 핵심 내용 (슬라이드 5~7장, 각 장 제목 + 담을 핵심 bullet 3개 내외)
### 4. 실제 발표 대본 (처음부터 끝까지, 외워서 말하는 구어체 전체 스크립트)
### 5. 예상 꼬리질문 5개 + 답변 방향 (기술적 깊이가 드러나게, 각 2~3문장)
### 6. 지원자 경험 연결 (컨테이너 보안·syscall 동적 관측·Linux 커널·이상탐지 경험을 자연스럽게 엮는 멘트)
### 7. 발표 팁 / 흔한 함정 (이 주제 특유의 주의점)

마크다운 본문만 출력(인사말·메타설명 없이 바로 본론). 길게.
EOP
}

worker() {  # <out_file> <topic_label>
  local f="$1" label="$2" ts
  mkdir -p "$(dirname "$f")"; ts="$(date +%Y%m%d-%H%M)"
  echo "[ptx] $(basename "$(dirname "$f")")/$(basename "$f")" >&2
  { echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI / ${GOOGLE_CLOUD_PROJECT}) -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$label")" 2>/dev/null
  } > "$f"
  echo "[ptx] 완료: $f" >&2
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] 2>/dev/null || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

# (file, label, session) 형태로 전체 작업목록을 표준출력에 나열 (탭 구분)
enumerate() {
  local rec slug label
  for rec in "${GARTNER[@]}"; do
    slug="${rec%%|*}"; label="${rec#*|}"
    printf '%s\t%s\t%s\n' "$OUT/gartner/${slug}.md" "$label" "${PREFIX}g_${slug}"
  done
  local aslug alabel subs sub sslug slabel
  for rec in "${AREAS[@]}"; do
    aslug="${rec%%|*}"; rec="${rec#*|}"; alabel="${rec%%|*}"; subs="${rec#*|}"
    IFS='/' read -ra arr <<< "$subs"
    for sub in "${arr[@]}"; do
      sslug="${sub%%:*}"; slabel="${sub#*:}"
      printf '%s\t%s\t%s\n' "$OUT/deep/${aslug}/${sslug}.md" "${alabel} 분야 — ${slabel}" "${PREFIX}d_${aslug}_${sslug}"
    done
  done
}

iterate() {  # $1 = run|retry
  local mode="$1" f label sess n=0
  while IFS=$'\t' read -r f label sess; do
    if [ "$mode" = retry ]; then
      [ -f "$f" ] && [ "$(wc -m <"$f" 2>/dev/null||echo 0)" -ge "$MIN_CHARS" ] && continue
    fi
    wait_for_slot
    tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
    tmux new-session -d -s "$sess" -c "$ROOT"
    local qf="${f//\'/\'\\\'\'}" ql="${label//\'/\'\\\'\'}"
    tmux send-keys -t "$sess" "bash '$SELF' -1 '$qf' '$ql'; tmux kill-session -t '$sess'" Enter
    n=$((n+1)); printf '  ▶ %s\n' "${f#$OUT/}"
  done < <(enumerate)
  echo "${mode}: ${n}칸 투입 (모델 $MODEL, 동시상한 $MAX_CONCURRENT)."
  echo "현황: bash '$SELF' status   중단: bash '$SELF' stop"
}

status() {
  local tot=0 done=0 f label sess
  while IFS=$'\t' read -r f label sess; do
    tot=$((tot+1))
    [ -f "$f" ] && [ "$(wc -m <"$f" 2>/dev/null||echo 0)" -ge "$MIN_CHARS" ] && done=$((done+1))
  done < <(enumerate)
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | 충실(>${MIN_CHARS}자): ${done}/${tot}"
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
