# IT 트렌드 PT 면접 주제 종합 (2022–2026)

> 이 문서는 `gemini`(gemini-2.5-flash, Vertex AI)를 tmux로 병렬 실행해 만든 30주제 × 5년 = 150개
> 조사 파일의 종합 인덱스다. 각 파일은 그해 핵심 트렌드, 대표 뉴스, 핵심 기업·제품, 시장 수치,
> 전년 대비 변화, PT 발표 주제 후보 3개, 후보별 발표 설계, PT 적합도 평가를 담고 있다.
>
> 주의: 웹 검색이 불가능한 환경이라 모델의 학습 지식에 기반해 작성되었다. 2025–2026년 항목은
> 일부 추정이 포함되므로, 실제 발표 전 최신 수치·사건은 별도로 확인할 것.
> 작성 규칙상 비유·유추는 사용하지 않았다.

---

## 1. PT 면접에 추천하는 주제 Top 12 (큐레이션)

선정 기준: ① 2026년 시점의 시의성 ② 기술적 깊이를 보여줄 여지 ③ 다른 지원자와의 차별화 가능성
④ 개발 직무·프로젝트 경험과 연결 용이성.

| 순위 | 주제 | 추천 이유 | 추천 발표 각도 | 핵심 파일 |
|---|---|---|---|---|
| 1 | AI 에이전트 (Agentic AI) | 2025–2026 최대 화두. 단순 챗봇을 넘어 스스로 작업을 수행하는 단계로 이동 | "도구를 쓰는 AI"의 구조(계획·도구호출·검증)와 한계(신뢰성)를 직접 설명 | [2026/agentic](2026/agentic.md), [2025/agentic](2025/agentic.md) |
| 2 | 온디바이스 AI·소형언어모델(SLM) | 클라우드 비용·지연·프라이버시 문제의 현실적 대안으로 부상 | 큰 모델 대비 SLM의 트레이드오프(성능 vs 비용·지연)를 수치로 비교 | [2026/slm](2026/slm.md), [2025/slm](2025/slm.md) |
| 3 | LLMOps·AI 엔지니어링 | "모델을 만드는 것"에서 "운영하는 것"으로 무게중심 이동, 실무 직결 | 학습·배포·모니터링·재학습 파이프라인을 단계별로 설명 | [2026/aiops](2026/aiops.md), [2024/aiops](2024/aiops.md) |
| 4 | 생성형 AI 신뢰성·거버넌스 | 환각·저작권·규제(EU AI Act 등)로 신뢰 문제가 전면화 | 환각이 왜 생기는지, RAG·가드레일로 어떻게 줄이는지 설명 | [2026/airegulation](2026/airegulation.md), [2026/genai](2026/genai.md) |
| 5 | 플랫폼 엔지니어링·개발자 경험(DevEx) | 개발 생산성 주제, SW 직무와 직접 연결 | 내부 개발자 플랫폼(IDP)이 무엇을 자동화하는지 구체적으로 | [2026/platform](2026/platform.md), [2024/platform](2024/platform.md) |
| 6 | 제로트러스트 보안 | 원격근무·클라우드 확산으로 표준이 된 보안 모델, 안정적 발표 주제 | "신뢰하지 않고 항상 검증"의 구성요소를 단계별로 설명 | [2026/zerotrust](2026/zerotrust.md), [2024/zerotrust](2024/zerotrust.md) |
| 7 | AI 데이터센터·GPU·전력 | AI 붐의 물리적 토대. 전력·냉각·GPU 공급이 현안 | AI 학습이 왜 막대한 전력을 쓰는지, 효율화 방향 설명 | [2026/datacenter](2026/datacenter.md), [2025/datacenter](2025/datacenter.md) |
| 8 | 양자내성암호(PQC) | 양자컴퓨터 위협 대비. 차별화가 매우 큰 주제 | 현재 암호가 왜 깨질 수 있는지, PQC 전환이 왜 지금 필요한지 | [2026/pqc](2026/pqc.md), [2024/pqc](2024/pqc.md) |
| 9 | FinOps·클라우드 비용 최적화 | 클라우드 지출 급증으로 비용 관점이 경영 의제화 | 비용을 가시화하고 최적화하는 절차를 사례로 설명 | [2026/finops](2026/finops.md), [2023/finops](2023/finops.md) |
| 10 | 디지털 트윈 | 제조·도시·에너지로 확산되는 산업 응용, 융합형 주제 | 실물과 가상의 데이터 연동 구조와 활용 사례 | [2026/digitaltwin](2026/digitaltwin.md), [2024/digitaltwin](2024/digitaltwin.md) |
| 11 | 엣지 컴퓨팅·IoT | 실시간성·대역폭 문제 해결, 자율주행·스마트팩토리와 연결 | 왜 중앙 클라우드만으로 부족한지, 엣지의 역할 설명 | [2026/edge](2026/edge.md), [2025/edge](2025/edge.md) |
| 12 | 멀티모달 AI | 텍스트·이미지·음성 통합으로 활용 범위 확대 | 단일 모달 대비 멀티모달의 이점과 처리 방식 설명 | [2026/multimodal](2026/multimodal.md), [2025/multimodal](2025/multimodal.md) |

### 발표 주제 고를 때 참고
- 가장 무난하면서 깊이를 보이기 좋은 조합: **3(LLMOps) 또는 5(플랫폼 엔지니어링)** — 개발 직무와 직접 연결된다.
- 차별화로 점수를 노린다면: **8(PQC), 7(데이터센터·전력), 10(디지털 트윈)** — 다루는 지원자가 적다.
- 시의성으로 주목을 끌려면: **1(AI 에이전트), 4(생성형 AI 신뢰성)**.

