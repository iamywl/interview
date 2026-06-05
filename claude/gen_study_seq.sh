#!/usr/bin/env bash
# 남은 STUDY.md를 tmux 없이 순차로 gemini 생성(백그라운드 실행용).
# build_study.sh 의 워커(-1)를 토픽마다 직접 호출. set -e 미사용(중간 실패해도 계속).
cd /home/ywlee/interview

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
  "ai_governance|AI 규제 · 거버넌스 · 윤리"
  "opensource|오픈소스 · 개발자 생태계"
)

for rec in "${TOPICS[@]}"; do
  slug="${rec%%|*}"; label="${rec#*|}"
  f="claude/research/$slug/STUDY.md"
  if head -1 "$f" 2>/dev/null | grep -q "6년치 종합"; then
    echo "skip $slug (이미 gemini판)"; continue
  fi
  echo "=== $slug 시작 $(date +%H:%M:%S) ==="
  bash claude/build_study.sh -1 "$slug" "$label"
  if head -1 "$f" 2>/dev/null | grep -q "6년치 종합"; then echo "  $slug OK"; else echo "  $slug FAIL(기존유지)"; fi
done

echo "SEQ DONE: 완료=$(grep -rl '6년치 종합' claude/research/*/STUDY.md 2>/dev/null | wc -l)/16 @ $(date +%H:%M:%S)"
