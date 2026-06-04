#!/usr/bin/env bash
# =============================================================================
# deep_themes.sh — PT 영역별 세부주제 심화 조사 (영역 x 세부주제 그리드, 장문)
#   기존 research.sh 패턴 차용(Vertex ADC, tmux 병렬, 헤드리스).
#   출력: pt_themes_deep/<영역>/<세부주제>.md  (각 문서 8000자+ 목표)
# 사용법: deep_themes.sh run | status | stop | retry
# =============================================================================
set -euo pipefail
SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SELF")" && pwd)"
OUT="$ROOT/pt_themes_deep"
PREFIX="deep_"
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"
MAX_CONCURRENT="${MAX_CONCURRENT:-10}"

# 영역슬러그|영역명|세부주제(슬래시 구분, 각 항목 slug:라벨)
AREAS=(
"ai|인공지능|genai:생성형 AI·LLM/agent:AI 에이전트·에이전틱 AI/ondevice:온디바이스 AI·SLM/aiethics:AI 윤리·규제·거버넌스/aiinfra:AI 인프라·GPU·반도체/rag:RAG·검색증강생성"
"bigdata|빅데이터|dataeng:데이터 엔지니어링·파이프라인/streaming:실시간 스트리밍 처리/governance:데이터 거버넌스·품질/vectordb:벡터 데이터베이스/lakehouse:데이터 레이크하우스"
"blockchain|블록체인|defi:디파이(DeFi)/rwa:실물자산 토큰화(RWA)·NFT/stablecoin:스테이블코인·CBDC/chainsec:블록체인 보안·스마트컨트랙트 감사/l2:확장성·레이어2"
"fintech|핀테크|pay:간편결제·디지털지갑/mydata:마이데이터·오픈뱅킹/insurtech:인슈어테크/regtech:레그테크·이상거래탐지/embedded:임베디드 금융"
"mobility|모빌리티|ad:자율주행/uam:도심항공교통 UAM/ev:전기차·배터리/v2x:V2X·커넥티드카/mobplatform:모빌리티 플랫폼 MaaS"
"metaverse|메타버스·게임|engine:게임 엔진·실시간 렌더링/xr:XR·AR·VR 하드웨어/gameai:게임 AI·생성형 콘텐츠/blockchaingame:블록체인 게임·P2E/digitalhuman:디지털 휴먼·가상인간"
"cloud|클라우드|k8s:클라우드 네이티브·쿠버네티스/serverless:서버리스/multicloud:멀티·하이브리드 클라우드/cloudsec:클라우드 보안/edge:엣지 클라우드/finops:FinOps·비용최적화"
)

build_prompt() {
  local area="$1" sub="$2"
  cat <<EOP
[지원자 배경] 컨테이너 보안 연구 경험(시스템 콜 동적 관측 기반 이상탐지), Linux 커널 수준 이해,
풀스택·코딩테스트로 확장하려는 SSAFY 지원자. 발표(PT) 면접 주제 선정을 돕는 자료다.

[작업] IT PT 면접 심화 자료로 "${area} 분야 중 [${sub}]" 세부주제를 매우 깊고 길게 정리하라.
- 비유·유추 금지. 대학 1학년도 이해하도록 등장 개념·용어를 그 자리에서 정의. 하향식 설명.
- 2024~2026년 중심 최신 흐름(학습 지식 기반, 웹검색 불가, 불확실 수치는 '추정' 표기).
- 분량: 최소 8000자 이상. 각 섹션을 길고 상세하게. 구체적 사례·기업·제품·수치를 풍부하게.

[목차 — 그대로 사용]
## ${sub} (${area})
### 1. 개요와 큰 그림 — 무엇을 푸는가, 왜 지금 중요한가
### 2. 핵심 개념·용어 정의 (하향식, 1학년 수준, 충분히 많이)
### 3. 동작 원리·구조 (단계별로 자세히)
### 4. 2024~2026 핵심 트렌드·대표 사례·기업·제품 (불릿 8개 이상, 각 2~3문장)
### 5. 시장 규모·성장 전망 (추정 표기)
### 6. 기술적 쟁점·한계·윤리/규제 이슈
### 7. PT 발표 주제 후보 4개 (제목 + 한줄 메시지)
### 8. 후보별 발표 설계 (서론-본론-결론 / 예상 꼬리질문 3개+답변방향 / 깊이포인트)
### 9. 지원자 경험 연결 각도 (보안·커널·시스템콜·인프라 관점에서 엮는 법)
### 10. PT 적합도 평가 (난이도·흥미도·차별화 각각 상/중/하 + 이유)

마크다운 본문만 출력. 길게.
EOP
}