---

## 2. 연도별 전체 인덱스

### 2022

| 주제 | 파일 | 첫 발표후보 |
|---|---|---|
| 생성형 AI·LLM | [genai](2022/genai.md) | ChatGPT, 세상의 대화를 바꾸다: 생성형 AI가 이끄는 새로운 패러다임의 시작 |
| AI 에이전트 | [agentic](2022/agentic.md) | AI 에이전트, 단순 비서를 넘어 자율적 동반자로: 2022년 대전환점 분석 |
| AI엔지니어링·MLOps | [aiops](2022/aiops.md) | AI, 개발을 넘어 운영의 시대로: MLOps로 완성하는 AI 비즈니스 가치 극대화 전략 |
| 멀티모달 AI | [multimodal](2022/multimodal.md) | AI의 감각 확장: 2022 멀티모달 AI, 인간을 닮아가는 지능의 진화 |
| SLM·온디바이스 | [slm](2022/slm.md) | 손안의 인공지능 혁명: 2022년 온디바이스 AI와 SLM이 제시하는 미래 |
| AI규제·거버넌스 | [airegulation](2022/airegulation.md) | AI 신뢰 시대의 서막: EU AI Act와 K-기업의 생존 전략 |
| 멀티/하이브리드 클라우드 | [cloud](2022/cloud.md) | 멀티/하이브리드 클라우드, 선택 아닌 필연: 2022 기업 클라우드 전략의 핵심 해부 |
| FinOps | [finops](2022/finops.md) | 클라우드 비용, 재앙인가 기회인가? 2022 FinOps 트렌드와 현명한 투자를 위한 전략 |
| 엣지·IoT | [edge](2022/edge.md) | 초연결 시대를 선도할 분산 지능: 2022 엣지 컴퓨팅 & IoT 혁신 보고서 |
| 5G/6G 네트워크 | [network](2022/network.md) | 5G를 넘어, 6G 시대로: 초연결 사회의 미래와 산업 혁신 전략 |
| 데이터센터·GPU | [datacenter](2022/datacenter.md) | AI 시대의 심장, 2022 데이터센터: GPU가 바꾼 인프라 혁명과 지속 가능성의 도전 |
| 사이버보안 | [security](2022/security.md) | 2022년 사이버 보안, 경계의 소멸과 제로 트러스트의 부상: 디지털 전환의 필수 전략 |
| 제로트러스트 | [zerotrust](2022/zerotrust.md) | Never Trust, Always Verify: 제로트러스트, 2022년 디지털 영토를 재정의하다 |
| 랜섬웨어·공급망 | [ransomware](2022/ransomware.md) | 랜섬웨어 팬데믹과 소프트웨어 공급망: 2022년, 숨겨진 위협을 찾아 면역력을 높여라 |
| IAM·인증 | [identity](2022/identity.md) | 신원을 경계로, 제로 트러스트를 전략으로: 2022년 Identity-First Security가 제시하는 보안의 미래 |
| 양자내성암호 | [pqc](2022/pqc.md) | 퀀텀 암호 시대의 서막: NIST 표준 PQC, 디지털 미래를 지키는 새로운 방패 |
| 데이터패브릭·거버넌스 | [data](2022/data.md) | 데이터 혁신의 나침반: 2022년 데이터 패브릭, 메시, 거버넌스로 본 미래 데이터 전략 |
| 애널리틱스·BI | [analytics](2022/analytics.md) | 데이터를 넘어 '결정'으로: 2022년 결정 지능의 부상과 비즈니스 혁신 |
| 실시간데이터 | [realtime](2022/realtime.md) | 실시간 데이터, 비즈니스 민첩성의 핵심 동력: 2022년 스트리밍 아키텍처의 혁신 |
| 플랫폼엔지니어링·DevEx | [platform](2022/platform.md) | 개발 속도, 품질, 그리고 행복: 2022년 플랫폼 엔지니어링으로 만드는 최적의 개발자 경험 |
| DevOps·DevSecOps | [devsecops](2022/devsecops.md) | 2022, 소프트웨어 가치 사슬을 지키는 DevSecOps: Shift-Left를 넘어 '보안 내재화'로 |
| 로우코드/노코드 | [lowcode](2022/lowcode.md) | 시민 개발자가 이끄는 초자동화 시대: 로우코드/노코드로 여는 기업 IT 혁신 전략 |
| 오픈소스·공급망 | [opensource](2022/opensource.md) | Log4Shell을 넘어: 2022년 소프트웨어 공급망 보안, 위기 속 기회 |
| 양자컴퓨팅 | [quantum](2022/quantum.md) | 2022, 양자 컴퓨팅: '퀀텀 도약'을 위한 현실적 로드맵을 그리다 |
| 공간컴퓨팅·AR/VR | [spatial](2022/spatial.md) | 환상과 현실 사이: 2022년 메타버스, 가트너 하이프 사이클을 넘어선 기업의 선택 |
| 디지털트윈 | [digitaltwin](2022/digitaltwin.md) | 2022, 산업 경계를 허문다: AI 기반 디지털 트윈으로 여는 비즈니스 초연결 시대 |
| 블록체인·Web3 | [blockchain](2022/blockchain.md) | 크립토 겨울, 생존을 넘어 혁신으로: 2022 Web3 위기 속 지속 가능한 블록체인 서비스 개발 전략 |
| 로보틱스·자율주행 | [robotics](2022/robotics.md) | \인류의 동반자, 휴머노이드: 2022년 옵티머스가 제시한 미래 노동력의 청사진\ |
| 지속가능기술·그린IT | [sustainability](2022/sustainability.md) | 지속가능한 미래를 위한 IT: 개발자의 코드 한 줄이 만드는 그린 임팩트 |
| 하이퍼오토메이션·RPA | [hyperautomation](2022/hyperautomation.md) | 초자동화, 멈춰버린 기업 혁신에 엔진을 달다: 2022년 하이퍼오토메이션 트렌드와 미래 비전 |

