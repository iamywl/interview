# SSAFY 면접 준비 자료

SSAFY(삼성 청년 SW·AI 아카데미) 면접 준비를 위한 자료 저장소. 같은 과제를 **두 AI 도구로 병렬 정리**해 두 폴더로 나눠 담았다. 둘 다 한국어·사실 중심이며 출처 링크를 포함한다.

| 폴더 | 작성 도구 | 구성 방식 | 핵심 용도 |
|------|----------|----------|-----------|
| [`claude/`](claude/) | Claude | **주제별 세션** (IT 시사 + CS 기초) | PT면접 발표·꼬리질문 대비 |
| [`gemini/`](gemini/) | Gemini | **연도별(2022~2026) × 기술 토픽** | 5년치 IT 트렌드 연표식 정리 |

---

## 1. `claude/` — PT면접 중심 (주제별)

PT면접(발표면접)에 맞춰 **발표 주제 후보 → 핵심 개념 → 예상 꼬리질문 → 참고문헌** 형식으로 정리.

- [claude/README.md](claude/README.md) — 상세 인덱스
- [claude/00_PT면접_가이드.md](claude/00_PT면접_가이드.md) — 발표 구조·시간 배분·평가 포인트·질문 대응
- **IT 시사** [`claude/it_시사/`](claude/it_시사/) — 생성형AI·반도체/HBM·클라우드/개발·보안/규제·한국IT/삼성 + 통합 타임라인 + PT 발표주제 인덱스
- **CS 기초** [`claude/cs_기초/`](claude/cs_기초/) — 자료구조·알고리즘 / 운영체제 / 네트워크 / 데이터베이스 / 객체지향·설계·웹 (각 빈출 질문 16~18개)
- 부록: [claude/07_면접_활용가이드.md](claude/07_면접_활용가이드.md) — 자기소개·인성·마지막 할말·지원동기 템플릿

## 2. `gemini/` — 연도별 IT 트렌드 (Gartner 기반)

`research_gartner.sh`로 수집해, **2022~2026 각 연도 × 약 30개 기술 토픽**으로 정리.

- 토픽 예: `genai`(생성형AI), `agentic`(AI 에이전트), `cloud`, `security`, `zerotrust`, `quantum`, `pqc`(양자내성암호), `robotics`, `finops`, `platform`(플랫폼 엔지니어링), `opensource`, `multimodal`, `slm`(소형언어모델) 등.
- 같은 토픽을 연도별로 비교하며 흐름을 볼 수 있다. 예) [gemini/2022/genai.md](gemini/2022/genai.md) → [gemini/2026/genai.md](gemini/2026/genai.md)
- 보조: [gemini/xgboost/](gemini/xgboost/) — XGBoost 관련 정리.

---

## 추천 사용법

1. **발표 형식·답변 연습** → `claude/` (주제별 세션, 꼬리질문 포함).
2. **특정 기술의 5년 변화 추적** → `gemini/<연도>/<토픽>.md` 를 연도순으로 비교.
3. 두 자료는 상호 보완적이다: `claude/`는 "면접 답변용 구조화", `gemini/`는 "연도별 트렌드 데이터".

## 면접 직전 확인
- SSAFY 취업률·기수·교육과정 수치는 갱신되므로 [ssafy.com](https://www.ssafy.com)·[삼성전자 사회공헌](https://csr.samsung.com/ko/program/samsung-sw-academy-for-youth)에서 최신값 확인.
- 일부 2026년 수치는 보도 기준 전망·추정치이므로 "전망"으로 표현.
