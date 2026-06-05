# 데이터 · 빅데이터 · 벡터DB — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
- 데이터는 인공지능(AI) 시대의 핵심 연료이자, 모든 비즈니스 혁신과 의사결정의 기반이 되는 가장 중요한 자산입니다.
- 폭증하는 데이터의 양과 복잡성 속에서, 신뢰할 수 있고 효율적인 데이터 관리 및 활용 아키텍처는 기업 경쟁력을 좌우하는 필수 요소가 되었습니다.
- 특히 생성형 AI의 등장과 함께, 비정형 데이터의 '의미'를 이해하고 실시간으로 활용하며, AI 에이전트가 자율적으로 데이터를 다루는 능력은 미래 기술 패러다임의 핵심 역량입니다.

## B. 반드시 아는 핵심 개념 사전

### 데이터 레이크하우스 (Data Lakehouse)
*   **(1) 한 줄 정의:** 데이터 레이크의 저비용 유연성과 데이터 웨어하우스의 신뢰성 높은 관리 기능을 결합한 단일 데이터 관리 플랫폼입니다.
*   **(2) 왜 나왔나:** 과거에는 분석용 정형 데이터를 위한 웨어하우스와 모든 원시 데이터를 저장하는 레이크를 별도로 운영하여 데이터 중복, 복잡한 파이프라인, 관리 비용 증가 및 분석 지연 문제가 발생했습니다.
*   **(3) 어떻게 동작하나:** S3나 ADLS Gen2 같은 저비용 객체 스토리지(데이터 레이크) 위에 '델타 레이크(Delta Lake)'나 '아파치 아이스버그(Apache Iceberg)' 같은 오픈소스 테이블 포맷을 적용하여, ACID 트랜잭션, 데이터 버전 관리, 스키마 강제와 같은 데이터 웨어하우스의 핵심 기능을 구현합니다.
*   **(4) 무엇이 달라지나:** 데이터 파이프라인이 단순화되어 데이터 분석가와 AI/ML 엔지니어가 하나의 플랫폼에서 신뢰할 수 있는 단일 데이터 소스를 사용해 BI 대시보드 작업과 머신러닝 모델 학습을 동시에 수행할 수 있습니다.

### 데이터 인 모션 (Data in Motion)
*   **(1) 한 줄 정의:** 데이터가 디스크에 저장된 후가 아니라, 생성되어 시스템 간에 흐르는 과정에서 실시간으로 처리하고 분석하는 개념입니다.
*   **(2) 왜 나왔나:** 하루나 한 시간 단위로 데이터를 모아서 처리하는 전통적인 '배치(Batch)' 방식으로는 실시간 상품 추천, 금융 사기 탐지, 스마트팩토리 설비 이상 감지처럼 즉각적인 반응이 필요한 비즈니스 요구를 충족시킬 수 없었습니다.
*   **(3) 어떻게 동작하나:** 아파치 카프카(Apache Kafka)와 같은 이벤트 스트리밍 플랫폼이 데이터가 발생하는 즉시 '이벤트 스트림' 형태로 수집하고, Flink나 Spark Streaming 같은 처리 엔진을 통해 실시간으로 분석, 필터링, 강화된 후 즉시 필요한 시스템으로 전달합니다.
*   **(4) 무엇이 달라지나:** 기업이 과거 데이터를 분석하여 사후에 대응하는 '수동적'인 자세에서 벗어나, 현재 일어나는 일을 즉시 파악하고 미래를 예측하여 '능동적'으로 대응할 수 있게 되며, 비즈니스 의사결정의 속도와 질을 근본적으로 바꿉니다.

### 벡터DB (Vector Database)
*   **(1) 한 줄 정의:** 텍스트, 이미지 등 비정형 데이터를 AI가 이해하는 숫자 배열(벡터)로 변환해 저장하고, 데이터 간 의미적 유사성을 기준으로 검색하는 데 특화된 데이터베이스입니다.
*   **(2) 왜 나왔나:** 기존 관계형 데이터베이스는 'apple'과 같은 정확한 키워드 검색에는 능하지만, '잘 익은 빨간 과일'처럼 의미는 같지만 표현이 다른 데이터는 찾지 못했습니다. AI 기술 발달로 '의미' 기반 검색 수요가 폭발적으로 증가하면서 기존 DB의 한계를 극복하기 위해 등장했습니다.
*   **(3) 어떻게 동작하나:** AI 임베딩 모델을 사용해 모든 데이터(텍스트, 이미지 등)를 고차원 공간의 한 점을 나타내는 벡터(예: 384차원의 숫자 배열)로 변환합니다. 의미가 비슷한 데이터들은 벡터 공간상에서 가까운 위치에 놓이게 되며, '근사 최근접 이웃(ANN)' 알고리즘을 사용해 벡터 공간에서 가장 가까운 거리에 있는 데이터 벡터들을 빠르게 찾아냅니다.
*   **(4) 무엇이 달라지나:** 키워드 검색의 패러다임을 '의미' 기반으로 바꾸어 추천 시스템의 정확도를 높이고, 이미지나 음성으로 검색하는 등 새로운 사용자 경험을 만들 수 있게 합니다.

