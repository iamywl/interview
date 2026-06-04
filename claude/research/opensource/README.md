# 오픈소스 · 개발자 생태계 (slug: `opensource`)

SSAFY PT면접 대비 IT 시사 자료. 2021~2026(2026은 1~6월) 연도별 정리.

## 연도별 인덱스
- [2021](./2021.md) — Log4Shell 공급망 충격, GitHub Copilot 프리뷰, Elastic→OpenSearch 포크
- [2022](./2022.md) — OpenSSF Alpha-Omega·SLSA·SBOM, Copilot 정식 출시, Stable Diffusion 오픈 가중치
- [2023](./2023.md) — HashiCorp BSL→OpenTofu 포크, Llama 2·Mistral 7B 오픈 LLM 경쟁
- [2024](./2024.md) — xz Utils 백도어(CVE-2024-3094), Redis→Valkey 포크, Llama 3.1 405B, Cursor 부상
- [2025](./2025.md) — DeepSeek-R1 오픈 공개, Redis AGPL 복귀, IBM-HashiCorp 인수
- [2026 (1~6월)](./2026.md) — Miasma npm 공급망 공격, 에이전틱 코딩·MCP 표준화, 오픈 가중치 프런티어 모델

## 6년 관통 핵심 흐름
1. **공급망 보안의 진화**: Log4Shell(2021) → OpenSSF·SLSA·SBOM 제도화(2022) → xz 백도어 인적 공격(2024) → SLSA provenance까지 위조하는 Miasma(2026). 정적 증명에서 계정·CI 권한 보호와 런타임 검증으로 무게중심 이동.
2. **라이선스 전쟁과 포크**: Elastic→OpenSearch(2021), HashiCorp→OpenTofu(2023), Redis→Valkey(2024)·AGPL 복귀(2025). "소스 가용 ≠ 오픈소스", 포크는 되돌릴 수 없다.
3. **오픈 가중치 LLM 부상**: Stable Diffusion(2022) → Llama 2/Mistral(2023) → Llama 3.1 405B(2024) → DeepSeek-R1(2025) → 프런티어 도달(2026).
4. **AI 코딩의 진화**: Copilot 프리뷰(2021)·GA(2022) → Cursor 부상(2024) → 에이전틱 코딩·MCP(2026).

## 지원자 배경 연계 포인트
컨테이너 보안·시스템 콜 동적 관측 기반 이상탐지·Linux 커널 이해를 오픈소스 공급망 보안(xz 백도어, Miasma)과 강하게 연계. 정적 SBOM/SLSA의 한계를 런타임 행위 기반 탐지로 보완하는 관점, 추론 컨테이너 격리·seccomp·cgroup 최소권한 설계를 꼬리질문 답변에 활용.
