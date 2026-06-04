#!/usr/bin/env bash
# =============================================================================
# make_extra.sh — 면접 답변 + PT 산업테마 조사를 gemini로 병렬 생성
#   _prompts/*.txt 각 파일: 1행=출력 상대경로, 2행 이후=프롬프트 본문.
#   공통 배경(_context.md)을 앞에 붙여 gemini에 전달. 결과를 출력경로에 저장.
#   기존 research.sh 패턴 차용(Vertex ADC 재사용, tmux 병렬, 헤드리스).
# 사용법: make_extra.sh run | status | stop
# =============================================================================
set -euo pipefail
SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SELF")" && pwd)"
PREFIX="xtra_"
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="${GOOGLE_CLOUD_PROJECT:-knudc-yoonwoodev}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-us-central1}"
export GEMINI_CLI_TRUST_WORKSPACE=true
MODEL="${GEMINI_MODEL:-gemini-2.5-flash}"
MAX_CONCURRENT="${MAX_CONCURRENT:-12}"
CTX="$ROOT/_context.md"

wait_for_slot() {
  [ "$MAX_CONCURRENT" -gt 0 ] || return 0
  while :; do
    local n; n="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
    [ "$n" -lt "$MAX_CONCURRENT" ] && return 0; sleep 2
  done
}

worker() {  # 인자: <prompt_file>
  local pf="$1" out body ts
  out="$(head -1 "$pf")"
  body="$(tail -n +2 "$pf")"
  mkdir -p "$ROOT/$(dirname "$out")"
  ts="$(date +%Y%m%d-%H%M)"
  local full
  full="$(cat "$CTX")

$body"
  echo "[xtra] $out 생성" >&2
  {
    echo "<!-- 생성:${ts} 모델:${MODEL} (Vertex AI) -->"
    echo
    gemini -m "$MODEL" --skip-trust -y -p "$full" 2>/dev/null
  } > "$ROOT/$out"
  echo "[xtra] 완료: $out" >&2
}

run_all() {
  local pf slug sess n=0
  for pf in "$ROOT"/_prompts/*.txt; do
    [ -f "$pf" ] || continue
    slug="$(basename "$pf" .txt)"; sess="${PREFIX}${slug}"
    wait_for_slot
    tmux has-session -t "$sess" 2>/dev/null && tmux kill-session -t "$sess" 2>/dev/null || true
    tmux new-session -d -s "$sess" -c "$ROOT"
    tmux send-keys -t "$sess" "bash '$SELF' -1 '$pf'; tmux kill-session -t '$sess'" Enter
    n=$((n+1)); printf '  ▶ %s\n' "$slug"
  done
  echo "총 ${n}개 작업 병렬 시작."
}

status() {
  local a; a="$(tmux ls 2>/dev/null | sed 's/:.*//' | grep -c "^${PREFIX}" || true)"
  echo "활성 세션: ${a}개"
}
stop() { tmux ls 2>/dev/null | sed 's/:.*//' | grep "^${PREFIX}" | xargs -r -n1 tmux kill-session -t; echo stopped; }

case "${1:-run}" in
  run) run_all ;;
  status) status ;;
  stop) stop ;;
  -1) shift; worker "$@" ;;
  *) echo "run|status|stop"; exit 1 ;;
esac
