#!/usr/bin/env bash
# =============================================================================
# sh_gemini_research.sh
# 1. 작업 공간: sh_gemini/ 디렉토리
# 2. 파이프라인: [1차 에이전트: 초안 생성] -> [2차 에이전트: 검토 및 내용 보충]
# 3. 주제: 총 26개 (유해사이트 차단 기법, 인프라, 보안, eBPF, MES 등 포함)
# =============================================================================
set -euo pipefail

# --- 환경 설정 ---
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"

# 작업 디렉토리 설정
BASE_DIR="$PWD/sh_gemini"
RESEARCH_ROOT="$BASE_DIR/research"
GUIDE_MD="$BASE_DIR/GUIDE.md"
MAX_CONCURRENT=10
PREFIX="sg_"

# 26개 주제 정의 (요구사항 및 지원자 백그라운드 반영)
TOPICS=(
  "genai:생성형 AI, LLM, 파운데이션 모델"
  "agent:AI 에이전트, 자율형 AI"
  "semiconductor:반도체, HBM, AI 하드웨어 인프라"
  "cloud:클라우드 컴퓨팅, K8s, 컨테이너 오케스트레이션"
  "security:사이버 보안, 제로트러스트, 컨테이너 보안"
  "gov_censorship:정부 유해사이트 차단 기법 (SNI, DNS spoofing, DPI 등)" # 추가 요청 주제
  "observability:옵저버빌리티, eBPF 기반 모니터링, 트레이싱"
  "virtualization:가상화 기술, 경량 VM (Firecracker), 런타임"
  "barrier_free:배리어프리 IT, 디지털 접근성, UI/UX"
  "mes_smartfactory:MES, 스마트 팩토리, 제조 IT"
  "green_it:그린 IT, 데이터센터 전력 최적화, 액침냉각"
  "enterprise_arch:마이크로서비스(MSA), 이벤트 기반 아키텍처"
  "dbms:차세대 분산 데이터베이스, 벡터 DB"
  "api_ecosystem:API 게이트웨이, gRPC, API 보안"
  "bigtech:빅테크 전략 및 플랫폼 동향"
  "emergingtech:신기술, 양자 컴퓨팅"
  "korea_it:국내 IT 산업, 공공/대기업 클라우드 전환"
  "robotics:로봇 공학, 휴머노이드 제어"
  "physical_ai:피지컬 AI, 임베디드 AI, 온디바이스 AI"
  "data:빅데이터 파이프라인 처리 기술"
  "mobility:모빌리티, 자율주행 센서 및 데이터 처리"
  "fintech:핀테크, 블록체인 핵심 기술"
  "ai_governance:AI 규제, 데이터 프라이버시, 저작권"
  "network:차세대 네트워크, 엣지 컴퓨팅, 6G"
  "opensource:오픈소스 생태계, 라이선스 정책"
  "spatial_computing:공간 컴퓨팅, AR/XR 하드웨어"
)

YEARS=(2021 2022 2023 2024 2025 2026)

# 디렉토리 초기화 및 지침서(GUIDE.md) 생성
mkdir -p "$RESEARCH_ROOT"

cat << 'EOF' > "$GUIDE_MD"
# SSAFY PT 면접 대비 심층 조사 지침 (sh_gemini)

## 0. 기본 작성 원칙
- **언어:** 한국어.
- **문체:** 비유나 은유를 절대 사용하지 않고, 팩트와 엔지니어링 관점의 하드웨어/OS/네트워크 작동 원리로 서술한다.
- **예시 제한:** 예시 코드나 설명에 역사적 인물(예: 이순신 등) 사용을 금지하며 실무적인 네이밍을 사용한다. TCP는 연결 지향, IP는 비연결형 등 기본 네트워크 지식을 정확히 준수한다.

## 1. 문서 목차 (엄격 준수)
1. **핵심 기술 개념 (엔지니어링 관점):** 커널, 메모리 I/O, 패킷 처리 레벨에서의 동작 원리.
2. **연도별 주요 뉴스 및 IT 이슈:** 기사 출처 링크 `[매체명, YYYY-MM-DD](URL)` 5개 이상 필수.
3. **PT 면접 예상 주제 및 쟁점:** 아키텍처, 성능 오버헤드, 보안 취약점 등 쟁점 도출.
4. **PT 발표 모범 답안 스크립트:** 문제 정의 -> 기술적 아키텍처 해결책 -> 기대효과 (구체적 스택 명시).
5. **예상 꼬리질문 및 방어 논리:** 지원자의 백그라운드(C/Java/Python, 리눅스 시스템 콜, eBPF, 컨테이너 보안)와 연결한 기술적 답변 3가지.
6. **참고문헌:** 인용 링크 모음.
EOF

