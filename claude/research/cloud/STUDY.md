# 클라우드 · 쿠버네티스 · DevOps — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
클라우드, 쿠버네티스, DevOps는 현대 IT 인프라의 핵심이자 AI 시대를 위한 표준 플랫폼입니다. 이 기술들은 개발 생산성 향상, 비용 최적화, 그리고 소프트웨어 공급망 보안 강화를 통해 기업의 민첩성과 경쟁력 확보에 필수적입니다.

## B. 반드시 아는 핵심 개념 사전

### CRI (Container Runtime Interface)
*   **정의:** 쿠버네티스가 특정 컨테이너 기술에 종속되지 않고, 다양한 컨테이너 런타임과 소통하기 위한 표준 통신 규약입니다.
*   **원리:** 쿠버네티스의 각 서버(노드)에서 동작하는 kubelet이라는 에이전트가 gRPC라는 표준화된 프로토콜을 사용해 CRI에 명령을 내립니다. CRI 규약을 따르는 containerd나 CRI-O 같은 런타임이 그 명령을 해석해서 컨테이너를 생성하고 관리합니다.
*   **의의:** 특정 벤더 기술(도커)에 대한 의존성에서 벗어나 유연성과 개방성을 확보하여, 컨테이너 런타임 생태계의 혁신과 효율적인 클러스터 운영을 가능하게 합니다.

### GitOps
*   **정의:** 버전 관리 시스템인 Git을 '단일 진실 공급원(Single Source of Truth)'으로 삼아, 시스템의 목표 상태를 코드로 관리하고 자동으로 동기화하는 인프라 운영 방식입니다.
*   **원리:** 원하는 시스템의 상태(예: "A 앱은 3개를 배포하고, B 앱은 v2 버전을 사용한다")를 YAML 같은 선언적 코드로 작성해 Git 저장소에 저장합니다. Argo CD나 Flux 같은 GitOps 도구가 이 Git 저장소를 감시하며 클러스터의 실제 상태를 Git 내용과 일치하도록 자동으로 변경합니다.
*   **의의:** 모든 변경 사항이 Git 커밋 기록으로 남기 때문에 투명성과 추적 가능성을 극대화합니다. 설정 드리프트(Configuration Drift)를 방지하고, 장애 발생 시 이전 커밋으로 되돌리는 것만으로 시스템을 쉽고 빠르게 복구할 수 있어 안정성과 예측 가능성을 높입니다.

### eBPF (extended Berkeley Packet Filter)
*   **정의:** 리눅스 커널을 직접 수정하거나 재부팅하지 않고도, 커널 안에서 안전하게 프로그램을 실행시켜 시스템의 동작을 관찰하고 제어할 수 있게 해주는 혁신적인 기술입니다.
*   **원리:** 개발자가 C언어와 유사한 코드로 eBPF 프로그램을 작성하고, '시스템 콜 호출', '네트워크 패킷 수신' 같은 특정 커널 이벤트에 프로그램을 '연결'합니다. 해당 이벤트가 발생하면, 커널은 이 프로그램을 커널 메모리 공간의 안전한 샌드박스(가상머신) 안에서 직접 실행합니다.
*   **의의:** 커널을 재부팅하거나 수정 없이도 커널 수준의 깊이 있는 가시성(Observability)과 제어 능력을 낮은 성능 오버헤드로 제공하여 네트워킹, 보안, 모니터링 분야에 혁신을 가져왔습니다. 컨테이너 런타임 행위 기반 보안 탐지 등 클라우드 네이티브 환경의 핵심 기술로 부상했습니다.

### FinOps (Cloud Financial Operations)
*   **정의:** 클라우드 비용을 데이터 기반으로 관리하고 최적화하여 '비즈니스 가치'를 극대화하는 문화적 프레임워크입니다.
*   **원리:** '알림(Inform) → 최적화(Optimize) → 운영(Operate)'의 3단계 사이클을 반복합니다. 먼저, 태그 정책을 표준화하고 비용 가시성 도구를 도입해 누가, 왜 비용을 발생시키는지 추적합니다. 다음으로, 데이터를 분석해 미사용 자원을 끄거나, 예약 인스턴스(RI) 등으로 약정 할인을 적용합니다. 마지막으로 이 과정을 자동화하고 정책으로 만들어 지속적으로 비용을 관리합니다.
*   **의의:** 클라우드 비용이 '통제 불가능한 지출'에서 '예측 가능한 투자'로 바뀝니다. 엔지니어는 기술적 의사결정이 비즈니스에 미치는 영향을 직접 확인하고, 더 효율적인 아키텍처를 고민하게 되어 조직 전체의 재무 효율성과 클라우드 운영 성숙도를 높입니다.