### 2023

| 주제 | 파일 | 첫 발표후보 |
|---|---|---|
| 생성형 AI·LLM | [genai](2023/genai.md) | 2023, 생성형 AI 대전환의 서막: '지능형 조력자' 시대를 위한 개발자의 통찰 |
| AI 에이전트 | [agentic](2023/agentic.md) | 생성형 AI를 넘어 '행동하는 AI'의 시대: 나만의 코파일럿, 자율 에이전트가 만드는 미래 |
| AI엔지니어링·MLOps | [aiops](2023/aiops.md) | 초거대 AI 시대, MLOps의 새로운 항해: LLMOps를 중심으로 |
| 멀티모달 AI | [multimodal](2023/multimodal.md) | AI, 세상을 오감으로 이해하다: 멀티모달리티가 여는 초지능 시대 |
| SLM·온디바이스 | [slm](2023/slm.md) | 클라우드를 넘어, 기기 안에서 피어나는 AI: 온디바이스 SLM의 시대가 온다 |
| AI규제·거버넌스 | [airegulation](2023/airegulation.md) | AI, 통제 가능한 혁신으로: 2023년 AI 거버넌스 빅뱅과 미래 설계 |
| 멀티/하이브리드 클라우드 | [cloud](2023/cloud.md) | \선택 아닌 필연, 하이브리드 클라우드로 완성하는 미래 엔터프라이즈 IT 전략\ |
| FinOps | [finops](2023/finops.md) | 클라우드 비용, 낭비 없이 가치 있게: FinOps로 여는 스마트 비즈니스 성장 전략 |
| 엣지·IoT | [edge](2023/edge.md) | 엣지 AI, 산업 지능화의 최전선을 열다: 실시간 의사결정을 통한 생산성 혁신 전략 |
| 5G/6G 네트워크 | [network](2023/network.md) | 5G, 연결을 넘어 가치를 창출하다: 프라이빗 5G와 산업 혁신의 미래 |
| 데이터센터·GPU | [datacenter](2023/datacenter.md) |  |
| 사이버보안 | [security](2023/security.md) | 2023, 생성형 AI 시대의 사이버보안: '지능형 위협'과 '스마트 방어'의 양면성 파헤치기 |
| 제로트러스트 | [zerotrust](2023/zerotrust.md) | 2023, 경계를 넘어선 보안: 제로 트러스트와 SASE로 완성하는 미래 디지털 혁신 |
| 랜섬웨어·공급망 | [ransomware](2023/ransomware.md) | 2023 랜섬웨어 대공세: MOVEit 사례로 보는 공급망 보안 전략 재편의 시대 |
| IAM·인증 | [identity](2023/identity.md) | 비밀번호 없는 미래: FIDO2와 제로 트러스트가 그리는 혁신적인 신원 관리 |
| 양자내성암호 | [pqc](2023/pqc.md) | 양자 시대의 사이버 방패: NIST 표준 PQC로 재정의하는 미래 보안 전략 |
| 데이터패브릭·거버넌스 | [data](2023/data.md) | 데이터 사일로를 넘어선 혁신: 데이터 패브릭으로 구현하는 '숨겨진 데이터 가치' 발굴 전략 |
| 애널리틱스·BI | [analytics](2023/analytics.md) | 데이터를 넘어, '결정'을 지능화하다: 2023 의사결정 인텔리전스 혁명 |
| 실시간데이터 | [realtime](2023/realtime.md) | 초연결 시대를 위한 심장: 실시간 데이터 스트리밍으로 빚어낼 AI 기반 개인화 서비스 |
| 플랫폼엔지니어링·DevEx | [platform](2023/platform.md) | 개발자를 위한 고속도로, 플랫폼 엔지니어링: 생산성 딜레마를 넘어설 핵심 전략 |
| DevOps·DevSecOps | [devsecops](2023/devsecops.md) | DevOps의 Next Level: 플랫폼 엔지니어링으로 혁신 가속화 |
| 로우코드/노코드 | [lowcode](2023/lowcode.md) | 코딩 장벽을 넘어, 비즈니스 혁신을 가속화하다: 로우코드/노코드와 시민 개발자의 시대 |
| 오픈소스·공급망 | [opensource](2023/opensource.md) | Log4Shell을 넘어선 넥스트 스텝: 2023년 소프트웨어 공급망 보안 전략 |
| 양자컴퓨팅 | [quantum](2023/quantum.md) | 미래 컴퓨팅 패러다임의 서막, 2023 양자컴퓨팅: NISQ 시대를 넘어선 실용화 로드맵 |
| 공간컴퓨팅·AR/VR | [spatial](2023/spatial.md) | 메타버스 광풍 너머: '공간 컴퓨팅'이 재정의하는 우리의 현실과 미래 |
| 디지털트윈 | [digitaltwin](2023/digitaltwin.md) | 초연결 시대를 넘어, 지능형 미래를 여는 열쇠: AI 기반 디지털 트윈의 혁신 전략 |
| 블록체인·Web3 | [blockchain](2023/blockchain.md) | 크립토 겨울을 넘어선 2023년, Web3의 실용적 진화: 규제와 RWA가 이끄는 새로운 패러다임 |
| 로보틱스·자율주행 | [robotics](2023/robotics.md) | AI와 인간의 경계를 허무는 동반자: 2023년 휴머노이드 로봇, 가능성을 걷다 |
| 지속가능기술·그린IT | [sustainability](2023/sustainability.md) | AI 시대, 지속가능한 컴퓨팅의 서막: 그린 소프트웨어와 데이터센터의 혁신 |
| 하이퍼오토메이션·RPA | [hyperautomation](2023/hyperautomation.md) | 초자동화 시대, RPA를 넘어 AI 기반 비즈니스 � |