### 데이터 거버넌스 (Data Governance)
*   **(1) 한 줄 정의:** 데이터의 생성부터 활용, 폐기까지 전 과정에 걸쳐 데이터의 품질과 보안, 접근성을 보장하기 위한 정책, 프로세스, 기술을 총망라하는 관리 체계입니다.
*   **(2) 왜 나왔나:** 기업에 데이터는 폭발적으로 쌓이지만, 어디에 어떤 데이터가 있는지 모르고 품질도 낮아 활용하지 못하는 '데이터 사일로' 문제가 심각해졌습니다. GDPR, 데이터 3법 등 국내외 규제 강화로 데이터를 체계적으로 관리하고 보호하지 않으면 법적, 재정적 리스크에 직면하게 되어 전사적인 관리 체계가 필수가 되었습니다.
*   **(3) 어떻게 동작하나:** 데이터 표준화, 품질 측정, 소유권 정의 등 관리 '규칙'을 만들고, '데이터 카탈로그'를 구축해 데이터 정보(위치, 의미, 소유자)를 등록하여 쉽게 찾고 이해하게 합니다. '데이터 계보(Data Lineage)' 추적을 통해 데이터 흐름을 파악하고, 직무에 따라 접근 권한을 차등 부여하여 보안을 강화합니다.
*   **(4) 무엇이 달라지나:** 데이터가 전사적인 '자산'으로 인식되며, 데이터 분석가는 신뢰할 수 있는 데이터를 찾아 헤매는 시간을 줄이고 분석에 집중합니다. 기업은 데이터 기반의 정확한 의사결정을 내리고, 데이터 관련 규제 리스크를 최소화하여 비즈니스 경쟁력을 높입니다.

### 검색증강생성 (RAG, Retrieval-Augmented Generation)
*   **(1) 한 줄 정의:** 대규모 언어 모델(LLM)이 답변을 생성하기 전에, 먼저 외부 데이터베이스에서 질문과 관련된 정확한 정보를 '검색(Retrieval)'해서, 그 내용을 '증강(Augmented)'하여 답변을 '생성(Generation)'하는 기술입니다.
*   **(2) 왜 나왔나:** LLM은 학습 데이터에 없는 최신 정보를 모르고, 내부망에만 있는 회사 기밀문서를 알 수 없으며, 가끔 사실이 아닌 내용을 그럴듯하게 지어내는 '환각' 현상을 일으켜 기업 환경에서 신뢰하고 사용하기 어려웠기 때문에, 정확하고 통제된 정보를 기반으로 답변하게 만드는 RAG 기술이 필요해졌습니다.
*   **(3) 어떻게 동작하나:** (1)사용자 질문을 벡터로 변환하고, (2)이 질문 벡터와 의미적으로 가장 유사한 문서들을 벡터DB에서 찾아낸 후, (3)찾아낸 문서 내용과 원래 질문을 조합하여 새로운 프롬프트를 만들고, (4)이 프롬프트를 LLM에게 전달하여 답변을 생성하게 합니다.
*   **(4) 무엇이 달라지나:** LLM이 최신 정보나 기업 내부 데이터를 기반으로 사실에 입각한 답변을 하도록 만들 수 있으며, 답변의 근거가 된 출처 문서를 함께 제시하여 신뢰도가 비약적으로 상승합니다. 이로 인해 LLM이 신뢰할 수 있는 '전문가 시스템'이나 '정보 검색 엔진'으로 활용될 수 있는 길이 열렸습니다.

### 아파치 아이스버그 (Apache Iceberg)
*   **(1) 한 줄 정의:** 거대한 데이터 호수에 저장된 파일들을 마치 데이터베이스의 테이블처럼 안정적으로 관리하고 사용할 수 있게 해주는 '오픈소스 테이블 형식' 규약입니다.
*   **(2) 왜 나왔나:** 기존 데이터 레이크는 수많은 파일을 직접 관리해야 해 데이터 수정이 어렵고, 여러 프로그램이 동시에 접근할 때 데이터가 깨지기 쉬웠습니다. 특정 회사의 기술에 종속될 위험도 컸습니다.
*   **(3) 어떻게 동작하나:** 데이터가 변경될 때마다 원본 파일을 바꾸는 대신, 변경 이력을 '스냅샷'이라는 별도 메타데이터 파일로 기록합니다. 모든 변경은 원자적으로 처리되어 데이터의 일관성이 보장되며, 스냅샷을 통해 특정 과거 시점의 데이터를 쉽게 조회(타임 트래블)하거나 복구할 수 있습니다.
*   **(4) 무엇이 달라지나:** 데이터 분석가나 엔지니어는 데이터 파일의 복잡한 위치나 구조를 신경 쓸 필요 없이, 익숙한 SQL로 테이블을 다루듯 데이터에 접근할 수 있습니다. 특정 분석 엔진이나 클라우드에 종속되지 않는 진정한 개방형 데이터 아키텍처 구축이 가능해집니다.

### MCP (Model Context Protocol)
*   **(1) 한 줄 정의:** AI 모델이 데이터베이스, API 등 다양한 외부 데이터 소스와 '표준화된 언어'로 대화하게 해주는 통신 규칙(프로토콜)입니다. AI 모델이 어떤 데이터든 가리지 않고 안전하게 접속할 수 있는 '만능 플러그' 역할을 합니다.
*   **(2) 왜 필요한가?**: 이전에는 AI가 특정 데이터베이스에 연결하려면 그 DB 전용 '통역사'(맞춤형 코드)가 필요했고, 데이터 소스가 늘어날수록 복잡성이 증가했습니다. 특히 스스로 판단하고 여러 데이터를 넘나들어야 하는 AI 에이전트에게는 치명적인 단점이었습니다.
*   **(3) 어떻게 동작하나?**: MCP 서버가 AI 모델과 데이터 소스 사이에 위치하여, AI 모델의 요청을 데이터 소스가 알아들을 수 있는 언어로 번역하고 결과를 AI 모델에게 돌려줍니다. 이 과정에서 누가, 언제, 어떤 데이터에 접근했는지 기록하고 권한을 통제하는 보안 기능도 수행합니다.
*   **(4) 무엇이 달라지나?**: AI 모델의 데이터 접근 복잡성이 줄어들고, 다양한 데이터 소스와의 상호운용성이 획기적으로 개선됩니다. 모든 접근이 표준화된 프로토콜을 통해 이루어져 중앙화된 보안 및 감사 관리가 가능해집니다.