### 플랫폼 엔지니어링 (Platform Engineering)
*   **정의:** 개발자가 인프라의 복잡성을 몰라도 애플리케이션을 쉽게 빌드, 배포, 운영할 수 있도록 표준화된 도구와 서비스를 제공하는 '내부 개발자 플랫폼(IDP)'을 구축하는 활동입니다.
*   **원리:** 전담 '플랫폼 팀'이 조직의 표준 개발 워크플로우인 '골든 패스(Golden Path)'를 정의합니다. 개발자는 Backstage와 같은 포털을 통해 셀프서비스 방식으로 필요한 개발 환경과 배포 파이프라인을 생성하고 사용할 수 있습니다.
*   **의의:** 개발자의 인지 부하를 줄여 비즈니스 로직 개발에 집중하게 함으로써 생산성을 향상시킵니다. 시스템의 일관성과 안정성을 높이며, DevOps 철학을 구체적인 제품과 서비스로 구현하여 개발자 경험(DX)을 극대화합니다.

### DRA (Dynamic Resource Allocation, 동적 리소스 할당)
*   **정의:** 쿠버네티스에서 GPU나 TPU 같은 특수 하드웨어를 단순히 '개수'가 아닌, 워크로드가 필요로 하는 '속성'에 맞춰 동적으로 찾아 할당해주는 표준 기능입니다.
*   **원리:** 개발자는 파드(Pod) 명세에 'ResourceClaim'이라는 항목을 통해 "메모리 30GB 이상, NVLink 지원 GPU 필요"처럼 원하는 장치의 '속성'을 선언적으로 요청합니다. 쿠버네티스 스케줄러와 DRA 컨트롤러가 현재 클러스터에 있는 모든 장비의 상태와 사양을 파악하고, 요청에 가장 적합한 장치를 찾아 해당 파드에 동적으로 연결합니다.
*   **의의:** 고가의 AI 가속기를 낭비 없이 필요한 워크로드에 정밀하게 할당하여 자원 활용률과 비용 효율성을 극대화합니다. AI 서비스의 비용 구조를 개선하고, 개발자가 인프라의 물리적 제약에 얽매이지 않고 애플리케이션의 요구사항에만 집중할 수 있게 합니다.

## C. 연도별 흐름 한눈에

*   **2021:** 팬데믹 가속화 속 클라우드 네이티브 전환 본격화, 쿠버네티스 dockershim 중단 예고, GitOps 부상, Log4Shell 사태로 eBPF 기반 공급망 보안 중요성 대두. ([2021](2021.md))
*   **2022:** '무한 성장'에서 '비용 효율성'으로 전환, FinOps 주목, 쿠버네티스 dockershim 완전 제거로 생태계 성숙, 개발자 생산성을 위한 플랫폼 엔지니어링 대두, eBPF·Wasm 실용화 논의 시작. ([2022](2022.md))
*   **2023:** 생성형 AI가 클라우드 성장을 견인했으나 비용 최적화(FinOps) 압박 공존, HashiCorp 라이선스 논쟁으로 오픈소스 거버넌스 부각, eBPF 주류화, 플랫폼 엔지니어링 급부상, 쿠버네티스 운영 편의성 증대. ([2023](2023.md))
*   **2024:** 쿠버네티스 10주년, AI 인프라의 표준 플랫폼으로 자리매김, eBPF 기반 Falco 졸업으로 런타임 보안 업계 표준화, Broadcom VMware 인수 후폭풍으로 인프라 현대화 가속, 플랫폼 엔지니어링 주류화. ([2024](2024.md))
*   **2025:** 쿠버네티스 AI 워크로드 표준 운영체제로 확고히 정착, DRA 정식 기능 승격으로 GPU 자원 활용 극대화, AI 에이전트의 클러스터 운영 도입(MCP 확산), AWS 대규모 장애로 멀티클라우드 및 복원력 중요성 재조명. ([2025](2025.md))
*   **2026:** AI 에이전트를 쿠버네티스 위에서 안전하고 효율적으로 운영하는 기술이 중심, DRA 보편화로 GPU 자원 효율 극대화, EU CRA 등 규제 중심의 소프트웨어 공급망 보안 재설계 요구, 기술을 넘어선 조직·문화적 과제 부상. ([2026](2026.md))