### 2024

| 주제 | 파일 | 첫 발표후보 |
|---|---|---|
| 생성형 AI·LLM | [genai](2024/genai.md) | 생성형 AI, 인간 생산성의 새로운 지평을 열다: 2024년, 협력적 AI 워크플로우의 완성 |
| AI 에이전트 | [agentic](2024/agentic.md) | 2024, AI 에이전트 혁명: 인간-AI 협업의 새로운 지평을 열다 |
| AI엔지니어링·MLOps | [aiops](2024/aiops.md) | 생성형 AI 시대, MLOps로 경쟁 우위를 확보하라: AI 개발부터 운영까지의 여정 |
| 멀티모달 AI | [multimodal](2024/multimodal.md) | AI, 세상을 보고 듣고 이해하다: 2024 멀티모달 AI 시대의 서막 |
| SLM·온디바이스 | [slm](2024/slm.md) | 클라우드를 넘어 엣지로: 온디바이스 AI, 우리 삶에 스며들다 |
| AI규제·거버넌스 | [airegulation](2024/airegulation.md) | AI 규제, 혁신의 동반자인가 족쇄인가: EU AI Act가 던지는 질문과 한국의 대응 전략 |
| 멀티/하이브리드 클라우드 | [cloud](2024/cloud.md) | 초거대 AI 시대를 위한 클라우드 전략: 멀티/하이브리드 클라우드 네이티브로 비즈니스 혁신 가속화 |
| FinOps | [finops](2024/finops.md) | 클라우드 비용, 통제를 넘어 가치 창출로: 2024 FinOps, 지능형 최적화와 비즈니스 성과의 교차점 |
| 엣지·IoT | [edge](2024/edge.md) | 초저지연과 지능화의 교차점: 2024, 엣지 AI와 5G 융합이 만드는 미래 산업 혁신 |
| 5G/6G 네트워크 | [network](2024/network.md) | 5G 시대를 넘어: 초지능·초실감 네트워크가 여는 미래 산업 혁신과 6G 비전 |
| 데이터센터·GPU | [datacenter](2024/datacenter.md) |  |
| 사이버보안 | [security](2024/security.md) | AI 시대의 사이버 보안, 창과 방패의 진화: 생성형 AI와 XDR 기반의 지능형 방어 전략 |
| 제로트러스트 | [zerotrust](2024/zerotrust.md) | 2024년 보안 패러다임 전환: SASE와 ZTNA로 완성되는 '믿을 수 없는' 네트워크 |
| 랜섬웨어·공급망 | [ransomware](2024/ransomware.md) | 2024년 사이버 펜데믹, 랜섬웨어와 공급망 위협: 디지털 생존을 위한 제로 트러스트 전환 전략 |
| IAM·인증 | [identity](2024/identity.md) | 로그인, 그 이상의 가치: 2024, AI 기반 제로 트러스트 IAM의 진화와 미래 |
| 양자내성암호 | [pqc](2024/pqc.md) | 퀀텀의 서막, 디지털 보안의 새 지평: 양자내성암호(PQC), 선택 아닌 필수 전략 |
| 데이터패브릭·거버넌스 | [data](2024/data.md) | 분산된 데이터, 하나로 꿰다: 데이터 패브릭으로 구현하는 지능형 데이터 플랫폼 |
| 애널리틱스·BI | [analytics](2024/analytics.md) | AI 날개를 단 데이터: 2024년 의사결정 인텔리전스의 비상과 미래 전략 |
| 실시간데이터 | [realtime](2024/realtime.md) | 미래를 엿보는 창: 실시간 데이터 스트림, 지능형 의사결정의 심장이 되다 |
| 플랫폼엔지니어링·DevEx | [platform](2024/platform.md) | 개발자의 행복은 곧 비즈니스 성장! 2024, 내부 개발자 플랫폼(IDP)이 이끄는 DevEx 혁명 |
| DevOps·DevSecOps | [devsecops](2024/devsecops.md) | DevSecOps, 선택 아닌 필수 전략: 소프트웨어 공급망 보안을 통한 신뢰의 가치 창출 |
| 로우코드/노코드 | [lowcode](2024/lowcode.md) | 시민 개발자가 이끄는 디지털 대전환: 로우코드/노코드로 비즈니스 민첩성을 확보하라! |
| 오픈소스·공급망 | [opensource](2024/opensource.md) | 2024, 오픈소스 공급망 보안: 위협을 넘어 혁신의 기회를 잡는 전략 |
| 양자컴퓨팅 | [quantum](2024/quantum.md) | 양자, 현실이 되다: NISQ 시대를 넘어 '양자 이점'을 창출하는 전략 |
| 공간컴퓨팅·AR/VR | [spatial](2024/spatial.md) | 현실을 확장하는 공간 컴퓨터: Apple Vision Pro와 함께 열리는 미래 산업 생태계 |
| 디지털트윈 | [digitaltwin](2024/digitaltwin.md) | 현실을 복제하고 미래를 통제하다: 디지털 트윈 기반 자율 시스템으로의 진화 |
| 블록체인·Web3 | [blockchain](2024/blockchain.md) | Web3, 실물 경제를 깨우다: RWA 토큰화의 현재와 미래 전략 |
| 로보틱스·자율주행 | [robotics](2024/robotics.md) | AI, 로봇에게 영혼을 불어넣다: 엠바디드 AI 시대의 서막 |
| 지속가능기술·그린IT | [sustainability](2024/sustainability.md) | AI 시대의 지속가능한 전력 혁명: 그린 컴퓨팅을 통한 탄소 중립 데이터센터 전략 |
| 하이퍼오토메이션·RPA | [hyperautomation](2024/hyperautomation.md) | AI, 자동화를 넘어 '자율성'을 꿈꾸다: 하이퍼오토메이션 3.0 시대의 서막 |