### 컨텍스트 아키텍처 (Context Architecture)
*   **(1) 한 줄 정의:** AI가 대화의 맥락이나 과거의 경험을 '기억'하고 활용할 수 있도록 지원하는 데이터 구조 및 시스템입니다. 단순 질의응답을 넘어, AI가 사용자와의 장기적인 관계 속에서 학습하고 똑똑해지게 만드는 '두뇌의 기억장치'와 같습니다.
*   **(2) 왜 필요한가?**: 기존의 RAG 방식은 대화할 때마다 매번 새로운 정보를 처음부터 다시 찾아보는 '단기 기억상실'과 비슷하여 연속적인 작업이나 깊이 있는 대화가 어려웠습니다. AI 에이전트가 복잡한 임무를 수행하려면, 과거의 성공과 실패를 기억하고 다음 행동에 반영할 수 있어야 합니다.
*   **(3) 어떻게 동작하나?**: 사용자와의 대화 내용, AI의 판단, 작업 결과 등 모든 상호작용을 '에이전트 메모리'라는 곳에 체계적으로 저장합니다. 정보의 중요도에 따라 단기 기억과 장기 기억으로 나누어 관리하고, 지식 그래프(Knowledge Graph) 같은 기술로 정보 간의 관계를 파악합니다. AI는 이 메모리를 뒤져 관련 맥락을 찾아 답변이나 행동을 생성합니다.
*   **(4) 무엇이 달라지나?**: AI가 단순 정보 검색을 넘어 장기적인 맥락을 이해하고, 과거 경험을 바탕으로 학습하며, 일관성 있고 고도화된 작업을 수행할 수 있게 됩니다. 이는 AI 에이전트의 진정한 지능화를 가능하게 합니다.

## C. 연도별 흐름 한눈에
- **2021:** 클라우드 데이터 플랫폼이 주류화되고 레이크하우스, 데이터 인 모션, 데이터 메시 논의가 시작된 해. ([2021.md](2021.md))
- **2022:** 데이터 플랫폼 시장의 양강 구도 심화, 데이터 거버넌스 부상, 벡터DB가 AI 발달과 함께 기반을 다진 해. ([2022.md](2022.md))
- **2023:** 생성형 AI 확산과 RAG 표준화로 벡터DB가 핵심 인프라로 급부상하며 데이터 인프라가 재편된 해. ([2023.md](2023.md))
- **2024:** 개방성(아이스버그 전쟁)과 AI 통합이 핵심 화두였으며, 모든 데이터는 AI 활용을 전제로 관리되어야 한다는 패러다임 전환이 본격화된 해. ([2024.md](2024.md))
- **2025:** AI 에이전트가 데이터 인프라의 주된 소비자로 부상하고, 레이크하우스가 OLTP 영역까지 흡수하며 통합 데이터 플랫폼으로 진화한 해. ([2025.md](2025.md))
- **2026:** "RAG 이후" 패러다임(컨텍스트 아키텍처, 에이전트 메모리)이 부상하고 MCP가 표준화되며, 벡터 데이터가 기존 DB에 통합되는 등 AI-데이터 상호작용의 심화가 이루어진 해. ([2026.md](2026.md))

## D. PT 발표 주제 추천

1.  **제목: RAG 이후의 데이터 패러다임: 컨텍스트 아키텍처와 에이전트 메모리**
    *   **핵심 메시지:** AI 에이전트의 진정한 지능화를 위한, RAG를 넘어선 컨텍스트 중심의 데이터 관리 전략을 제시합니다.
    *   **발표 3단 구조:**
        *   **문제:** 기존 RAG는 상태가 없어(stateless) AI 에이전트의 맥락 이해 및 연속적인 작업 수행에 명백한 한계를 보입니다.
        *   **근거:** 이러한 문제를 해결하기 위해 대화의 흐름과 과거 경험을 '기억'하는 에이전트 메모리, 지식 그래프를 활용한 GraphRAG 등 컨텍스트 아키텍처가 등장했습니다.
        *   **제언:** 기업의 AI는 이제 단순 정보 검색을 넘어, 장기적인 맥락을 이해하는 '기억하는 AI'로 진화해야 하며, 이를 위한 컨텍스트 아키텍처 도입이 시급합니다.

2.  **제목: 오픈 레이크하우스의 완성: Apache Iceberg와 Polaris로 본 데이터 아키텍처의 미래**
    *   **핵심 메시지:** Iceberg v3 및 Apache Polaris를 통해 완성 단계에 접어든 오픈 레이크하우스 아키텍처의 기술적 진보와 비즈니스적 가치를 설명합니다.
    *   **발표 3단 구조:**
        *   **문제:** 기존 데이터 웨어하우스는 비싸고 경직됐으며, 데이터 레이크는 관리가 어려워 '데이터 늪'이 되기 쉬웠습니다.
        *   **근거:** Apache Iceberg는 데이터 레이크에 트랜잭션, 버전 관리 등 웨어하우스의 기능을 부여하고, Polaris는 이 모든 것을 중앙에서 관리하여 일관성을 보장합니다.
        *   **제언:** 특정 벤더에 종속되지 않는 오픈 레이크하우스를 구축하여 데이터 민주화를 실현하고, AI 시대에 필요한 유연하고 확장 가능한 데이터 플랫폼의 기반을 마련해야 합니다.

3.  **제목: MCP, AI 데이터 접근의 USB-C: 표준화가 가져올 혁신과 보안 과제**
    *   **핵심 메시지:** AI 시대 데이터 통합의 핵심인 MCP의 중요성을 분석하고, 표준화된 접근 방식이 가져올 효율성 증대 및 새로운 보안 고려 사항을 제안합니다.
    *   **발표 3단 구조:**
        *   **문제:** AI 모델마다 데이터 소스에 접근하는 방식이 제각각이라 개발 복잡성이 높고, 중앙화된 통제가 어려워 보안에 취약합니다.
        *   **근거:** MCP는 AI 모델과 데이터 소스 간의 통신을 표준화하여, 마치 USB-C 포트처럼 어떤 모델이든 쉽게 연결하게 해주고, 이 과정에서 접근 제어와 감사를 수행합니다.
        *   **제언:** 모든 데이터 접근이 MCP를 통해 이루어지도록 정책을 수립하고, 이를 통해 데이터 거버넌스를 강화하며 새로운 보안 경계(Perimeter)를 구축해야 합니다.