## D. PT 발표 주제 추천

1.  **제목: "Log4Shell 사태로 본 클라우드 네이티브 보안의 미래: SBOM과 eBPF를 활용한 이중 방어 체계 제안"**
    *   **핵심 메시지:** 제로데이 공격에 대응하려면, 배포 전 SBOM으로 구성 요소를 파악하고, 런타임 시 eBPF로 이상 행위를 탐지하는 이중 방어 체계가 필수적입니다.
    *   **발표 3단 구조:** (문제) Log4Shell처럼 정적 분석만으로 막을 수 없는 공급망 공격의 위협 → (근거) SBOM을 통한 사전 취약점 식별의 중요성과, eBPF를 통한 런타임 행위 기반 탐지의 효과성 제시 → (제언) 두 기술을 결합한 심층 방어(Defense-in-Depth) 아키텍처 도입을 통한 보안 패러다임 전환을 제안합니다.

2.  **제목: "진정한 DevOps를 위하여: 플랫폼 엔지니어링이 필요한 이유"**
    *   **핵심 메시지:** 복잡한 클라우드 네이티브 환경에서 개발자 생산성을 극대화하기 위해, '모두가 DevOps 전문가'가 되기보다 '잘 만들어진 플랫폼'을 제공하는 플랫폼 엔지니어링으로 전환해야 합니다.
    *   **발표 3단 구조:** (문제) 쿠버네티스와 마이크로서비스 아키텍처는 개발자에게 과도한 인지 부하를 유발하며, 이는 본업인 비즈니스 로직 개발의 생산성을 저해합니다. → (근거) Gartner는 2026년까지 80%의 기업이 플랫폼 팀을 만들 것이라 예측했습니다. 이는 'DevOps는 문화'라는 구호만으로는 실질적인 생산성 향상에 한계가 있음을 시장이 인정한 것입니다. → (제언) 개발자를 고객으로 생각하는 '내부 개발자 플랫폼(IDP)'을 구축해야 합니다. 표준화된 CI/CD, 보안, 모니터링을 '셀프서비스'로 제공하여 개발자는 인프라가 아닌 코드에만 집중할 수 있는 환경을 만들어야 합니다.

3.  **제목: "쿠버네티스는 어떻게 AI의 운영체제가 되었는가: AI 시대를 위한 인프라 역량의 재정의"**
    *   **핵심 메시지**: AI 시대의 핵심 인프라 역량은 모델 개발을 넘어, 쿠버네티스 위에서 GPU 자원을 효율적이고 안전하게 운영하는 능력으로 재정의되어야 합니다.
    *   **발표 3단 구조**:
        *   **문제**: AI 워크로드는 예측 불가능하고 막대한 자원을 요구하며, 기존 방식으로는 운영이 어렵고 보안에 취약합니다.
        *   **근거**: CNCF 설문에서 AI 워크로드의 66%가 쿠버네티스를 사용하며, DRA, MCP 같은 기술이 이를 뒷받침하고 있습니다.
        *   **제언**: AI 시대 개발자는 모델 구현뿐 아니라 쿠버네티스 기반의 안정적인 인프라 운영 역량을 갖춰야 합니다. 제가 가진 컨테이너 런타임 보안 및 시스템 콜 관측 경험을 여기에 결합하여, 예측 불가능한 AI 워크로드의 안정성까지 확보하는 융합형 개발자로 성장하겠습니다.

