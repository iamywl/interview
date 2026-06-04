# 피지컬 AI · 임베디드 AI · 온디바이스 (slug: `physical_ai`)

SSAFY PT면접 대비 IT 시사 자료. 연도별(2021~2026, 2026은 1~6월) "그해 그 주제" 뉴스와 발표 공부자료를 정리한다.

> 용어 주의: '피지컬 AI(Physical AI)'는 2024년 이후 엔비디아가 대중화한 용어다. 2021~2022 문서는 같은 흐름을 **엣지 AI · 온디바이스 추론 · TinyML · 임베디드 NPU** 맥락으로 서술한다.

## 연도별 자료
- [2021](./2021.md) — 모바일 NPU 경쟁 본격화, TinyML과 MLPerf Tiny, 온디바이스 추론의 동기.
- [2022](./2022.md) — INT4 양자화 도입(스냅드래곤 8 Gen 2), Jetson Orin 엣지 슈퍼컴퓨터, ChatGPT 충격.
- [2023](./2023.md) — 온디바이스 생성형 AI(Stable Diffusion·LLM), SLM(Phi-2) 부상, 삼성 가우스.
- [2024](./2024.md) — '피지컬 AI' 용어 등장(GR00T), AI 폰(갤럭시 S24·Apple Intelligence), AI PC(Copilot+).
- [2025](./2025.md) — Cosmos 월드 모델·Isaac GR00T N1, VLA 표준화(Helix·π₀), 온디바이스 AI 에이전트.
- [2026](./2026.md) — Rubin·Alpamayo, 피지컬 AI 6대 도메인, 온디바이스 추론·계획(갤럭시 S26).

## 한 줄 흐름 요약
온디바이스 AI는 인식·분류(2021) → INT4 경량화(2022) → 생성형·SLM의 기기 진입(2023) → AI 폰·AI PC·피지컬 AI 용어화(2024) → 월드 모델·VLA·로봇 파운데이션 모델(2025) → 추론까지 기기/차량으로 확장(2026)으로 발전했다.

## 핵심 키워드 맵
- 온디바이스/엣지: NPU, TOPS, INT8/INT4 양자화, TinyML, SLM, 하이브리드 추론, Personal Data Engine.
- 칩·제품: 스냅드래곤 888→8 Gen 2/3→8 Elite→8 Elite Gen 5, 애플 A15/A17 Pro, Copilot+ PC(40 TOPS), Jetson Orin.
- 피지컬 AI: NVIDIA Cosmos(월드 모델), Isaac GR00T N1/N1.7, Alpamayo(AV), VLA(Vision-Language-Action), Figure Helix, Physical Intelligence π₀.

## 면접 활용 팁
- §7 꼬리질문 답변에는 지원자 배경(컨테이너 보안·시스템 콜 동적 관측 기반 이상탐지·리눅스 커널)을 **자원제약 엣지/임베디드 런타임 보안** 관점으로 과장 없이 연계한다.
- 수치는 본문 표기대로 "발표치/전망/추정"을 구분해 말한다.