4.  **제목: 신뢰할 수 있는 AI를 위한 차세대 이상탐지 시스템 구축 방안**
    *   **핵심 메시지:** RAG 기술을 시스템 로그 분석에 적용하여, 알려지지 않은 위협까지 탐지하는 지능형 이상탐지 시스템을 구축할 수 있습니다.
    *   **발표 3단 구조:**
        *   **문제:** 기존의 룰 기반 보안 시스템은 복잡하고 새로운 형태의 공격을 탐지하는 데 한계가 명확합니다.
        *   **근거:** RAG는 LLM이 방대한 시스템 로그의 ‘의미’와 ‘맥락’을 이해하게 함으로써, 단순 키워드 매칭을 뛰어넘는 분석을 가능하게 합니다.
        *   **제언:** 제가 경험한 시스템 콜 관측 데이터와 같은 정형/비정형 로그를 벡터화하고, RAG를 통해 자연어로 시스템의 이상 징후를 질문하고 근거를 찾는 지능형 보안 관제 시스템을 도입해야 합니다.

## E. 모범답안집

*   **예상 질문 1: 데이터 레이크와 데이터 웨어하우스의 차이점을 설명하고, 레이크하우스가 이 둘의 한계를 어떻게 극복하는지 설명해 주십시오.**
    네, 데이터 웨어하우스는 분석에 용이하도록 잘 정제된 '정형 데이터'를 저장하는 깨끗한 창고와 같고, 데이터 레이크는 형태와 상관없이 모든 데이터를 원본 그대로 쌓아두는 거대한 호수와 같습니다. 레이크하우스는 이 둘의 장점을 합친 것인데요. 데이터 레이크의 저비용 저장 공간 위에 데이터 웨어하우스의 신뢰성과 관리 기능을 더한 아키텍처입니다. 제가 컨테이너의 시스템 콜 로그를 분석해 이상행위를 탐지하는 프로젝트를 했을 때, 비정형적인 로그 데이터는 '레이크'에 가깝고, 여기서 유의미한 위협 패턴을 찾기 위한 분석은 '웨어하우스'의 역할이었습니다. 레이크하우스는 이렇게 하나의 저장소에서 데이터의 유연성과 신뢰성을 모두 확보하여, 데이터 파이프라인의 복잡성을 줄이고 더 빠른 분석을 가능하게 하는 핵심적인 해결책이라고 생각합니다.

*   **예상 질문 2: '데이터 인 모션'의 중요성이 부각되는 이유는 무엇이며, 실시간 데이터 처리가 필요한 비즈니스 사례를 본인의 경험과 연결하여 설명해 주십시오.**
    네, '데이터 인 모션'은 데이터가 저장되기를 기다리지 않고, 흐르는 과정에서 즉시 처리해 가치를 만드는 것을 의미합니다. 이는 하루 단위로 처리하던 기존 배치 방식으로는 불가능했던 즉각적인 의사결정을 가능하게 하기 때문에 중요합니다. 제가 수행했던 컨테이너 보안 프로젝트가 '데이터 인 모션'의 좋은 예시라고 생각합니다. 커널에서 발생하는 초당 수만 개의 시스템 콜 이벤트를 실시간 스트림으로 간주하고, 이 데이터가 디스크에 저장되기도 전에 패턴을 분석해 비정상 행위를 즉시 탐지해야 했습니다. 이처럼 즉각적인 대응이 생명인 보안 관제, 금융 사기 탐지, 실시간 추천 시스템 분야에서 '데이터 인 모션'의 가치는 더욱 커질 것입니다.

*   **예상 질문 3: 데이터 거버넌스에서 데이터 계보(Lineage)가 왜 중요하며, 본인의 경험과 관련지어 설명해본다면?**
    네, 데이터 계보는 데이터의 신뢰도를 보증하고 문제 발생 시 원인을 빠르게 파악할 수 있게 해주는 '족보'와 같기 때문에 매우 중요합니다. 저는 컨테이너 환경에서 시스템 콜의 흐름을 동적으로 관측하여 비정상 행위를 탐지하는 프로젝트를 수행한 경험이 있습니다. 이때 어떤 프로세스가 어떤 시스템 콜을 순서대로 호출했는지 그 '계보'를 추적하는 것이 이상 행위의 근원을 찾는 데 결정적이었습니다. 데이터 계보도 마찬가지로, 데이터가 어떤 원천에서 생성되어 어떤 변환 과정을 거쳐 현재의 분석에 사용되었는지 그 흐름을 추적할 수 있어야만 데이터의 신뢰성을 담보하고, 분석 결과에 오류가 발생했을 때 근본 원인을 찾아 해결할 수 있다고 생각합니다.

*   **예상 질문 4: RAG, 임베딩, 벡터DB 세 가지 기술의 관계를 비전공자도 이해하기 쉽게 설명해 보세요.**
    네, 세 기술은 '유능한 전문 비서'를 만드는 데 필요한 핵심 도구 세트라고 할 수 있습니다. 먼저 **임베딩**은 세상의 모든 정보를 컴퓨터가 이해할 수 있는 고유한 '숫자 좌표'로 바꿔주는 기술입니다. '사과'와 '배'는 비슷한 과일이니 좌표 공간에서 가까운 곳에, '자동차'는 전혀 다르니 아주 먼 곳에 배치하는 식입니다. **벡터DB**는 이렇게 만들어진 수많은 좌표들을 효율적으로 저장하고 검색할 수 있는 특별한 '디지털 도서관'입니다. 마지막으로 **RAG**는 이 도서관을 활용해 비서가 똑똑하게 일하는 '방식'입니다. 사용자가 질문을 하면, 비서는 먼저 질문의 핵심을 '좌표'로 변환해 도서관(벡터DB)에서 가장 관련 있는 자료들을 몇 초 만에 찾아옵니다. 그리고 그 자료들을 근거로 삼아 가장 정확하고 신뢰도 높은 답변을 생성해 사용자에게 전달하는 것입니다.