4.  **제목: "피할 수 없는 미래: EU 사이버보안법(CRA) 시대의 DevSecOps 전략"**
    *   **핵심 메시지:** EU CRA는 보안을 개발 문화의 중심으로 강제하는 규제이며, 이에 대응하기 위해 개발 파이프라인 전 과정에 보안을 내재화하는 근본적인 변화가 필요합니다.
    *   **발표 3단 구조**:
        *   **문제:** 2026년 9월부터 적용되는 EU CRA는 소프트웨어 취약점을 기업의 책임으로 규정하며, 기존의 개발 및 배포 프로세스로는 대응이 불가능합니다.
        *   **근거**: CRA는 컨테이너 이미지, Helm 차트 등 클라우드 네이티브 생태계의 거의 모든 산출물을 규제 대상으로 삼습니다. 이는 KubeCon에서 공급망 보안이 핵심 의제로 다뤄진 배경이기도 합니다.
        *   **제언**: 보안은 더 이상 보안팀만의 일이 아닙니다. 개발자는 코드 작성 단계부터 SBOM을 관리하고, 운영팀은 배포 파이프라인에 자동화된 보안 스캔을 통합해야 합니다. 저는 리눅스 커널과 컨테이너의 동작 원리를 깊이 이해하고 있습니다. 이러한 시스템 이해를 바탕으로 개발 초기 단계부터 보안 취약점을 예측하고 방어하는 'Shift Left Security' 문화를 정착시키는 데 기여하고 싶습니다.

## E. 모범답안집

1.  **Q. 본인이 컨테이너 보안 프로젝트에서 시스템 콜을 동적으로 관측했다고 했는데, 그 경험을 바탕으로 Falco의 한계점과 이를 보완할 아이디어가 있다면 무엇일까요?**
    *   **A.** 네, Falco는 미리 정의된 규칙 기반으로 동작하기 때문에 알려지지 않은 새로운 공격 패턴, 즉 제로데이 공격을 탐지하는 데는 한계가 있을 수 있습니다. 제가 **시스템 콜 동적 관측을 통해 이상탐지 기법을 개발**했을 때, 정상 상태의 시스템 콜 순서와 빈도를 학습한 뒤 이 패턴에서 벗어나는 행위를 비정상으로 판단하는 머신러닝 모델을 적용했었습니다. Falco의 강력한 탐지 능력과 제가 경험한 이상탐지 모델을 결합하여, 규칙 기반 탐지와 머신러닝 기반의 비정상 행위 탐지를 함께 사용하는 하이브리드 모델을 구축한다면 Falco의 탐지 능력을 한 단계 더 발전시킬 수 있다고 생각합니다.

2.  **Q. eBPF 기술이 클라우드 네이티브 보안의 '게임 체인저'라고 불리는 이유는 무엇인가요? 본인의 시스템 콜 관측 경험과 연결해서 설명해주세요.**
    *   **A.** eBPF가 게임 체인저인 이유는 커널을 재컴파일하는 위험 부담이나 심각한 성능 저하 없이, 커널 수준의 깊은 가시성과 제어 능력을 제공하기 때문입니다. 제가 과거에 ptrace 같은 전통적인 방식으로 시스템 콜을 관측하는 프로젝트를 했을 때, 가장 큰 고민은 성능 부하가 커서 실제 운영 환경에 적용하기 어렵다는 점이었습니다. 하지만 eBPF는 커널 안의 안전한 가상 머신에서 코드를 실행하므로 오버헤드가 거의 없고 매우 안전합니다. 모든 컨테이너는 결국 하나의 리눅스 커널을 공유하는데, eBPF를 쓰면 바로 이 공유 지점인 커널에서 모든 컨테이너의 네트워크, 파일 접근, 프로세스 실행 같은 행위를 훤히 들여다보고 통제할 수 있습니다. 이는 기존 보안 솔루션이 접근 못 하던 영역에서 위협을 탐지한다는 의미이므로, 보안의 패러다임을 바꾸는 기술이라고 생각합니다.

3.  **Q. '플랫폼 엔지니어링'은 'DevOps'와 어떻게 다른가요? 왜 2022년에 이 개념이 특히 주목받게 되었을까요?**
    *   **A.** DevOps가 개발과 운영의 협업 '문화'와 '철학'을 강조한다면, 플랫폼 엔지니어링은 그 철학을 '제품'으로 구현하는 구체적인 '방법론'입니다. 2022년에 특히 주목받은 이유는 쿠버네티스 생태계가 성숙기를 넘어 너무 복잡해지면서, 개발자의 인지 부하가 오히려 생산성을 해치는 단계에 이르렀기 때문입니다. 플랫폼 엔지니어링은 전담 팀이 표준화된 플랫폼을 제공하여, 개발자들이 인프라를 몰라도 셀프서비스로 안전하게 애플리케이션을 배포하게 해줍니다. 저는 풀스택 개발자로 성장하는 과정에서, 좋은 플랫폼이란 개발자가 신경 쓰지 않아도 보안과 같은 필수 요소를 기본으로 제공해야 한다고 생각합니다.