### 2025

| 주제 | 파일 | 첫 발표후보 |
|---|---|---|
| 생성형 AI·LLM | [genai](2025/genai.md) | 2025, 생성형 AI: 단순한 도구를 넘어 비즈니스 혁신의 조력자로 |
| AI 에이전트 | [agentic](2025/agentic.md) | 2025, 나만의 AI 비서, '초(超)자율 에이전트'가 여는 개인 생산성 혁명의 서막 |
| AI엔지니어링·MLOps | [aiops](2025/aiops.md) | 생성형 AI 시대, MLOps로 경쟁 우위를 확보하라: 책임감 있는 AI 운영 전략 |
| 멀티모달 AI | [multimodal](2025/multimodal.md) | AI, 세상을 보고 듣고 이해하다: 멀티모달 파운데이션 모델의 시대 |
| SLM·온디바이스 | [slm](2025/slm.md) | 클라우드를 넘어, 당신의 손안으로: 온디바이스 AI와 SLM이 바꾸는 미래 경험 |
| AI규제·거버넌스 | [airegulation](2025/airegulation.md) | 규제와 혁신의 교차로: 2025, 책임 있는 AI(RAI) 거버넌스로 AI 신뢰를 구축하라! |
| 멀티/하이브리드 클라우드 | [cloud](2025/cloud.md) | 2025 클라우드 대전환 시대, 멀티/하이브리드 클라우드와 클라우드 네이티브로 이끄는 혁신 전략 |
| FinOps | [finops](2025/finops.md) | AI와 함께 진화하는 FinOps: 클라우드 비용, 통제를 넘어 '창출'로 |
| 엣지·IoT | [edge](2025/edge.md) | 초연결 시대를 넘어, 자율 엣지: 2025 산업 혁신을 이끄는 지능형 엣지 컴퓨팅의 미래 |
| 5G/6G 네트워크 | [network](2025/network.md) | 초연결 지능망으로 가는 길: 5G Advanced와 6G가 그리는 미래 산업 지형도 |
| 데이터센터·GPU | [datacenter](2025/datacenter.md) |  |
| 사이버보안 | [security](2025/security.md) | AI 시대의 방패와 칼: 2025년 위협 인텔리전스로 지능화된 사이버 공격을 제압하다 |
| 제로트러스트 | [zerotrust](2025/zerotrust.md) | 경계 없는 신뢰, 제로트러스트와 SASE로 구현하는 차세대 보안 로드맵 |
| 랜섬웨어·공급망 | [ransomware](2025/ransomware.md) | 초연결 시대의 암울한 그림자: 2025 랜섬웨어 다중 협박과 생존 전략 |
| IAM·인증 | [identity](2025/identity.md) | 2025, 사라지는 비밀번호: 당신의 신원은 블록체인에서 시작된다 - DID와 패스워드리스 인증이 그리는 미래 |
| 양자내성암호 | [pqc](2025/pqc.md) | 양자 위협 시대의 최후 방어선: PQC 기반 '미래형 보안 아키텍처' 설계 전략 |
| 데이터패브릭·거버넌스 | [data](2025/data.md) | 데이터, 비즈니스 가치를 엮다: 2025년 데이터 패브릭 기반의 지능형 데이터 활용 전략 |
| 애널리틱스·BI | [analytics](2025/analytics.md) | 생성형 AI와 의사결정 인텔리전스: 데이터, 질문을 넘어 행동으로 |
| 실시간데이터 | [realtime](2025/realtime.md) | 2025, 실시간 데이터의 심장: 모든 비즈니스를 뛰게 할 초저지연 Event-Driven Architecture의 마법 |
| 플랫폼엔지니어링·DevEx | [platform](2025/platform.md) | 2025, 개발자 생산성의 마스터키: 플랫폼 엔지니어링, 어떻게 성공할 것인가? |
| DevOps·DevSecOps | [devsecops](2025/devsecops.md) | 코드부터 클라우드까지, AI와 플랫폼으로 완성하는 2025 DevSecOps: 개발자 주도 보안 혁신 |
| 로우코드/노코드 | [lowcode](2025/lowcode.md) | 시민 개발자 시대, SSAFY는 어떻게 비즈니스와 기술의 경계를 허무는가?: 2025 LCNC 트렌드를 중심으로 |
| 오픈소스·공급망 | [opensource](2025/opensource.md) | 2025, 코드의 혈관을 지켜라: 오픈소스 공급망 보안, 선택 아닌 필수 전략 |
| 양자컴퓨팅 | [quantum](2025/quantum.md) | 2025, 양자 컴퓨팅의 현실적 가치 탐색: NISQ를 넘어 하이브리드 시대로 |
| 공간컴퓨팅·AR/VR | [spatial](2025/spatial.md) | 공간 컴퓨팅, 생산성의 새 지평을 열다: 2025 산업 혁신의 핵심 동력 |
| 디지털트윈 | [digitaltwin](2025/digitaltwin.md) | AI가 불어넣는 생명, 2025년 자율 디지털 트윈의 비상 |
| 블록체인·Web3 | [blockchain](2025/blockchain.md) | 블록체인, '실망의 계곡' 넘어 '현실의 비탈'로: 2025년 엔터프라이즈 블록체인의 비상 |
| 로보틱스·자율주행 | [robotics](2025/robotics.md) | 2025, 로봇과 자율주행, 일상을 재설계하다: 인류의 새로운 동반자를 맞이하는 길 |
| 지속가능기술·그린IT | [sustainability](2025/sustainability.md) | 2025, IT의 그린 혁명: AI와 순환 경제로 탄소 발자국을 지우다 |
| 하이퍼오토메이션·RPA | [hyperautomation](2025/hyperautomation.md) | 2025, 비즈니스의 초능력: 하이퍼오토메이션으로 여는 지능형 자동화 시대 |