*   **예상 질문 5: 본인이 경험한 컨테이너 보안, 시스템 콜 동적 관측 기술을 RAG 시스템의 안정성과 보안을 높이는 데 어떻게 적용할 수 있을까요?**
    네, 제 경험을 활용하면 RAG 시스템의 각 구성요소가 허가된 동작만 수행하도록 '행위 기반 이상 탐지 시스템'을 구축하여 보안과 안정성을 크게 높일 수 있습니다. RAG 시스템의 데이터 처리 파이프라인이나 벡터DB 쿼리 엔진을 컨테이너로 실행하고, 각 컨테이너에서 발생하는 시스템 콜을 동적으로 관측합니다. 정상적인 RAG 워크플로우에서 발생하는 시스템 콜 패턴, 예를 들어 '특정 모델 파일 읽기'나 '정해진 DB 주소로의 통신' 등을 '정상 행위 프로파일'로 정의합니다. 만약 이 프로파일에서 벗어나는 비정상적인 시스템 콜, 가령 민감한 설정 파일에 접근하거나 허가되지 않은 외부 IP로 데이터를 전송하려는 시도가 탐지되면, 이를 즉시 차단하고 알림을 보낼 수 있습니다. 이는 제로데이 공격이나 내부 데이터 유출 시도 같은 알려지지 않은 위협까지 탐지할 수 있는 강력한 방어 체계가 될 것입니다.

*   **예상 질문 6: SSAFY에서 프로젝트를 한다면, 어떤 데이터를 벡터화해서 어떤 문제를 풀어보고 싶나요?**
    저는 제가 경험했던 시스템 로그 데이터를 벡터화하여 ‘차세대 지능형 보안 관제 시스템’을 개발해보고 싶습니다. 기존의 룰 기반 탐지 방식은 알려지지 않은 공격에 취약합니다. 대신, 정상 상태일 때의 방대한 시스템 콜 로그나 네트워크 트래픽 로그를 문장처럼 취급하여 벡터 DB에 저장합니다. 그 후 실시간으로 발생하는 로그를 벡터로 변환해 기존 정상 로그 벡터들과의 유사도를 측정하여, 평균 유사도가 낮은, 즉 ‘의미적으로 낯선’ 행위가 발생했을 때 이를 이상 징후로 탐지하는 것입니다. 이는 복잡한 클라우드 환경에서 발생할 수 있는 잠재적 위협을 조기에 발견하는 데 효과적인 해결책이 될 것입니다.

*   **예상 질문 7: AI 에이전트가 데이터베이스를 자동으로 대량 생성할 때 발생할 수 있는 가장 심각한 보안 위협은 무엇이며, 본인의 컨테이너 보안 프로젝트 경험을 바탕으로 어떻게 대응할 수 있을지 설명해주세요.**
    가장 심각한 위협은 통제되지 않는 '유령 데이터베이스'의 출현이라고 생각합니다. 제가 컨테이너 보안 연구 당시, 잠깐 실행되고 사라지는 수많은 컨테이너의 행위를 추적하고 이상탐지를 하는 것이 어려웠던 것과 같은 문제입니다. AI 에이전트가 마구 생성한 DB 중 악의적인 코드를 실행하거나 민감한 정보를 외부로 유출하는 '악성 컨테이너' 같은 DB가 숨어있을 수 있습니다. 이에 대응하기 위해, 저는 컨테이너의 시스템 콜을 관측했던 경험을 활용하여 DB 생성 및 접근과 관련된 핵심 시스템 콜 패턴을 정의하고, 이를 실시간으로 모니터링하는 시스템을 구축하고 싶습니다. 정상적인 에이전트의 DB 생성 패턴에서 벗어나는 이상행위를 즉시 탐지하고, 해당 DB를 자동으로 격리 및 삭제하는 '동적 이상탐지 거버넌스' 체계가 효과적인 해결책이 될 것입니다.

*   **예상 질문 8: MCP가 왜 "AI의 USB-C"로 불리는지 설명하고, 보안 관점에서의 장단점을 짚어주세요.**
    MCP가 'AI의 USB-C'로 불리는 이유는, 제각각이던 AI 모델과 데이터 소스 간의 연결 방식을 하나의 표준으로 통일해 어떤 조합으로든 손쉽게 연결할 수 있는 '상호운용성'을 제공하기 때문입니다. 보안 관점에서 가장 큰 장점은 모든 데이터 접근 요청이 MCP라는 단일 지점을 통하게 되므로, 중앙에서 강력한 접근 제어와 감사 로깅이 가능하다는 것입니다. 제가 리눅스 커널의 시스템 콜 인터페이스를 통해 모든 프로세스의 동작을 감시했던 것처럼, MCP는 데이터 접근의 '시스템 콜'과 같은 역할을 수행하며 새로운 보안 경계를 만들 수 있습니다. 반면, 모든 트래픽이 몰리는 만큼 MCP 서버 자체가 공격의 표적이 되는 단일 장애점(SPOF)이 될 수 있다는 단점이 있습니다. 따라서 MCP 서버 자체의 안정성과 보안을 철저히 강화하는 것이 무엇보다 중요합니다.

*   **예상 질문 9: 오픈 레이크하우스 아키텍처가 개발자 개인의 업무 생산성에 구체적으로 어떤 긍정적인 영향을 줄 수 있을까요?**
    오픈 레이크하우스는 개발자가 데이터의 '위치'나 '형식'에 대한 고민 없이 '내용'에만 집중하게 해준다는 점에서 생산성을 크게 높여줍니다. 과거에는 분석하려는 데이터가 데이터베이스, 로그 파일, 클라우드 스토리지 등 제각각 흩어져 있으면, 개발자가 직접 각기 다른 방식으로 데이터를 읽고 변환하는 코드를 짜야 했습니다. 하지만 Apache Iceberg 기반의 레이크하우스에서는 모든 데이터가 마치 하나의 거대한 SQL 테이블처럼 보이게 됩니다. 따라서 Python 코드에서든, Spark 작업에서든, BI 툴에서든 일관된 방식으로 데이터를 바로 조회하고 분석할 수 있어, 데이터 준비에 드는 시간을 획기적으로 줄이고 핵심적인 비즈니스 로직 개발에 더 많은 시간을 쓸 수 있습니다.