4.  **Q. SSAFY에서 파이썬 풀스택 과정을 배우게 될 텐데, 오늘 발표한 쿠버네티스나 클라우드 네이티브 기술들이 웹 개발자에게 왜 중요하다고 생각하나요?**
    *   **A.** 현대의 웹 개발자는 단순히 코드만 잘 짜는 것을 넘어, 내가 만든 서비스가 어떻게 배포되고 안정적으로 운영되는지 알아야 한다고 생각합니다. 쿠버네티스는 이제 애플리케이션을 배포하고 운영하는 표준 플랫폼이 되었기 때문에, 무중단 배포나 오토스케일링 같은 그 특성을 이해하면, 그에 맞춰 더 안정적이고 확장성 있는 애플리케이션을 설계할 수 있습니다. 저는 커널이라는 시스템의 가장 낮은 곳을 경험하며 전체를 보는 눈을 기르고 싶었고, 이제 SSAFY에서는 반대로 사용자와 가장 가까운 웹 서비스를 직접 구현하며 애플리케이션부터 인프라까지 아우르는 '융합형 개발자'로 성장하고 싶습니다. 그런 의미에서 쿠버네티스에 대한 이해는 풀스택 개발자에게 필수적인 역량이라고 확신합니다.

5.  **Q. FinOps가 중요해지면서 엔지니어가 비즈니스 비용까지 신경 써야 하는 것에 대한 부담은 없을까요? 본인의 생각은 어떤가요?**
    *   **A.** 저는 엔지니어가 비용을 이해하는 것이 부담이 아니라, 문제 해결 역량의 당연한 확장이라고 생각합니다. 과거 제가 시스템 콜을 분석해 비정상 행위를 탐지했던 것처럼, 시스템의 동작을 깊이 이해하면 성능뿐 아니라 비용 효율성까지 최적화할 수 있습니다. 예를 들어, 불필요한 시스템 콜 패턴을 찾아내면 CPU 사용률을 낮춰 직접적인 비용 절감으로 이어집니다. FinOps는 엔지니어에게 책임을 전가하는 것이 아니라, 자신의 기술적 의사결정이 비즈니스에 미치는 영향을 명확히 보여줌으로써 더 나은 아키텍처를 설계하도록 돕는 강력한 근거 데이터라고 생각합니다.

6.  **Q. AI 에이전트를 클러스터 운영에 도입할 때 발생할 수 있는 보안 리스크는 무엇이고, 어떻게 방어해야 할까요?**
    *   **A.** AI 에이전트는 자율성과 비결정성 때문에 예측 불가능한 행동을 할 수 있다는 것이 가장 큰 보안 리스크입니다. 특히 MCP를 통해 클러스터 조작 권한까지 갖게 되면, 의도치 않은 실수나 악의적 프롬프트에 의해 시스템 전체가 위험에 빠질 수 있습니다. 이를 방어하기 위해서는 먼저 최소 권한 원칙과 같은 정적 통제가 중요합니다. 더 나아가, 제가 eBPF를 이용해 시스템 콜을 동적으로 관측하며 이상행위를 탐지했던 경험에 비추어 볼 때, 에이전트의 런타임 행위를 실시간으로 감시하는 능동적 방어가 필수적입니다. 예상치 못한 시스템 콜을 호출하거나 민감한 파일에 접근하려는 시도를 커널 레벨에서 즉시 탐지하고 차단하는 전략을 적용해야 합니다.

7.  **Q. SSAFY의 교육 과정은 파이썬 기반 풀스택 웹 개발에 중점을 두고 있습니다. 본인의 저수준(low-level) 시스템 경험이 웹 서비스 개발 팀 프로젝트에 어떻게 기여할 수 있을까요?**
    *   **A.** 저는 문제의 현상보다 근본 원인을 파고드는 개발자가 되고 싶습니다. 웹 애플리케이션 개발 중 마주치는 성능 저하, 알 수 없는 오류 같은 문제들은 종종 그 기반이 되는 인프라나 OS 수준의 이해가 부족할 때 해결이 더뎌지곤 합니다. 제가 **컨테이너 보안 문제를 해결하기 위해 리눅스 커널과 시스템 콜을 분석했던 경험**은, 복잡한 문제 상황에서 시스템의 동작을 더 깊이 이해하고 근본적인 해결책을 찾는 데 큰 강점이 될 것입니다. 예를 들어, 다른 팀원들이 애플리케이션 로직에 집중할 때 저는 서비스의 컨테이너화, 효율적인 자원 사용, 배포 파이프라인 최적화 등 보이지 않는 부분의 안정성과 성능을 책임지는 역할을 맡고 싶습니다. 이것이 바로 제가 추구하는 '융합형 개발자'의 모습입니다.

