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

### 2-1. `keyword_study.sh` — 키워드 발굴 → 키워드별 심화조사 (2단계 자동 파이프라인)

[gemini/keyword_study.sh](gemini/keyword_study.sh)는 **tmux로 Gemini 에이전트를 병렬 생성**하는 2단계 파이프라인이다. 기존 `research_gartner.sh`·`deep_themes.sh`와 달리 토픽이 고정되어 있지 않고, **1단계가 키워드를 발굴 → 그 개수(N/M)에 맞춰 2단계가 키워드 1개당 에이전트 1개로 동적 fan-out** 한다.

- **1단계(discover)**: 2022~2026 각 연도마다 에이전트 1개 → 그해 핫했던 IT 키워드 발굴. 결과: `gemini/kw_study/_discover/<연도>.md`.
- **merge**: 모든 연도의 키워드를 slug 기준으로 합쳐 dedup → `gemini/kw_study/_keywords.txt`.
- **2단계(study)**: 키워드 1개당 에이전트 1개 → 소개·개념·동작원리·**장점·단점·한계점**·필요시 **수학적 개념**·근거·PT 발표 설계를 한 문서로. 결과: `gemini/kw_study/keywords/<slug>.md`.

```bash
# 완전 자동(논스톱): discover → 대기 → merge → study 까지 한 번에
bash gemini/keyword_study.sh auto

# 단계별 실행도 가능
bash gemini/keyword_study.sh discover   # 1단계만
bash gemini/keyword_study.sh merge      # 키워드 목록 생성(dedup)
bash gemini/keyword_study.sh study      # 2단계 fan-out
bash gemini/keyword_study.sh status     # 활성 세션·완료 문서 현황
bash gemini/keyword_study.sh retry      # 빈/부실 문서만 재투입
bash gemini/keyword_study.sh stop       # 모든 세션 종료
```

환경변수: `GEMINI_MODEL`(기본 `gemini-2.5-pro`) · `MAX_CONCURRENT`(동시 세션 상한, 기본 8) · `YEARS`(기본 `2022 2023 2024 2025 2026`) · `MAX_KEYWORDS`(2단계 상한, 기본 0=무제한) · `MIN_CHARS`(retry 임계, 기본 3000). 인증은 기존 Vertex AI ADC를 재사용한다.

### 2-2. `review_all.sh` — 저장소 전체 문서 병렬 리뷰 → `reviewedbygemini/`

[gemini/review_all.sh](gemini/review_all.sh)는 **저장소의 모든 `.md`를 순회하며 각 문서를 Gemini로 병렬 리뷰**하고, 결과를 원본 트리 구조 그대로 [reviewedbygemini/](reviewedbygemini/)에 미러링 저장한다. (`gemini/2024/genai.md` → `reviewedbygemini/gemini/2024/genai.md`)

각 리뷰는 ① 문서 요지 ② **사실 정확성 점검(표)** ③ 최신성(2026 기준) ④ 누락·보완 필요 ⑤ **추가 조사 주제 제안 5개**(조사한 만큼 다시 보충할 주제) ⑥ PT 발표 활용도 ⑦ 종합 평가로 구성된다.

```bash
bash gemini/review_all.sh                 # 전체 .md 병렬 리뷰(이미 리뷰된 건 자동 skip)
bash gemini/review_all.sh run gemini/kw_study   # 특정 폴더만 리뷰
bash gemini/review_all.sh status          # 활성 세션·완료 현황
bash gemini/review_all.sh retry           # 빈/부실 리뷰만 재실행
bash gemini/review_all.sh stop            # 모든 리뷰 세션 종료
```

환경변수: `GEMINI_MODEL`(기본 `gemini-2.5-flash`, 대량이라 flash 기본) · `MAX_CONCURRENT`(기본 8) · `FORCE`(1이면 재리뷰) · `MIN_CHARS`(기본 1200) · `MAX_SRC_CHARS`(큰 원본 skip, 기본 200000). 인증은 기존 Vertex AI ADC를 재사용한다.

---

## 추천 사용법

1. **발표 형식·답변 연습** → `claude/` (주제별 세션, 꼬리질문 포함).
2. **특정 기술의 5년 변화 추적** → `gemini/<연도>/<토픽>.md` 를 연도순으로 비교.
3. 두 자료는 상호 보완적이다: `claude/`는 "면접 답변용 구조화", `gemini/`는 "연도별 트렌드 데이터".

## 면접 직전 확인
- SSAFY 취업률·기수·교육과정 수치는 갱신되므로 [ssafy.com](https://www.ssafy.com)·[삼성전자 사회공헌](https://csr.samsung.com/ko/program/samsung-sw-academy-for-youth)에서 최신값 확인.
- 일부 2026년 수치는 보도 기준 전망·추정치이므로 "전망"으로 표현.