### 2026

| 주제 | 파일 | 첫 발표후보 |
|---|---|---|
| 생성형 AI·LLM | [genai](2026/genai.md) | AI, 동료를 넘어 파트너로: 2026, 자율 에이전트가 이끄는 초개인화 시대의 서막 |
| AI 에이전트 | [agentic](2026/agentic.md) | AI 에이전트, '디지털 동료'를 넘어 '자율적 협업자'로: 2026 비즈니스 혁신 전략 |
| AI엔지니어링·MLOps | [aiops](2026/aiops.md) | AI, 이제 '운영'이 핵심이다: LLMOps로 완성하는 엔터프라이즈 AI의 미래 |
| 멀티모달 AI | [multimodal](2026/multimodal.md) | 2026, 인간을 닮은 AI의 탄생: 멀티모달 AI, 새로운 지능의 지평을 열다 |
| SLM·온디바이스 | [slm](2026/slm.md) | 초개인화의 시작: 2026, 당신의 손안에서 깨어나는 온디바이스 AI 혁명 |
| AI규제·거버넌스 | [airegulation](2026/airegulation.md) | 2026, AI 시대의 나침반: 규제와 거버넌스로 '신뢰'를 설계하다 |
| 멀티/하이브리드 클라우드 | [cloud](2026/cloud.md) | 2026 클라우드 이정표: 멀티/하이브리드를 넘어선 자율 운영 플랫폼의 시대 |
| FinOps | [finops](2026/finops.md) | AI와 지속가능성을 입은 FinOps: 2026 클라우드 가치 극대화 전략 |
| 엣지·IoT | [edge](2026/edge.md) | 클라우드를 넘어선 지능: 2026 엣지 AI, 초연결 시대의 신(新) 심장 |
| 5G/6G 네트워크 | [network](2026/network.md) | 초연결 지능망, 6G의 서막: AI와 융합된 차세대 네트워크가 열 지능형 세상 |
| 데이터센터·GPU | [datacenter](2026/datacenter.md) | AI 시대의 심장, 2026 데이터센터: 전력·냉각·GPU 삼위일체 혁명과 지속 가능성 전략 |
| 사이버보안 | [security](2026/security.md) | AI 시대의 사이버 면역 시스템: 2026년 예측적 위협 인텔리전스와 CTEM 전략 |
| 제로트러스트 | [zerotrust](2026/zerotrust.md) | 경계 없는 신뢰, 경계 없는 비즈니스: 2026년 제로트러스트 아키텍처, 기업 생존의 핵심 전략 |
| 랜섬웨어·공급망 | [ransomware](2026/ransomware.md) | AI 시대의 랜섬웨어 블랙홀: 선제적 대응과 회복 탄력성 강화 전략 |
| IAM·인증 | [identity](2026/identity.md) | 아이덴티티, 2026년 새로운 보안 경계: 제로 트러스트와 패스워드리스로 열어가는 디지털 신뢰 |
| 양자내성암호 | [pqc](2026/pqc.md) | 양자 시대의 사이버 방패: 2026 PQC 전환 전략과 미래 보안 아키텍처 |
| 데이터패브릭·거버넌스 | [data](2026/data.md) | 2026, 데이터 복잡성의 해답: Data Fabric과 AI Governance로 여는 데이터 주권 시대 |
| 애널리틱스·BI | [analytics](2026/analytics.md) | AI, 데이터로 의사결정을 초월하다: 2026 결정형 AI, 기업 지능의 새로운 지평 |
| 실시간데이터 | [realtime](2026/realtime.md) | 2026, 찰나의 데이터가 곧 비즈니스다: 실시간 스트리밍으로 구현하는 초지능형 기업 |
| 플랫폼엔지니어링·DevEx | [platform](2026/platform.md) | AI 시대, 개발자의 초능력! 플랫폼 엔지니어링으로 완성하는 DevEx 혁명 |
| DevOps·DevSecOps | [devsecops](2026/devsecops.md) | AI가 이끄는 자율 DevOps: 2026, 지능형 파이프라인을 통한 개발 생산성 혁명 |
| 로우코드/노코드 | [lowcode](2026/lowcode.md) | AI가 개척하는 개발의 미래: 2026년 로우코드/노코드, 시민 개발자와의 시너지 전략 |
| 오픈소스·공급망 | [opensource](2026/opensource.md) | AI 시대의 소프트웨어 혈관 지키기: 2026년, 공급망 보안의 최전선을 말하다 |
| 양자컴퓨팅 | [quantum](2026/quantum.md) | 2026, 양자 대전환의 서막: NISQ를 넘어 실용적 가치로 |
| 공간컴퓨팅·AR/VR | [spatial](2026/spatial.md) | 후보 1: 2026, 공간 컴퓨팅, '현실을 확장'하여 '생산성을 혁신'하다: 산업 메타버스의 실용적 가치 탐구 |
| 디지털트윈 | [digitaltwin](2026/digitaltwin.md) | 현실을 초월한 비즈니스 혁신: 2026, 디지털 트윈과 산업 메타버스의 융합 전략 |
| 블록체인·Web3 | [blockchain](2026/blockchain.md) | 금융 혁명의 서막: 2026년, 토큰화된 실물 자산(RWAs)이 재편할 미래 금융 시장 |
| 로보틱스·자율주행 | [robotics](2026/robotics.md) | AI 시대의 새로운 동반자: 2026년 휴머노이드 로봇, 산업과 삶을 재정의하다 |
| 지속가능기술·그린IT | [sustainability](2026/sustainability.md) | \2026, 지속가능성의 엔진: AI와 그린 IT가 이끌 탄소 중립 디지털 혁명\ |
| 하이퍼오토메이션·RPA | [hyperautomation](2026/hyperautomation.md) | AI 시대를 넘어, 2026 하이퍼오토메이션이 여는 '초지능형 비즈니스 혁신' 전략 |