8.  **Q. EU의 CRA 법안이 개발자에게 실제 업무에서 어떤 영향을 미칠 것이라 예상하나요?**
    *   **A.** CRA는 개발과 운영의 모든 단계에 보안을 내재화하는 'Shift Left Security'를 법으로 강제하는 강력한 변화를 가져올 것입니다. 이제 개발자는 단순히 코드를 짜는 것을 넘어, 내가 사용하는 오픈소스 라이브러리의 취약점은 없는지 SBOM을 통해 항상 관리해야 합니다. 제가 수행했던 컨테이너 시스템 콜 동적 관측을 통한 이상 탐지 프로젝트 경험은 CRA가 요구하는 '지속적인 런타임 모니터링'의 구체적인 구현 방안이 될 수 있다고 생각합니다. 결국 CRA는 보안을 특정 팀의 업무가 아닌, 개발 프로세스에 참여하는 모두의 책임으로 만드는 계기가 될 것입니다.

## F. 지원자 경험 연계 포인트

1.  "제가 컨테이너 이상 행위를 탐지하기 위해 시스템 콜을 관측했던 경험이 있는데, eBPF는 바로 그 작업을 훨씬 안전하고 효율적으로 수행해줍니다."
2.  "저는 컨테이너 보안 프로젝트를 통해 커널의 동작 원리를 깊이 분석한 경험이 있는데, 이런 변화를 인터페이스 교체가 아닌 커널 수준의 격리 기술을 다시 점검하고 강화할 기회로 삼는 것이 중요하다고 생각합니다."
3.  "SSAFY에서 풀스택 개발 역량을 길러, 이 플랫폼을 사용하는 동료 개발자들의 경험까지 개선하는 융합형 개발자로 성장하고 싶습니다."
4.  "제가 시스템 콜 동적 관측을 통해 이상탐지 기법을 개발했을 때, 정상 상태의 시스템 콜 순서와 빈도를 학습한 뒤 이 패턴에서 벗어나는 행위를 비정상으로 판단하는 머신러닝 모델을 적용했었습니다."
5.  "저는 문제의 현상보다 근본 원인을 파고드는 개발자가 되고 싶습니다. 제가 컨테이너 보안 문제를 해결하기 위해 리눅스 커널과 시스템 콜을 분석했던 경험은, 복잡한 문제 상황에서 시스템의 동작을 더 깊이 이해하고 근본적인 해결책을 찾는 데 큰 강점이 될 것입니다."

## G. 빠른 암기 카드