*   **예상 질문 10: RAG의 한계가 무엇이기에 "RAG 이후"라는 말까지 나온다고 생각하나요?**
    네, RAG는 매번 독립적인 검색을 수행하는 '무상태(stateless)' 방식이라는 근본적인 한계 때문에 "RAG 이후"가 논의된다고 생각합니다. 이는 정적인 정보를 찾아주는 데는 뛰어나지만, 연속적인 대화의 맥락을 기억하거나 과거의 피드백을 통해 스스로 학습하는 데는 부족합니다. 제가 컨테이너의 시스템 콜을 관측해 이상행위를 탐지하는 프로젝트를 했을 때, 단일 시스템 콜만으로는 정상 여부를 판단하기 어려웠습니다. 과거에 호출되었던 시스템 콜들의 순서와 패턴, 즉 '맥락'을 알아야만 비정상적인 흐름을 감지할 수 있었습니다. 이처럼 AI 에이전트 역시 대화의 전체적인 흐름이라는 '맥락'을 기억하지 못하면 진정한 지능을 발휘하기 어렵기에, 상태와 기억을 관리하는 컨텍스트 아키텍처가 RAG의 다음 단계로 주목받는 것입니다.

## F. 지원자 경험 연계 포인트

*   **컨테이너 보안/시스템 콜 이상탐지 및 레이크하우스/데이터 인 모션:** 컨테이너의 시스템 콜 로그와 같은 비정형 실시간 데이터를 '데이터 인 모션'으로 간주하고 레이크하우스에 저장, '이상행위 탐지'를 위한 분석을 수행하는 것은 웨어하우스의 역할과 유사함을 강조.
*   **Linux 커널 이해 및 데이터 계보/OLTP-OLAP 통합:** 시스템 콜의 흐름을 추적하여 이상 행위의 '계보'를 찾는 경험을 바탕으로 데이터의 출처와 가공 과정을 추적하는 '데이터 계보'의 중요성 설명. 커널의 I/O 스케줄러처럼 OLTP-OLAP 통합 시 자원 경합 해결의 기술적 난이도를 설명하며 전문성 부각.
*   **시스템 콜 동적 관측 기반 이상탐지 및 AI 시대 보안/RAG 시스템 보안:** AI 에이전트의 데이터 접근, 시스템 호출 등의 행위를 실시간 모니터링하여 '행위 프로파일'을 만들고, 이를 벗어나는 이상행위를 탐지하여 차단하는 방식으로 RAG 시스템 또는 MCP 서버의 보안을 강화하는 데 기여할 수 있음을 강조.
*   **풀스택/코딩테스트 역량 확장 및 SSAFY 프로젝트:** SSAFY에서 Python/Django 기반 웹 서비스 개발 시 시스템 로그 데이터를 벡터화하여 '차세대 지능형 보안 관제 시스템' 구축, 또는 'AI 학습 조교' 기능 구현에 벡터DB와 RAG를 적용하여 실제 문제 해결 역량을 보여줄 수 있음.
*   **Linux 커널 이해 및 벡터DB/Postgres:** 리눅스 커널 수준에서 자료구조의 효율성이 시스템 성능에 미치는 영향을 경험한 관점에서, B-Tree와 같은 관계형 DB 인덱스와 HNSW와 같은 벡터DB 인덱스의 동작 원리를 비교 설명하며 기술적 깊이를 드러냄. Databricks/Snowflake가 Postgres를 인수한 이유를 강력한 확장성, 신뢰성, AI 친화적 생태계(pgvector)와 연결하며, 오픈소스 생태계에 대한 이해를 어필.

## G. 빠른 암기 카드

| 키워드 그룹 | 키워드 | 설명/수치 | 연도 | 출처 |
|---|---|---|---|---|
| **기업/제품** | Databricks | 2021년 기업 가치 $380억, 2024년 Tabular 인수, 2024년 기업 가치 $620억, 2025년 Neon 인수, 2025년 매출 런레이트 $40억 돌파, 2026년 IPO 전망 | 2021-2026 | SiliconANGLE, CNBC, TechCrunch |
| | Snowflake | 2021년 연 매출 $10억 돌파, 2022년 매출 $20억 돌파 전망, 2024년 Polaris Catalog 공개, 2025년 Crunchy Data 인수 | 2021-2025 | Tietoevry, SaaStr, VentureBeat, TechCrunch |
| | Confluent | 2021년 나스닥 상장 (시총 약 $114억), 잠재 시장(TAM) 최대 $500억 추정 | 2021 | CNBC, TechTarget |
| | Pinecone | 2023년 시리즈 B $1억 유치, 기업 가치 $7.5억 | 2023 | TechCrunch |
| | Weaviate | 2022년 시리즈 B $5,000만 유치 | 2022 | Pinecone |
| | Neon | 2025년 Databricks에 약 $10억 인수. AI 에이전트 워크로드의 80% 이상이 DB 생성 | 2025 | Databricks, VentureBeat |
| | Crunchy Data | 2025년 Snowflake에 약 $2.5억 인수 | 2025 | TechCrunch |
| **개념/아키텍처** | 레이크하우스 | 데이터 레이크 + 데이터 웨어하우스 통합 아키텍처 | 2021-2026 | Databricks |
| | 데이터 인 모션 | 실시간 데이터 스트리밍 처리 | 2021 | Confluent |
| | 벡터DB | 비정형 데이터의 의미 기반 검색 특화 DB | 2022-2026 | Weaviate, Pinecone |
| | 데이터 거버넌스 | 데이터 전 과정 관리 체계 (품질, 보안, 규제 준수) | 2022 | OECD |
| | RAG (검색증강생성) | LLM 환각 보완, 외부 정보 검색 후 답변 생성 | 2022-2026 | Towards Data Science |
| | Apache Iceberg | 오픈소스 테이블 포맷, 레이크하우스의 표준 | 2024-2026 | Databricks, Snowflake |
| | MCP (Model Context Protocol) | AI 모델과 데이터 소스 간 표준 통신 프로토콜, "AI의 USB-C" | 2026 | Oracle, VentureBeat |
| | 컨텍스트 아키텍처 | AI의 대화 맥락/과거 경험 '기억', 에이전트 메모리 기반 | 2026 | VentureBeat |
| | 하이브리드 검색 | 키워드 검색 + 벡터 검색 결합 | 2026 | VentureBeat |
| **시장 수치** | 데이터 시장 규모 | 2022년 기준 $200억 이상 추정 | 2022 | SaaStr |
| | 생성형 AI 시장 | 2023년 기준 약 $1,100억 규모 추정 | 2023 | SiliconANGLE |
| | 검색 최적화 투자 | 2026년 IT 예산 중 19% → 28.9% 상승 추정 | 2026 | VentureBeat |
| | 하이브리드 검색 도입 | 2026년 1분기 도입 의향 10.3% → 33.3% 증가 추정 | 2026 | VentureBeat |
| | 벡터DB 시장 전망 | 2028년까지 약 $50억 규모 성장 전망 | 2026 | VentureBeat |