# 동시 실행 제어
wait_for_slot() {
  while :; do
    local n
    n="$(tmux ls 2>/dev/null | grep -c "^${PREFIX}" || true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0
    sleep 2
  done
}

# -----------------------------------------------------------------------------
# 1차 생성 및 2차 검토 에이전트 파이프라인
# -----------------------------------------------------------------------------
do_research_and_review() {
  local slug="$1"
  local desc="$2"
  local year="$3"
  local final_file="$4"
  local draft_file="${final_file}.draft"

  echo "[1차: 조사/초안생성] $slug - $year" >&2

  # --- 1차 에이전트: 초안 생성 ---
  local prompt_stage1
  prompt_stage1=$(cat <<EOF
당신은 최고 수준의 시니어 엔지니어입니다.
주제: $desc ($slug)
연도: $year년
아래 지침에 맞춰 마크다운 초안을 작성하세요.

[지침]
$(cat "$GUIDE_MD")
EOF
  )
  gemini -m "$MODEL" -p "$prompt_stage1" > "$draft_file" 2>/dev/null

  # --- 2차 에이전트: 내용 점검 및 보충 ---
  echo "[2차: 검토/내용보충] $slug - $year" >&2
  local prompt_stage2
  prompt_stage2=$(cat <<EOF
당신은 엄격한 SSAFY 테크니컬 면접관이자 아키텍트입니다.
아래는 다른 에이전트가 작성한 '$desc ($year년)' 관련 PT 면접 대비 자료 초안입니다.
이 초안을 검토하고 다음 사항을 **수정 및 대폭 보충**하여 최종 마크다운을 출력하세요.

1. **내용 보충:** 깊이가 얕은 부분을 찾아 실제 하드웨어 메커니즘, 메모리 구조, 네트워크 패킷 레벨, 리눅스 시스템 콜, 컨테이너 격리 레벨의 설명으로 보강하세요.
2. **비유 제거:** 은유적 표현(예: "마치 지휘자처럼", "도로망과 같은")이 있다면 즉시 삭제하고 기술적 팩트로 재작성하세요.
3. **PT 및 꼬리질문 강화:** 지원자의 강점(eBPF, 시스템 모니터링, 알고리즘 최적화, 컨테이너 보안)을 답변 논리에 강하게 연결하세요. 
4. **포맷팅 유지:** 초안의 1번~6번 목차 구조는 그대로 유지하세요.

[초안 내용]
$(cat "$draft_file")
EOF
  )
  gemini -m "$MODEL" -p "$prompt_stage2" > "$final_file" 2>/dev/null

  # 임시 초안 삭제
  rm -f "$draft_file"
  echo "[완료] $final_file" >&2
}

# 내부 워커 모드 실행
if [ "${1:-}" = "worker" ]; then
  shift
  do_research_and_review "$@"
  exit 0
fi

# =============================================================================
# 메인 루프: 병렬 작업 스케줄링
# =============================================================================
echo "총 ${#TOPICS[@]}개 주제 × ${#YEARS[@]}년 = $((${#TOPICS[@]} * ${#YEARS[@]}))개 파일 병렬 생성 & 리뷰 파이프라인 시작..."

echo "# SSAFY PT 면접 통합 자료 (sh_gemini, 2021-2026)" > "$RESEARCH_ROOT/README.md"

for item in "${TOPICS[@]}"; do
  slug="${item%%:*}"
  desc="${item##*:}"
  
  dir="$RESEARCH_ROOT/$slug"
  mkdir -p "$dir"
  echo "# $desc ($slug)" > "$dir/README.md"

  for year in "${YEARS[@]}"; do
    out_file="$dir/${year}.md"
    sess="${PREFIX}${slug}_${year}"
    
    if [ -s "$out_file" ]; then
      echo "스킵: $out_file (이미 존재함)"
      continue
    fi

    wait_for_slot
    
    tmux kill-session -t "$sess" 2>/dev/null || true
    
    tmux new-session -d -s "$sess"
    tmux send-keys -t "$sess" \
      "bash '$(realpath "$0")' worker '$slug' '$desc' '$year' '$out_file'; tmux kill-session -t '$sess'" Enter
      
    echo "  ▶ 작업 큐 등록: $slug ($year)"
  done
done

echo "=========================================================="
echo "모든 작업이 큐에 등록되었습니다. (작업 공간: $BASE_DIR)"
echo "각 파일은 [1차 초안 생성] -> [2차 검토 및 보충] 순으로 진행됩니다."
echo "진행 현황 확인: tmux ls | grep ^$PREFIX"