| 분류 | 내용 |
|---|---|
| **쿠버네티스** |
| 첫 커밋 10주년 | 2024년 6월 6일 |
| 2021년 채택률 | 96% (사용 또는 검토 중, CNCF '21) |
| 2025년 프로덕션 운영 | 82% (CNCF '25) |
| AI 워크로드(추론) 사용 | 66% (CNCF '25) |
| **클라우드 시장** |
| 2021년 AWS 매출 | 622억 달러 (+37%) |
| 2022년 클라우드 낭비 | 32% (FinOps Foundation) |
| 2024년 성장률 전망 | ~20% (AI 수요) |
| 2025년 분기 매출 최초 | 1,000억 달러 돌파 (Q3) |
| 2026년 Q1 Google Cloud | 약 200억 달러 (+63%) |
| 2026년 Q1 AWS | 약 376억 달러 (+28%) |
| 2026년 하이퍼스케일러 Capex | 연간 6,000억 달러 이상 (2026 전망) |
| **핵심 기술/트렌드** |
| dockershim 제거 | 2022년 5월 (K8s 1.24) |
| Cilium CNCF 졸업 | 2023년 10월 11일 |
| Falco CNCF 졸업 | 2024년 2월 29일 |
| DRA GA 승격 | 2025년 8월 27일 (K8s v1.34) |
| 플랫폼 엔지니어링 | 2026년까지 80% 조직 도입 (Gartner 전망) |
| HashiCorp BSL 변경 | 2023년 8월 10일 |
| OpenTofu 출범 | 2023년 8월 25일 (LF 수용 9월 20일) |
| IBM-HashiCorp 인수 완료 | 2025년 2월 27일 (64억 달러) |
| Broadcom-VMware 인수 | 2022년 5월 26일 (610억 달러 발표) / 2023년 11월 22일 (690억 달러 완료) |
| VMware 이탈 전망 | 2028년까지 35% (Gartner) |
| Log4Shell 취약점 공개 | 2021년 12월 9일 |
| EU CRA 시행 | 2026년 9월 11일 (보고 의무) |
| AI 추론 시장 규모 | 2030년 2,550억 달러 (전망) |
| DRA GPU 비용 절감 | 20~35% (추정) |

## H. 참고

**연도별 학습 자료:**
*   [2021](2021.md)
*   [2022](2022.md)
*   [2023](2023.md)
*   [2024](2024.md)
*   [2025](2025.md)
*   [2026](2026.md)

**주요 출처:**

*   CNBC, 2023-02-04 — [Cloud growth slowing at Amazon, Google, Microsoft](https://www.cnbc.com/2023/02/04/amazon-google-microsoft-show-slowing-growth-in-cloud-infrastructure.html)
*   CNCF, 2021-03-11 — [CNCF TOC votes to move Flux from Sandbox to Incubation](https://www.cncf.io/blog/2021/03/11/cncf-toc-votes-to-move-flux-from-sandbox-to-incubation/)
*   CNCF, 2021-10-13 — [Cilium joins CNCF as an incubating project](https://www.cncf.io/blog/2021/10/13/cilium-joins-cncf-as-an-incubating-project/)
*   CNCF, 2022-02-10 — [CNCF Sees Record Kubernetes and Container Adoption in 2021 Cloud Native Survey](https://www.cncf.io/announcements/2022/02/10/cncf-sees-record-kubernetes-and-container-adoption-in-2021-cloud-native-survey/)
*   CNCF, 2022-12-06 — [The CNCF Announces Argo has Graduated](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/)
*   CNCF, 2023-10-11 — [Cloud Native Computing Foundation Announces Cilium Graduation](https://www.cncf.io/announcements/2023/10/11/cloud-native-computing-foundation-announces-cilium-graduation/)
*   CNCF, 2024-02-29 — [Cloud Native Computing Foundation Announces Falco Graduation](https://www.cncf.io/announcements/2024/02/29/cloud-native-computing-foundation-announces-falco-graduation/)
*   CNCF, 2024-03-20 — [KubeCon EU 2024 day two: how cloud native is powering the AI movement](https://www.cncf.io/blog/2024/03/20/kubecon-cloudnativecon-europe-2024-day-two-how-cloud-native-is-powering-the-ai-movement-and-other-news/)
*   CNCF, 2024-06-04 — [Kubernetes turns 10: Triumphs, Trials, and the Ongoing Battle for Security](https://www.cncf.io/blog/2024/06/04/kubernetes-turns-10-triumphs-trials-and-the-ongoing-battle-for-security/)
*   CNCF, 2025-08-05 — [KubeCon EU 2026 Returning to Amsterdam, 23-26 March](https://www.cncf.io/blog/2025/08/05/kubecon-cloudnativecon-europe-2026-returning-to-amsterdam-23-26-march/)
*   CNCF, 2026-01-20 — [Kubernetes Established as De Facto OS for AI (2025 연례 설문)](https://www.cncf.io/announcements/2026/01/20/kubernetes-established-as-the-de-facto-operating-system-for-ai-as-production-use-hits-82-in-2025-cncf-annual-cloud-native-survey/)
*   DCD, 2022-02 — [AWS grows revenue 40%, Azure increases share, Google Cloud](https://www.datacenterdynamics.com/en/news/amazon-web-services-grows-revenue-40-percent-microsoft-azure-increases-share-google-cloud-still-loses-840m/)
*   European Commission — [Cyber Resilience Act 정책 페이지](https://digital-strategy.ec.europa.eu/en/policies/cyber-resilience-act)
*   Gartner Newsroom, 2023-11-28 — [Platform Engineering to reach mainstream adoption](https://www.gartner.com/en/newsroom/press-releases/2023-11-28-gartner-hype-cycle-shows-ai-practices-and-platform-engineering-will-reach-mainstream-adoption-in-software-engineering-in-two-to-five-years)
*   Help Net Security, 2023-11-22 — [Broadcom completes $69 billion acquisition of VMware](https://www.helpnetsecurity.com/2023/11/22/broadcom-vmware-acquisition/)
*   IT Pro, 2025-11 — [Cloud infrastructure spending hit $102.6B in Q3 2025](https://www.itpro.com/cloud/cloud-computing/cloud-infrastructure-spending-hit-usd102-6-billion-in-q3-2025-and-aws-marked-its-strongest-performance-in-three-years)
*   Kubernetes Blog, 2020-12-02 — [Dockershim Deprecation FAQ](https://kubernetes.io/blog/2020/12/02/dockershim-faq/)
*   Kubernetes Blog, 2020-12-02 — [Don't Panic: Kubernetes and Docker](https://kubernetes.io/blog/2020/12/02/dont-panic-kubernetes-and-docker/)
*   Kubernetes Blog, 2022-05-03 — [Kubernetes 1.24: Stargazer](https://kubernetes.io/blog/2022/05/03/kubernetes-1-24-release-announcement/)
*   Kubernetes Blog, 2023-08-25 — [Introducing native sidecar containers](https://kubernetes.io/blog/2023/08/25/native-sidecar-containers/)
*   Kubernetes Blog, 2025-08-27 — [Kubernetes v1.34 'Of Wind & Will' release](https://kubernetes.io/blog/2025/08/27/kubernetes-v1-34-release/)
*   NPR, 2021-04-29 — [Biden order to require new cybersecurity standards in response to SolarWinds att](https://www.npr.org/2021/04/29/991333036/biden-order-to-require-new-cybersecurity-standards-in-response-to-solarwinds-att)
*   OpenTofu Blog, 2023-08-25 — [OpenTofu Announces Fork of Terraform](https://opentofu.org/blog/opentofu-announces-fork-of-terraform/)
*   Pulumi, 2026 — [KubeCon EU 2026 Recap: AI Moved Into Production](https://www.pulumi.com/blog/kubecon-eu-2026-recap/)
*   Qualys Blog, 2021-12-10 — [Apache Log4j2 Zero-Day Exploited in the Wild (Log4Shell)](https://blog.qualys.com/vulnerabilities-threat-research/2021/12/10/apache-log4j2-zero-day-exploited-in-the-wild-log4shell)
*   Solo.io, 2026 — [Highlights from KubeCon EU 2026 (kagent·agentgateway)](https://www.solo.io/blog/highlights-from-kubecon-cloudnativecon-europe-2026)
*   Software Pricing Guide, 2025 — [VMware pricing after Broadcom: the price shock and alternatives](https://softwarepricingguide.com/vmware-pricing-after-broadcom-the-800-1500-price-shock-what-changed-and-your-real-alternatives-in-2025/)
*   Spacelift, 2023 — [Terraform License Change (BSL)](https://spacelift.io/blog/terraform-license-change)
*   TechCrunch, 2025-02-27 — [IBM closes $6.4B HashiCorp acquisition](https://techcrunch.com/2025/02/27/ibm-closes-6-4b-hashiCorp-acquisition/)
*   The Register, 2023-02-22 — [37signals CTO: $600k of servers will save $7 million](https://www.theiregister.com/2023/02/22/cloud_repatration_savings_calculated_basecamp/)
*   The Register, 2024-09-05 — [AT&T sues Broadcom for breach of VMware support deal](https://www.theiregister.com/2024/09/05/att_sues_broadcom_vmware_support/)
*   The Register, 2025-10-23 — [A single DNS race condition brought AWS to its knees](https://www.theiregister.com/2025/10/23/amazon_outage_postmortem/)
*   Tomasz Tunguz, 2026-04-29 — [The $112 Billion Quarter (하이퍼스케일러 Q1 2026)](https://tomtunguz.com/2026-04-29-the-112-billion-quarter-hyperscalers-bet-the-farm-on-ai/)