## H. 참고
*   [SiliconANGLE, 2021-02-01 — Massive $1B infusion for Databricks takes aim at IPO, rival Snowflake](https://siliconangle.com/2021/02/01/massive-1b-infusion-databricks-takes-aim-ipo-rival-snowflake/)
*   [CNBC, 2021-06-24 — Confluent climbs 26% after raising $828 million in IPO](https://www.cnbc.com/2021/06/24/confluent-climbs-26percent-after-raising-828-million-in-ipo.html)
*   [TechTarget, 2021-06 — Confluent goes IPO as Kafka event streaming goes mainstream](https://www.techtarget.com/searchdatamanagement/news/252502989/Confluent-goes-IPO-as-Kafka-event-streaming-goes-mainstream)
*   [Databricks Blog, 2020-09-10 — Diving Deep into the Inner Workings of the Lakehouse and Delta Lake](https://www.databricks.com/blog/2020/09/10/diving-deep-into-the-inner-workings-of-the-lakehouse-and-delta-lake.html)
*   [Tietoevry, 2021-09 — Data lakes and warehouses: Databricks vs. Snowflake](https://www.tietoevry.com/en/blog/2021/09/data-lakes-and-warehouses-databricks-snowflake/)
*   Pinecone, 2023, "Weaviate, 투자 유치 및 성장", [https://www.pinecone.io/lp/weaviate/](https://www.pinecone.io/lp/weaviate/)
*   SaaStr, 2022, "Databricks vs Snowflake ARR 비교", [https://www.saastr.com/databricks-vs-snowflake-at-5b-arr-same-revenue-2x-valuation-gap-heres-why/](https://www.saastr.com/databricks-vs-snowflake-at-5b-arr-same-revenue-2x-valuation-gap-heres-why/)
*   Wing VC, 2022, "Databricks와 Snowflake 재무 비교", [https://www.wing.vc/content/comparing-the-financials-of-databricks-and-snowflake](https://www.wing.vc/content/comparing-the-financials-of-databricks-and-snowflake)
*   주OECD 대한민국 대표부, 2022, "데이터 거버넌스 보고서", [https://overseas.mofa.go.kr/oecd-ko/brd/m_20806/view.do?seq=402&page=1&srchFr=&srchTo=&srchTp=0&srchWord=](https://overseas.mofa.go.kr/oecd-ko/brd/m_20806/view.do?seq=402&page=1&srchFr=&srchTo=&srchTp=0&srchWord=)
*   Towards Data Science, 2022, "RAG with ChatGPT and LangChain", [https://towardsdatascience.com/hitchhikers-guide-to-rag-with-chatgpt-api-and-langchain/](https://towardsdatascience.com/hitchhikers-guide-to-rag-with-chatgpt-api-and-langchain/)
*   Databricks, 2022, "데이터 거버넌스 개요", [https://www.databricks.com/discover/data-governance](https://www.databricks.com/discover/data-governance)
*   TechCrunch, 2023-04-27 — Pinecone Drops $100M Investment on $750M Valuation as Vector Database Demand Grows, [https://techcrunch.com/2023/04/27/pinecone-drops-100m-investment-on-750m-valuation-as-vector-database-demand-grows/](https://techcrunch.com/2023/04/27/pinecone-drops-100m-investment-on-750m-valuation-as-vector-database-demand-grows/)
*   Pinecone Blog, 2023-04-27 — Pinecone Series B: Building long-term memory for AI, [https://www.pinecone.io/blog/series-b/](https://www.pinecone.io/blog/series-b/)
*   TechCrunch, 2023-06-26 — Databricks picks up MosaicML, an OpenAI competitor, for $1.3B, [https://techcrunch.com/2023/06/26/databricks-picks-up-mosaicml-an-openai-competitor-for-1-3b/](https://techcrunch.com/2023/06/26/databricks-picks-up-mosaicml-an-openai-competitor-for-1-3b/)
*   InfoWorld, 2023 — Using PostgreSQL as a vector database in RAG, [https://www.infoworld.com/article/3516109/using-postgresql-as-a-vector-database-in-rag.html](https://www.infoworld.com/article/3516109/using-postgresql-as-a-vector-database-in-rag.html)
*   Towards Data Science, 2023 — Hitchhiker’s Guide to RAG with ChatGPT API and Langchain, [https://towardsdatascience.com/hitchhikers-guide-to-rag-with-chatgpt-api-and-langchain/](https://towardsdatascience.com/hitchhikers-guide-to-rag-with-chatgpt-api-and-langchain/)
*   SiliconANGLE, 2023-04-27 — Pinecone raises $100M as generative AI drives demand for vector database technology, [https://siliconangle.com/2023/04/27/pinecone-raises-100m-generative-ai-drives-demand-vector-database-technology/](https://siliconangle.com/2023/04/27/pinecone-raises-100m-generative-ai-drives-demand-vector-database-technology/)
*   MosaicML Blog, 2023-05-05 — Introducing MPT-7B: A New Standard for Open-Source, Commercially Usable LLMs, [https://www.mosaicml.com/blog/mpt-7b](https://www.mosaicml.com/blog/mpt-7b)
*   Databricks, 2024-06-04 — Tabular 인수 발표 ([https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-tabular-company-founded-original-creators](https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-tabular-company-founded-original-creators))
*   CNBC, 2024-06-04 — Databricks의 Tabular 인수 ([https://www.cnbc.com/2024/06/04/databricks-is-buying-data-optimization-startup-tabular.html](https://www.cnbc.com/2024/06/04/databricks-is-buying-data-optimization-startup-tabular.html))
*   VentureBeat, 2024-06 — Snowflake Polaris 발표 ([https://venturebeat.com/data-infrastructure/snowflake-unveils-polaris-a-vendor-neutral-open-catalog-implementation-of-apache-iceberg](https://venturebeat.com/data-infrastructure/snowflake-unveils-polaris-a-vendor-neutral-open-catalog-implementation-of-apache-iceberg))
*   Snowflake Docs, 2024-10-18 — Open Catalog GA ([https://docs.snowflake.com/en/release-notes/2024/other/2024-10-18-snowflake-open-catalog-ga](https://docs.snowflake.com/en/release-notes/2024/other/2024-10-18-snowflake-open-catalog-ga))
*   Databricks, 2024-12-17 — 시리즈 J 100억 달러 ([https://www.databricks.com/company/newsroom/press-releases/databricks-raising-10b-series-j-investment-62b-valuation](https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-tabular-company-founded-original-creators))
*   CNBC, 2024-12-17 — Databricks 620억 달러 밸류에이션 ([https://www.cnbc.com/2024/12/17/databricks-valued-at-62-billion-from-10-billion-financing.html](https://www.cnbc.com/2024/12/17/databricks-valued-at-62-billion-from-10-billion-financing.html))
*   TechCrunch, 2024-08-14 — Tabular 인수가 약 20억 달러 보도 ([https://techcrunch.com/2024/08/14/databricks-reportedly-paid-2-billion-in-tabular-acquisition/](https://techcrunch.com/2024/08/14/databricks-reportedly-paid-2-billion-in-tabular-acquisition/))
*   Databricks, 2025-05-14 — Neon 인수 발표 [https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems](https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems)
*   VentureBeat, 2025-05 — Neon 인수의 의미 [https://venturebeat.com/data-infrastructure/the-1-billion-database-bet-what-databricks-neon-acquisition-means-for-your-ai-strategy](https://venturebeat.com/data-infrastructure/the-1-billion-database-bet-what-databricks-neon-acquisition-means-for-your-ai-strategy)
*   TechCrunch, 2025-06-02 — Snowflake의 Crunchy Data 인수 [https://techcrunch.com/2025/06/02/snowflake-to-acquire-database-startup-crunchy-data/](https://techcrunch.com/2025/06/02/snowflake-to-acquire-database-startup-crunchy-data/)
*   businesswire, 2025-06-02 — Snowflake Crunchy Data 인수 공식 [https://www.businesswire.com/news/home/20250602455530/en/Snowflake-Acquires-Crunchy-Data-to-Bring-Enterprise-Ready-Postgres-Offering-to-the-AI-Data-Cloud](https://www.businesswire.com/news/home/20250602455530/en/Snowflake-Acquires-Crunchy-Data-to-Bring-Enterprise-Ready-Postgres-Offering-to-the-AI-Data-Cloud)
*   dqlabs, 2025-06 — Snowflake·Databricks 2025 서밋 정리 [https://www.dqlabs.ai/blog/key-takeaways-from-snowflake-summit-and-databricks-data-ai-summit-2025/](https://www.dqlabs.ai/blog/key-takeaways-from-snowflake-summit-and-databricks-data-ai-summit-2025/)
*   Databricks, 2025 — 매출 런레이트 40억 달러 돌파 [https://www.databricks.com/company/newsroom/press-releases/databricks-surpasses-4b-revenue-run-rate-exceeding-1b-ai-revenue](https://www.databricks.com/company/newsroom/press-releases/databricks-surpasses-4b-revenue-run-rate-exceeding-1b-ai-revenue)
*   CNBC, 2025-12-16 — Databricks 134억 달러 밸류에이션 [https://www.cnbc.com/2025/12/16/databricks-funding-valuation.html](https://www.cnbc.com/2025/12/16/databricks-funding-valuation.html)
*   Databricks Blog, 2026 — Apache Iceberg v3 공개 미리보기: https://www.databricks.com/blog/next-era-open-lakehouse-apache-icebergtm-v3-public-preview-databricks
*   Oracle, 2026-03-24 — AI Database 에이전트 혁신·MCP Server: https://www.oracle.com/news/announcement/oracle-unveils-ai-database-agentic-innovations-for-business-data-2026-03-24/
*   VentureBeat, 2026 — 컨텍스트 아키텍처가 RAG를 대체: https://venturebeat.com/data/context-architecture-is-replacing-rag-as-agentic-ai-pushes-enterprise-retrieval-to-its-limits
*   VentureBeat, 2026 — 2026 데이터 6대 예측: https://venturebeat.com/data/six-data-shifts-that-will-shape-enterprise-ai-in-2026
*   CNBC, 2025-12-16 — Databricks 134억 달러 밸류에이션과 IPO 전망: https://www.cnbc.com/news/2025/12/16/databricks-funding-valuation.html
*   Apache Foundation, 2026 — Apache Polaris 프로덕션 도입 확산 (URL 추정: https://apache.org/polaris/news/2026/06/production-adoption-rises)