---

## 3. 별도 자료

- XGBoost 설명 (gemini): [xgboost/xgboost_gemini.md](xgboost/xgboost_gemini.md)
- XGBoost 설명 (Claude): [xgboost/xgboost_claude.md](xgboost/xgboost_claude.md)

_생성 스크립트: `research_gartner.sh` (run/status/stop/retry). 모델 gemini-2.5-flash, Vertex AI._

---

## 4. 면접 답변 자료 (interview/)

자기소개서(컨테이너 보안·시스템콜 이상탐지·커널 이해 → 풀스택·융합형 목표) 기반.

| 자료 | 파일 | 비고 |
|---|---|---|
| 핵심 답변 정제본(Claude) | [00_core_claude.md](interview/00_core_claude.md) | 1분자기소개·지원동기·인성5선·마지막말 |
| 1분 자기소개 | [01_self_intro.md](interview/01_self_intro.md) | 기본+변형2 |
| 지원동기 | [02_motivation.md](interview/02_motivation.md) | 기본+압축 |
| 인성질문 Q&A | [03_personality_qa.md](interview/03_personality_qa.md) | 20문항+ |
| 마지막 할말 | [04_closing.md](interview/04_closing.md) | 기본+변형2 |
| PT 면접 진행·전략 가이드 | [05_pt_guide.md](interview/05_pt_guide.md) | 구조·평가·체크리스트 |

## 5. PT 산업테마 개관 (pt_themes/)

| 분야 | 파일 |
|---|---|
| ai | [ai.md](pt_themes/ai.md) |
| bigdata | [bigdata.md](pt_themes/bigdata.md) |
| blockchain | [blockchain.md](pt_themes/blockchain.md) |
| fintech | [fintech.md](pt_themes/fintech.md) |
| mobility | [mobility.md](pt_themes/mobility.md) |
| metaverse_game | [metaverse_game.md](pt_themes/metaverse_game.md) |
| cloud | [cloud.md](pt_themes/cloud.md) |

## 6. PT 산업테마 심화 (pt_themes_deep/) — 세부주제별 8000자+ 장문

### ai

- [agent](pt_themes_deep/ai/agent.md) — AI 에이전트·에이전틱 AI (인공지능)
- [aiethics](pt_themes_deep/ai/aiethics.md) — AI 윤리·규제·거버넌스 (인공지능)
- [aiinfra](pt_themes_deep/ai/aiinfra.md) — AI 인프라·GPU·반도체 (인공지능)
- [genai](pt_themes_deep/ai/genai.md) — 생성형 AI·LLM (인공지능)
- [ondevice](pt_themes_deep/ai/ondevice.md) — 온디바이스 AI·SLM (인공지능)
- [rag](pt_themes_deep/ai/rag.md) — RAG·검색증강생성 (인공지능)

### bigdata

- [data_governance_quality](pt_themes_deep/bigdata/data_governance_quality.md) — 데이터 거버넌스·품질 (빅데이터)
- [dataeng](pt_themes_deep/bigdata/dataeng.md) — 데이터 엔지니어링·파이프라인 (빅데이터)
- [governance](pt_themes_deep/bigdata/governance.md) — 데이터 거버넌스·품질 (빅데이터)
- [lakehouse](pt_themes_deep/bigdata/lakehouse.md) — 데이터 레이크하우스 (빅데이터)
- [streaming](pt_themes_deep/bigdata/streaming.md) — 실시간 스트리밍 처리 (빅데이터)
- [vector_database](pt_themes_deep/bigdata/vector_database.md) — 벡터 데이터베이스 (빅데이터)
- [vectordb](pt_themes_deep/bigdata/vectordb.md) — 

### blockchain