worker() {  # <area_slug> <area_label> <sub_slug> <sub_label>
  local aslug="$1" alabel="$2" sslug="$3" slabel="$4" dir f ts
  dir="$OUT/$aslug"; mkdir -p "$dir"; f="$dir/${sslug}.md"; ts="$(date +%Y%m%d-%H%M)"
  echo "[deep] $aslug/$sslug" >&2
  { echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI) -->"; echo
    gemini -m "$MODEL" --skip-trust -y -p "$(build_prompt "$alabel" "$slabel")" 2>/dev/null
  } > "$f"
  echo "[deep] 완료: $f" >&2
}

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] || return 0
  while :; do local n; n="$(tmux ls 2>/dev/null|sed 's/:.*//'|grep -c "^${PREFIX}"||true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 3; done
}

iterate() {  # $1=mode (run|retry)
  local mode="$1" rec aslug alabel subs sub sslug slabel f sess n=0 min="${MIN_CHARS:-3000}"
  for rec in "${AREAS[@]}"; do
    aslug="${rec%%|*}"; rec="${rec#*|}"; alabel="${rec%%|*}"; subs="${rec#*|}"
    IFS='/' read -ra arr <<< "$subs"
    for sub in "${arr[@]}"; do
      sslug="${sub%%:*}"; slabel="${sub#*:}"
      f="$OUT/$aslug/${sslug}.md"
      if [ "$mode" = retry ]; then
        [ -f "$f" ] && [ "$(wc -m < "$f" 2>/dev/null||echo 0)" -ge "$min" ] && continue
      fi
      sess="${PREFIX}${aslug}_${sslug}"
      wait_for_slot
      tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null||true
      tmux new-session -d -s "$sess" -c "$ROOT"
      local qa="${alabel//\'/\'\\\'\'}" qs="${slabel//\'/\'\\\'\'}"
      tmux send-keys -t "$sess" "bash '$SELF' -1 '$aslug' '$qa' '$sslug' '$qs'; tmux kill-session -t '$sess'" Enter
      n=$((n+1)); printf '  ▶ %s/%s\n' "$aslug" "$sslug"
    done
  done
  echo "${mode}: ${n}칸 투입."
}

status() {
  local tot=0 done=0 rec aslug rest subs sub sslug f
  for rec in "${AREAS[@]}"; do
    aslug="${rec%%|*}"; rest="${rec#*|}"; subs="${rest#*|}"
    IFS='/' read -ra arr <<< "$subs"
    for sub in "${arr[@]}"; do sslug="${sub%%:*}"; tot=$((tot+1))
      f="$OUT/$aslug/${sslug}.md"; [ -f "$f" ] && [ "$(wc -m <"$f")" -ge 3000 ] && done=$((done+1)); done
  done
  echo "활성: $(tmux ls 2>/dev/null|grep -c "^${PREFIX}"||echo 0) | 충실(>3000자): ${done}/${tot}"
}
stop() { tmux ls 2>/dev/null|sed 's/:.*//'|grep "^${PREFIX}"|xargs -r -n1 tmux kill-session -t; echo stopped; }

case "${1:-run}" in
  run) iterate run ;;
  retry) iterate retry ;;
  status) status ;;
  stop) stop ;;
  -1) shift; worker "$@" ;;
  *) echo "run|status|stop|retry" ;;
esac