- [blockchain_security_smart_contract_audit](pt_themes_deep/blockchain/blockchain_security_smart_contract_audit.md) — 블록체인 보안·스마트컨트랙트 감사 (블록체인)
- [chainsec](pt_themes_deep/blockchain/chainsec.md) — 블록체인 보안·스마트컨트랙트 감사 (블록체인)
- [defi](pt_themes_deep/blockchain/defi.md) — 디파이(DeFi) (블록체인)
- [l2](pt_themes_deep/blockchain/l2.md) — 확장성·레이어2 (블록체인)
- [rwa](pt_themes_deep/blockchain/rwa.md) — 실물자산 토큰화(RWA)·NFT (블록체인)
- [rwa_nft](pt_themes_deep/blockchain/rwa_nft.md) — 실물자산 토큰화(RWA)·NFT (블록체인)
- [security_audit](pt_themes_deep/blockchain/security_audit.md) — 블록체인 보안·스마트컨트랙트 감사 (블록체인)
- [stablecoin](pt_themes_deep/blockchain/stablecoin.md) — 스테이블코인·CBDC (블록체인)
- [stablecoin_cbdc](pt_themes_deep/blockchain/stablecoin_cbdc.md) — 스테이블코인·CBDC (블록체인)

### fintech

- [easy_payment_digital_wallet](pt_themes_deep/fintech/easy_payment_digital_wallet.md) — 간편결제·디지털지갑 (핀테크)
- [embedded](pt_themes_deep/fintech/embedded.md) — 임베디드 금융 (핀테크)
- [embedded_finance](pt_themes_deep/fintech/embedded_finance.md) — 임베디드 금융 (핀테크)
- [insurtech](pt_themes_deep/fintech/insurtech.md) — 인슈어테크 (핀테크)
- [mydata](pt_themes_deep/fintech/mydata.md) — 마이데이터·오픈뱅킹 (핀테크)
- [mydata_openbanking_extra](pt_themes_deep/fintech/mydata_openbanking_extra.md) — 마이데이터·오픈뱅킹 (핀테크)
- [pay](pt_themes_deep/fintech/pay.md) — 간편결제·디지털지갑 (핀테크)
- [regtech](pt_themes_deep/fintech/regtech.md) — 레그테크·이상거래탐지 (핀테크)
- [regtech_anomaly_detection](pt_themes_deep/fintech/regtech_anomaly_detection.md) — 레그테크·이상거래탐지 (핀테크)

### mobility

- [ad](pt_themes_deep/mobility/ad.md) — 
- [autonomous_driving](pt_themes_deep/mobility/autonomous_driving.md) — 자율주행 (모빌리티)
- [ev](pt_themes_deep/mobility/ev.md) — 전기차·배터리 (모빌리티)
- [ev_battery](pt_themes_deep/mobility/ev_battery.md) — 전기차·배터리 (모빌리티)
- [mobplatform](pt_themes_deep/mobility/mobplatform.md) — 모빌리티 플랫폼 MaaS (모빌리티)
- [uam](pt_themes_deep/mobility/uam.md) — 도심항공교통 UAM (모빌리티)
- [v2x](pt_themes_deep/mobility/v2x.md) — V2X·커넥티드카 (모빌리티)

### metaverse

- [blockchain_game_p2e_deepdive](pt_themes_deep/metaverse/blockchain_game_p2e_deepdive.md) — 블록체인 게임·P2E (메타버스·게임)
- [blockchaingame](pt_themes_deep/metaverse/blockchaingame.md) — 블록체인 게임·P2E (메타버스·게임)
- [digital_human](pt_themes_deep/metaverse/digital_human.md) — 디지털 휴먼·가상인간 (메타버스·게임)
- [digitalhuman](pt_themes_deep/metaverse/digitalhuman.md) — 디지털 휴먼·가상인간 (메타버스·게임)
- [engine](pt_themes_deep/metaverse/engine.md) — 게임 엔진·실시간 렌더링 (메타버스·게임)
- [gameai](pt_themes_deep/metaverse/gameai.md) — 게임 AI·생성형 콘텐츠 (메타버스·게임)
- [xr](pt_themes_deep/metaverse/xr.md) — XR·AR·VR 하드웨어 (메타버스·게임)

### cloud

- [cloud_native_kubernetes](pt_themes_deep/cloud/cloud_native_kubernetes.md) — 1. 개요와 큰 그림 — 무엇을 푸는가, 왜 지금 중요한가
- [cloudsec](pt_themes_deep/cloud/cloudsec.md) — 클라우드 보안 (클라우드)
- [edge](pt_themes_deep/cloud/edge.md) — 엣지 클라우드 (클라우드)
- [edge_cloud](pt_themes_deep/cloud/edge_cloud.md) — 엣지 클라우드 (클라우드)
- [finops](pt_themes_deep/cloud/finops.md) — FinOps·비용최적화 (클라우드)
- [k8s](pt_themes_deep/cloud/k8s.md) — 1. 개요와 큰 그림 — 무엇을 푸는가, 왜 지금 중요한가
- [multi_hybrid_cloud](pt_themes_deep/cloud/multi_hybrid_cloud.md) — 멀티·하이브리드 클라우드 (클라우드)
- [multi_hybrid_cloud_deepdive](pt_themes_deep/cloud/multi_hybrid_cloud_deepdive.md) — 멀티·하이브리드 클라우드 (클라우드)
- [multicloud](pt_themes_deep/cloud/multicloud.md) — 멀티·하이브리드 클라우드 (클라우드)
- [serverless](pt_themes_deep/cloud/serverless.md) — 서버리스 (클라우드)

