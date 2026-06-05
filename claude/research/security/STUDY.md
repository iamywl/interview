## 보안 · 제로트러스트 · 랜섬웨어 — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
사이버 위협이 국가 안보와 사회 기반 시설을 직접 마비시키는 수준으로 진화하며 그 파급력이 일상을 위협하고 있습니다. 기존 경계 보안 모델의 한계가 명확해짐에 따라, '아무도 믿지 않고 항상 검증하는' 제로 트러스트 아키텍처는 이제 선택이 아닌 필수가 되었습니다. AI가 공격과 방어의 핵심 주체로 부상하며 전통적인 보안 개념 자체의 근본적인 재정의를 요구하고 있습니다.

## B. 반드시 아는 핵심 개념 사전

*   **제로 트러스트 아키텍처 (Zero Trust Architecture, ZTA)**
    *   **정의**: '절대 신뢰하지 않고, 항상 검증한다(Never Trust, Always Verify)'는 원칙에 기반한 보안 모델입니다.
    *   **원리**: 사용자가 리소스에 접근을 요청할 때마다 네트워크 위치와 무관하게 신원, 기기 상태, 접근 시간 등 다양한 맥락을 종합적으로 평가하여 인증합니다. 인증 후에도 최소한의 권한만 부여하고, 모든 활동을 지속적으로 모니터링하여 의심스러운 행위 발생 시 즉시 차단합니다. 네트워크를 아주 작은 단위로 쪼개는 마이크로세그멘테이션 기술이 핵심입니다.
    *   **의의**: 기존 경계 보안 모델의 한계를 극복하고, 내부자 위협이나 침해된 계정 공격 방어에 효과적입니다. 침입자가 일부 시스템에 침투하더라도 다른 시스템으로 확산(측면 이동)하는 것을 막아 피해를 최소화할 수 있습니다.

*   **소프트웨어 자재 명세서 (Software Bill of Materials, SBOM)**
    *   **정의**: 소프트웨어를 구성하는 모든 부품(오픈소스 라이브러리, 모듈 등)의 목록과 버전 정보를 담은 '소프트웨어 성분표'입니다.
    *   **원리**: 소프트웨어 개발의 빌드 단계에서 구성 요소 목록을 추출하여 SPDX, CycloneDX 등 표준화된 형식의 파일로 생성합니다. 이 파일을 분석하면 특정 취약점을 가진 라이브러리가 어떤 제품에 포함되어 있는지 즉시 추적할 수 있습니다.
    *   **의의**: 소프트웨어 공급망의 투명성을 확보하여 취약점 발생 시 영향을 받는 시스템을 빠르게 식별하고 조치할 수 있게 함으로써 공급망 공격에 대한 가시성과 대응 속도를 높입니다.

*   **서비스형 랜섬웨어 (Ransomware-as-a-Service, RaaS)**
    *   **정의**: 랜섬웨어 개발자가 공격용 소프트웨어와 인프라를 서비스 형태로 만들어, 기술이 없는 공격 실행자에게 빌려주고 수익을 공유하는 범죄 비즈니스 모델입니다.
    *   **원리**: RaaS 운영 조직은 랜섬웨어 코드, 암호화 키 관리, 협상용 웹사이트 등 공격에 필요한 모든 것을 제공합니다. '제휴 회원'이라 불리는 공격 실행자는 이 플랫폼을 이용해 목표를 감염시키고 몸값을 받아내면, 수익의 일부를 운영 조직에 수수료로 지불합니다.
    *   **의의**: 랜섬웨어 공격의 진입 장벽을 극적으로 낮춰 공격의 빈도, 규모, 피해액이 기하급수적으로 증가하는 원인이 되었으며, 랜섬웨어 공격의 '산업화'를 이끌었습니다.

*   **MFA 피로 공격 (MFA Fatigue Attack)**
    *   **정의**: 다중 인증(MFA) 사용자에게 수많은 가짜 인증 요청을 보내, 사용자가 지쳐서 실수로 '승인'을 누르게 만드는 사회 공학적 공격입니다.
    *   **원리**: 공격자는 이미 탈취한 아이디와 패스워드로 로그인을 무한 반복하여, 사용자 스마트폰에 "로그인을 승인하시겠습니까?"라는 푸시 알림이 계속 울리게 만듭니다. 사용자가 피로감을 느끼거나 착각하여 무심코 '승인' 버튼을 누르면 공격자 접속이 허용됩니다.
    *   **의의**: MFA가 결국 '사람의 확인'이라는 심리적 취약점을 공격하며, 단순 푸시 알림 방식 MFA의 한계를 명확히 보여주어 FIDO2/WebAuthn 같은 피싱 저항 MFA의 필요성을 부각시켰습니다.

*   **양자내성암호 (PQC, Post-Quantum Cryptography)**
    *   **정의**: 현재의 암호체계를 순식간에 무력화시킬 수 있는 미래의 '양자컴퓨터'로도 풀기 매우 어려운 새로운 수학 문제에 기반한 차세대 암호 기술입니다.
    *   **원리**: 양자컴퓨터가 효율적으로 풀지 못하는 다른 종류의 수학 문제(예: 격자 기반 암호, 해시 기반 암호)를 이용합니다. 2024년 미국 국립표준기술연구소(NIST)는 ML-KEM, ML-DSA 등을 최초의 PQC 표준으로 발표했습니다.
    *   **의의**: '하베스트 나우, 디크립트 레이터(Harvest Now, Decrypt Later)' 공격으로부터 장기 보관이 필요한 데이터를 안전하게 지킬 수 있어 미래 데이터 주권을 확보하는 데 필수적인 기술입니다.

*   **BPFDoor (버클리 패킷 필터 도어)**
    *   **정의**: 리눅스 커널의 합법적인 패킷 필터링 기능(BPF)을 악용해, 네트워크상에 흔적을 남기지 않는 초은닉형 백도어(악성코드)입니다.
    *   **원리**: 네트워크 카드에 도착하는 모든 데이터 패킷을 커널 수준에서 몰래 검사하도록 BPF 규칙을 등록합니다. 평소에는 동작하지 않다가, 공격자가 보낸 특정 암호가 담긴 '매직 패킷'이 감지되면 활성화되어 외부 공격 서버로 접속을 시도합니다. 이 과정이 커널 내부의 정상적인 데이터 처리 흐름 속에서 일어나 탐지가 어렵습니다.
    *   **의의**: 포트 기반의 경계 보안 솔루션(방화벽, IDS/IPS)을 무력화시키므로, 시스템 내부의 '행위' 자체를 감시하는 런타임 보안과 시스템 콜 수준의 이상 탐지가 필수적이게 만듭니다.

*   **에이전틱 AI의 머신 신원 (Agentic AI & Machine Identity)**
    *   **정의**: 사람의 개입 없이 스스로 추론하고 행동하는 AI 에이전트를 사람과 구분되는 독립적인 '신원'으로 보고, 그 활동을 통제·관리하는 개념입니다.
    *   **원리**: 모든 AI 에이전트에게 고유한 신원을 부여하고, 특정 작업을 수행하는 '그 순간'에만 필요한 최소한의 임시 권한(Just-in-Time credential)을 발급합니다. 작업이 끝나면 권한은 즉시 회수되며, 에이전트의 모든 활동을 모니터링하여 정상 범위를 벗어나면 차단합니다.
    *   **의의**: AI 에이전트의 예측 불가능한 행동으로 인한 보안 위협에 대응하기 위한 새로운 접근 방식으로, 사람과 기계를 아우르는 통합적인 신원 거버넌스의 중요성을 부각시킵니다.

## C. 연도별 흐름 한눈에
- **2021**: 랜섬웨어의 국가 안보 위협 격상, 공급망 공격 현실화, 제로트러스트 부상으로 보안 패러다임 전환 시작. [2021](2021.md)
- **2022**: 미국 정부 제로트러스트 의무화, 신원 기반 공격 고도화, 와이퍼 악성코드 등장으로 사이버전의 위협 현실화. [2022](2022.md)
- **2023**: MOVEit 사태로 공급망 공격의 정점, 데이터 탈취 전용 공격 대두, 생성형 AI의 새로운 위협 시작. [2023](2023.md)
- **2024**: LockBit 와해, CrowdStrike 장애로 공급망 역설 증명, 양자내성암호 표준화로 미래 위협 대비 본격화. [2024](2024.md)
- **2025**: 한국 통신 3사 침해로 국가 배후 공격의 심각성 부각, AI의 공격 주도권 장악으로 '에이전틱 공격' 현실화. [2025](2025.md)
- **2026**: 취약점 악용이 침해 1순위, AI 에이전트의 머신 신원 폭증, BYOVD로 EDR 무력화, PQC 마이그레이션 실무화. [2026](2026.md)

## D. PT 발표 주제 추천

*   **주제 1: "성벽은 무너졌다: 제로트러스트가 사이버 안보의 표준이 된 이유"**
    *   **핵심 메시지**: 기존 경계 보안의 한계를 극복하고 모든 접근을 지속적으로 검증하는 제로트러스트가 어떻게 현대 기업과 국가의 필수 보안 전략이 되었는지 설명합니다.
    *   **발표 3단 구조**:
        *   **문제**: 클라우드, 원격 근무 확산으로 '내부'와 '외부'의 경계가 무너져 기존 보안 방식이 더 이상 유효하지 않게 되었습니다.
        *   **근거**: 한번 뚫리면 내부 전체가 감염되는 SolarWinds, 카세야 사태 등을 통해 경계 보안의 한계가 명확히 드러났으며, 미국 정부의 제로트러스트 의무화 정책이 이러한 패러다임 전환을 이끌었습니다.
        *   **제언**: '모든 것을 의심하고 항상 검증'하는 제로트러스트 아키텍처를 도입하여, 신원과 맥락 기반의 동적 보안 체계를 구축하고 CISA의 성숙도 모델을 기반으로 단계적인 이행이 필요합니다.

*   **주제 2: "방어자가 일으킨 대재앙, CrowdStrike 사태로 본 공급망 신뢰의 역설"**
    *   **핵심 메시지**: 시스템의 심장부인 커널을 다루는 보안 소프트웨어의 작은 결함이 어떻게 전 세계를 멈추게 할 수 있는지, 그리고 '믿는 도끼'에 발등 찍히지 않기 위한 기술적, 정책적 대안은 무엇인지 제시합니다.
    *   **발표 3단 구조**:
        *   **문제**: 전 세계 850만 대의 Windows 시스템이 마비되고 수백억 달러의 경제적 피해를 일으킨 CrowdStrike 장애는, 신뢰하던 보안 솔루션이 오히려 가장 큰 위협이 될 수 있음을 보여주었습니다.
        *   **근거**: 커널 수준의 민감한 권한을 가진 보안 소프트웨어의 작은 설정 결함이 자동화된 배포 프로세스를 통해 전 세계 시스템에 치명적인 영향을 미칠 수 있음을 증명했습니다.
        *   **제언**: 보안 소프트웨어라 할지라도 커널에 대한 직접적인 제어 권한을 최소화하고 eBPF처럼 안전한 커널 API를 활용해야 합니다. 또한, 단계적 배포 의무화와 자동화된 롤백 시스템 구축을 통해 공급망 리스크를 완화해야 합니다.

*   **주제 3: "AI가 직접 공격하는 시대 — 자율 사이버공격과 방어 자동화"**
    *   **핵심 메시지**: AI가 작업의 80~90%를 스스로 수행하는 에이전틱 공격이 등장한 이상, 방어도 탐지-대응 루프를 완전 자동화해야 합니다.
    *   **발표 3단 구조**:
        *   **문제**: Anthropic이 보고한 AI 자율 공격 사례처럼, 공격의 속도와 규모가 인간의 수동 대응 능력을 압도하기 시작했으며, AI 에이전트의 폭증이 새로운 공격 표면이 되고 있습니다.
        *   **근거**: AI 공격은 취약점 스캔, 코드 생성, 침투, 수평 이동까지 수 분 내에 자동으로 진행될 수 있어 인간 분석가가 로그를 보고 상황을 파악하는 데는 수 시간이 걸려, 대응이 항상 늦을 수밖에 없습니다.
        *   **제언**: '인간 주도-AI 보조'가 아닌 'AI 주도-인간 감독'의 방어 체계가 필요합니다. 행위 기반으로 이상 징후를 포착하고, 머신러닝으로 위협 여부를 판단하며, 사전 정의된 정책에 따라 자동으로 차단/격리하는 '자율 대응 시스템'을 구축해야 합니다.

*   **주제 4: "4년간 숨어 있던 침입자 — 통신 3사 사태와 커널 수준 백도어"**
    *   **핵심 메시지**: 포트를 열지 않는 BPFDoor는 기존 보안 체계를 무력화하므로, 커널 수준의 행위 기반 탐지가 유일한 해법입니다.
    *   **발표 3단 구조**:
        *   **문제**: 한국 통신 3사가 수년간 국가 배후 공격에 침해당한 사실조차 인지하지 못했으며, 기존의 네트워크 기반, 시그니처 기반 보안은 BPFDoor처럼 고도로 은폐된 위협 앞에서 무력합니다.
        *   **근거**: BPFDoor는 포트를 열지 않고, 정상 커널 기능을 악용하며, 특정 신호에만 반응합니다. 이는 '성곽형' 경계 보안의 탐지를 완벽히 우회할 수 있음을 보여주며, 컨테이너 환경의 구조적 취약점을 악용할 수 있습니다.
        *   **제언**: 이제 보안의 패러다임을 '실행' 중심으로 옮겨야 합니다. 애플리케이션의 모든 행위가 거쳐가는 최종 관문인 시스템 콜을 동적으로 관측하고, 정상 행위 프로파일에서 벗어나는 이상 징후를 탐지하는 '런타임 보안'을 구축해야 합니다.

*   **주제 5: "'Q-Day'를 대비하라, 양자내성암호(PQC) 표준화와 우리의 과제"**
    *   **핵심 메시지**: NIST의 PQC 표준 발표는 모든 암호화된 정보의 유효기간에 대한 '시한폭탄'이 작동했음을 의미하며, 미래의 데이터 주권을 지키기 위해 지금 무엇을 준비해야 하는지 제안합니다.
    *   **발표 3단 구조**:
        *   **문제**: 고성능 양자컴퓨터가 등장하면 현재 인터넷 뱅킹 등에 널리 쓰이는 공개키 암호가 순식간에 무력화되는 'Q-Day'가 도래하여 모든 디지털 정보의 기밀성과 무결성이 위협받습니다.
        *   **근거**: 2024년 NIST가 PQC 표준을 공식 발표하며 양자 시대 암호화 전환의 서막을 알렸습니다. '하베스트 나우, 디크립트 레이터' 공격을 통해 현재 탈취된 암호화된 데이터가 미래에 해독될 위험이 있습니다.
        *   **제언**: 기업과 정부는 '암호 민첩성(Crypto Agility)'을 확보하고, NIST 표준에 기반한 PQC 전환 로드맵을 수립해야 합니다. 시스템의 암호화 현황을 파악하고 PQC 전환 테스트베드를 구축하는 등 선제적인 대응이 필수적입니다.

## E. 모범답안집

**1. (질문) 지원자께서 경험한 컨테이너 환경에서 제로 트러스트 원칙을 구현한다면 어떤 식으로 접근하시겠습니까?**
(모범답안) 네, 컨테이너 환경에서 제로 트러스트를 구현하려면, 먼저 개별 컨테이너와 그 안에서 실행되는 프로세스를 가장 작은 신뢰 단위로 설정하는 것부터 시작하겠습니다. 제가 컨테이너 보안을 연구하며 시스템 콜을 동적으로 관측했던 경험에 비추어 볼 때, 가장 중요한 것은 컨테이너 간의 모든 네트워크 통신과 컨테이너 내부의 행위를 '최소 권한 원칙'에 따라 통제하는 것입니다. 예를 들어, 웹 서버 컨테이너는 DB 컨테이너의 특정 포트에만 접근할 수 있도록 네트워크 정책을 설정하고, 커널 수준에서 해당 컨테이너가 파일 시스템에 쓰기 권한을 갖거나 예상치 못한 프로세스를 실행하지 못하도록 시스템 콜을 제한하는 방식입니다. 이런 정책을 eBPF와 같은 커널 기술을 이용해 구현하면, 침해 사고가 발생하더라도 피해를 해당 컨테이너 내부로 격리하는 효과를 얻을 수 있습니다.

**2. (질문) Log4Shell과 같은 제로데이 취약점을 런타임 환경에서 탐지하고 대응할 방안이 있을까요? 지원자 경험과 연결해서 설명해주세요.**
(모범답안) 네, 가능하다고 생각합니다. Log4Shell 같은 제로데이 공격은 결국 공격 코드가 실행되는 과정에서 비정상적인 시스템 행위를 유발하기 때문입니다. 제가 수행했던 '시스템 콜 동적 관측을 통한 이상탐지' 연구가 바로 이런 상황에 효과적으로 대응할 수 있는 방법론입니다. Log4Shell 공격은 일반적으로 외부에서 악의적인 명령을 받아와 셸을 실행시키려 합니다. 이때 커널 수준에서는 정상적인 자바 애플리케이션이라면 절대 호출하지 않을 `execve` 같은 시스템 콜로 새로운 프로세스를 생성하거나, `connect` 시스템 콜로 알 수 없는 외부 서버와 통신을 시도하게 됩니다. 사전에 정상 애플리케이션의 시스템 콜 패턴을 프로파일링 해두고, 실시간으로 이를 감시하다가 이처럼 예상치 못한 시스템 콜이 발생하는 순간 즉시 해당 프로세스를 차단하거나 격리하여 공격이 성공하기 전에 막을 수 있습니다.

**3. (질문) 시스템 콜 관측을 통한 이상탐지 기법의 단점이나 한계는 무엇이라고 생각하시나요?**
(모범답안) 시스템 콜 기반 이상탐지는 강력하지만, 크게 두 가지 한계를 가집니다. 첫째는 '오탐(False Positive)'의 가능성이고, 둘째는 '성능 오버헤드'입니다. 제가 모델을 개발하며 가장 어려웠던 점이, 정상적인 행위의 범위를 완벽하게 정의하는 것이었습니다. 예를 들어 소프트웨어 업데이트나 관리자의 긴급 작업처럼 예측하지 못했지만 정상적인 행위가 발생하면, 이를 공격으로 오인하여 경보를 울리거나 서비스를 중단시킬 수 있습니다. 또한, 모든 시스템 콜을 추적하고 분석하는 과정은 필연적으로 시스템에 부하를 주어 성능 저하를 일으킬 수 있습니다. 저는 이 문제를 해결하기 위해 Linux 커널 내에서 효율적으로 동작하는 eBPF를 활용해 오버헤드를 최소화했고, 정상 행위의 변화를 스스로 학습하고 적응하는 머신러닝 모델을 적용하여 오탐을 줄이는 방향으로 연구를 진행했습니다.

**4. (질문) 공급망 공격을 방어하기 위해 SBOM이 언급되는데, SBOM만으로 충분할까요? 개발자 입장에서 추가로 어떤 노력을 할 수 있을까요?**
(모범답안) SBOM은 공격 발생 시 신속한 사후 대응을 가능하게 하지만, 공격을 예방하는 데는 한계가 있어 개발자단의 추가적인 노력이 반드시 필요하다고 생각합니다. SBOM은 소프트웨어의 '성분표'일 뿐, 그 성분(라이브러리)이 안전한지, 혹은 빌드 과정에서 변조되지 않았는지를 보장하지 않기 때문입니다. 개발자 입장에서는 첫째, 코드 저장소(Git)에서부터 빌드, 배포까지 전 과정의 무결성을 보장하는 SLSA(Supply-chain Levels for Software Artifacts) 같은 프레임워크를 도입해 빌드 프로세스 자체를 보호해야 합니다. 둘째, 제가 컨테이너 보안을 다루며 중요하게 생각했던 것처럼, 최종 산출물에 대해 런타임 보안을 적용하는 것입니다. 즉, 개발 단계부터 이 애플리케이션이 사용할 시스템 콜이나 접근할 파일 목록 등 정상 행위 프로파일을 미리 정의하고, 이를 런타임 보안 정책으로 적용하여 SBOM에 없는 잠재적 위협까지도 통제하는 '설계 기반 보안(Security by Design)' 접근이 필요합니다.

**5. (질문) 랜섬웨어 공격을 받았을 때, 몸값을 지불해야 할까요, 말아야 할까요? 지불하지 않는 것이 원칙이라면, 코스타리카처럼 국가 기능이 마비될 정도의 피해는 어떻게 감수해야 할까요?**
(모범답안) 원칙적으로 몸값은 절대 지불하지 않아야 한다고 생각합니다. 몸값 지불은 공격자들의 비즈니스 모델을 성공시켜주고, 결국 더 많은 공격을 유발하는 악순환을 만들기 때문입니다. 코스타리카 사태처럼 막대한 피해가 예상되더라도 지불이 근본적인 해결책이 될 수는 없습니다. 대신, 이런 최악의 상황을 대비한 '사이버 회복탄력성' 확보에 투자하는 것이 진정한 해법입니다. 여기에는 주기적인 오프라인 백업과 신속한 복구 체계 구축, 그리고 무엇보다 피해가 확산되기 전 공격을 탐지하고 격리하는 시스템이 포함됩니다. 제가 연구했던 시스템 콜 기반 이상 탐지 기술은 랜섬웨어가 파일을 암호화하기 위해 일으키는 비정상적인 파일 접근 패턴을 초기에 포착하여, 실제 암호화가 진행되기 전에 공격을 차단하고 피해를 최소화하는 데 기여할 수 있습니다.

**6. (질문) CrowdStrike 사태처럼 커널 수준 보안 솔루션이 장애를 일으키는 걸 막을 근본적인 대책은 무엇이라 생각하나요?**
(모범답안) 네, 근본적인 대책은 보안 솔루션이라 할지라도 커널에 대한 직접적인 제어 권한을 최소화하는 것이라고 생각합니다. 제가 컨테이너 보안 프로젝트를 진행하며 리눅스 커널의 동작 방식을 분석해본 결과, 커널은 아주 작은 오류 하나가 시스템 전체를 멈추게 할 수 있는 민감한 영역이기 때문입니다. 이를 해결하기 위해 첫째, 커널에 직접 코드를 심기보다 eBPF처럼 커널이 제공하는 안전한 API를 통해 필요한 정보만 얻는 방식으로 전환해야 합니다. 둘째, 업데이트 배포 시 소수 그룹부터 점진적으로 적용하는 '카나리 배포'를 의무화하고, 마지막으로 문제 발생 시 자동으로 이전 버전으로 복귀하는 롤백 장치를 마련해 '사람의 실수'가 재앙으로 번지는 것을 막아야 합니다.

**7. (질문) BPFDoor 같은 커널 수준 백도어는 왜 탐지가 어렵고, 어떻게 대응해야 할까요?**
(모범답안) 네, BPFDoor는 명령을 받기 위해 특정 포트를 열지 않고 커널 수준에서 네트워크 패킷을 직접 엿듣기 때문에 전통적인 포트 스캔이나 방화벽 정책으로 감지할 수 없습니다. 또한 정상적인 시스템 프로세스로 위장하여 활동하므로, 시그니처 기반의 백신으로도 잡아내기 힘들어 탐지가 매우 어렵습니다. 이에 대응하려면 공격자와 같은 위치, 즉 커널 수준에서 시스템의 '행위'를 직접 감시해야 합니다. 제가 컨테이너 보안 프로젝트에서 시스템 콜을 동적으로 관측해 이상 행위를 탐지하는 기술을 개발했던 경험이 바로 이러한 접근법에 해당합니다. 시스템의 모든 동작이 최종적으로 거치는 시스템 콜의 흐름을 실시간 분석하면, BPFDoor가 악성 행위를 위해 시도하는 비정상적 네트워크 연결이나 프로세스 생성 같은 미세한 흔적을 포착하고 차단할 수 있습니다.

**8. (질문) BYOVD 기법으로 EDR을 무력화하는 공격을 구체적으로 어떻게 탐지하고 대응할 수 있나요?**
(모범답안) 네, EDR과 독립된 커널 수준의 관측 계층을 구축하는 것이 핵심입니다. BYOVD 공격은 정상적으로 서명된 드라이버를 이용해 커널 권한을 얻고 보안 프로세스를 종료시키는데, 이는 커널 위에서 동작하는 EDR 자신은 탐지하기 어렵습니다. 저는 리눅스 커널 환경에서 시스템 콜을 동적 관측하여 정상 프로세스의 행위 프로파일을 벗어나는 이상 징후를 탐지하는 연구를 했습니다. 이 경험을 살려, eBPF와 같은 기술로 커널에 직접 관측 도구를 설치하여 의심스러운 드라이버 로드나 보안 프로세스를 향한 비정상적인 접근 시도를 EDR과 별개로 탐지하는 다층 방어 체계를 제안할 수 있습니다.

**9. (질문) 자율적으로 행동하는 AI 에이전트에 제로트러스트 원칙, 특히 '최소 권한의 원칙'을 어떻게 적용할 수 있을까요?**
(모범답안) 에이전트를 독립된 신원으로 보고, 매 작업을 수행하는 그 순간에만 필요한 최소한의 임시 자격증명을 발급하고 회수하는 '실행 시점(Just-in-Time)' 권한 부여가 핵심입니다. 저는 컨테이너 환경에서 워크로드의 정상 행위 프로파일을 시스템 콜 기반으로 학습시키고, 이를 벗어나는 행위를 차단하는 이상탐지 시스템을 개발한 경험이 있습니다. 이와 유사하게, AI 에이전트가 수행하는 API 호출이나 시스템 접근 패턴을 학습하여 '정상적인 행동 범위'를 정의하고, 이 범위를 벗어나는 모든 활동을 최소 권한 원칙 위반으로 간주하여 실시간으로 차단하거나 재인증을 요구하는 방식으로 제로트러스트를 구현할 수 있습니다.

## F. 지원자 경험 연계 포인트

*   **컨테이너 환경 제로트러스트**: 컨테이너별 최소 권한 네트워크 통제 및 시스템 콜 제한을 통한 피해 격리.
*   **런타임 제로데이 방어**: 시스템 콜 동적 관측 기반 이상 탐지로 Log4Shell 등 제로데이 공격의 비정상 시스템 콜(execve, connect)을 차단하여 공격 성공 전 방어.
*   **공급망 공격 방어**: 개발 단계부터 애플리케이션의 정상 시스템 콜 프로파일을 정의하고 런타임 보안 정책으로 적용하여 SBOM에 없는 잠재적 위협까지 통제.
*   **커널 수준 백도어(BPFDoor) 탐지**: BPFDoor가 악성 행위를 위해 시도하는 비정상적 시스템 콜 패턴(네트워크 연결, 프로세스 생성)을 실시간 분석하여 탐지 및 차단.
*   **AI 에이전트 보안**: AI 에이전트의 API 호출 및 시스템 접근 패턴 학습을 통해 비정상 활동 감지 및 최소 권한 원칙 적용.

## G. 빠른 암기 카드

| 연도 | 영역/키워드 | 내용 |
|---|---|---|
| **2021** | 랜섬웨어 | 콜로니얼 파이프라인 공격 (국가 안보 위협), RaaS 산업화 |
| | 공급망 보안 | SolarWinds 및 Log4Shell 취약점으로 공급망 공격 대두 |
| | 제로트러스트 | 미국 바이든 행정명령 14028 (연방정부 제로트러스트 의무화) |
| | 피해액 | 전 세계 랜섬웨어 피해액 약 200억 달러 (전년 대비 57배 증가, 추정) |
| **2022** | 제로트러스트 | OMB M-22-09 발표 (연방 제로트러스트 의무화) |
| | 신원 기반 공격 | Lapsus$ 그룹, MFA 피로 공격, SIM 스와핑으로 대기업 침해 |
| | 사이버전 | 러시아-우크라이나 전쟁, HermeticWiper 등 와이퍼 악성코드 사용 |
| | 랜섬웨어 | Conti 그룹 해체, LockBit 부상, 코스타리카 정부 마비 (국가 비상사태) |
| **2023** | 공급망 공격 | MOVEit 제로데이 취약점 (Cl0p), 2,700개 이상 기관, 9,330만 명 데이터 유출 |
| | 랜섬웨어 | '갈취 전용(Exfiltration-only)' 공격 대두 (데이터 탈취 후 협박) |
| | AI 보안 | OWASP LLM Top 10 출범 (프롬프트 인젝션 등 AI 위협 정의) |
| | 제로트러스트 | CISA 제로트러스트 성숙도 모델 2.0 발표 (구체적 로드맵 제시) |
| | 지급액 | 랜섬웨어 총수익 11억 달러 돌파 (사상 최고치, Chainalysis) |
| **2024** | 핵심 인프라 | Change Healthcare 랜섬웨어 공격 (미국 의료 시스템 최악의 유출, 1억 명 이상 의료 정보) |
| | 공급망 보안 | CrowdStrike 전 세계 IT 장애 (Channel File 291 결함, 850만 대 Windows 시스템 마비) |
| | 랜섬웨어 | Operation Cronos (FBI 주도 LockBit 단속, 10개국 공조) |
| | PQC | NIST 양자내성암호 표준 3종 발표 (ML-KEM, ML-DSA, SLH-DSA) |
| | 지급액 | 전 세계 랜섬 지급액 8.14억 달러 (2023년 대비 35% 감소, LockBit 단속 영향) |
| **2025** | 국가 배후 공격 | 한국 통신 3사(SKT, KT, LG U+) 전면 침해 확인 (BPFDoor 백도어) |
| | 커널 백도어 | BPFDoor (포트 열지 않고 매직 패킷에 반응, 초은닉형) 표준화 |
| | AI 공격 | Anthropic, AI 자율 사이버공격 첫 보고 (80~90% 자율 수행) |
| | 랜섬웨어 | 암호화 없는 '탈취 후 갈취(Extortion)' 모델로 전환 (77% 데이터 유출 동반) |
| | 정보보안 시장 | 전 세계 정보보안 최종 사용자 지출 약 2,130억 달러 전망 (Gartner) |
| **2026** | 침해 원인 | 취약점 악용이 침해의 최대 원인 (2025년 사건의 40% 차지) |
| | AI 보안 | 에이전틱 AI 신원 폭증 (머신 신원 대 사람 비율 50:1~500:1, CSA) |
| | EDR 무력화 | BYOVD (Bring Your Own Vulnerable Driver) 기반 EDR 무력화 표준화 |
| | PQC | 랜섬웨어에 양자내성 알고리즘 (Kyber1024) 채택 사례 등장 |
| | 시장 전망 | 글로벌 정보보안 지출 약 2,442억 달러 전망 (Gartner) |

## H. 참고

*   [2021](2021.md)
*   [2022](2022.md)
*   [2023](2023.md)
*   [2024](2024.md)
*   [2025](2025.md)
*   [2026](2026.md)

*   Wikipedia, 2021-05-07, [https://en.wikipedia.org/wiki/Colonial_Pipeline_ransomware_attack](https://en.wikipedia.org/wiki/Colonial_Pipeline_ransomware_attack)
*   CISA, 2021-05-12, [https://www.cisa.gov/topics/cybersecurity-best-practices/executive-order-improving-nations-cybersecurity](https://www.cisa.gov/topics/cybersecurity-best-practices/executive-order-improving-nations-cybersecurity)
*   Fortinet, 2021, [https://www.fortinet.com/blog/threat-research/new-supply-chain-ransomware-attack-targets-kaseya-platform](https://www.fortinet.com/blog/threat-research/new-supply-chain-ransomware-attack-targets-kaseya-platform)
*   Invicti, 2023, [https://www.invicti.com/blog/web-security/software-supply-chain-security-in-2023-after-solarwinds-log4j](https://www.invicti.com/blog/web-security/software-supply-chain-security-in-2023-after-solarwinds-log4j)
*   Micro Focus, 2021, [https://www.microfocus.com/en-us/solarwinds-supply-chain-attack](https://www.microfocus.com/en-us/solarwinds-supply-chain-attack)
*   KISA RISC, 2021, [https://risc.kisa.or.kr/inform/secInfoDetail.do?scrtyInfoId=SCR_0000000000000021](https://risc.kisa.or.kr/inform/secInfoDetail.do?scrtyInfoId=SCR_0000000000000021)
*   Cybersecurity Ventures, 2021, [https://cybersecurityventures.com/global-ransomware-damage-costs-predicted-to-reach-20-billion-usd-by-2021/](https://cybersecurityventures.com/global-ransomware-damage-costs-predicted-to-reach-20-billion-usd-by-2021/)
*   Varonis, 2021, [https://www.varonis.com/blog/ransomware-statistics](https://www.varonis.com/blog/ransomware-statistics)
*   NIST Special Publication 800-207, Zero Trust Architecture, 2020-08-15, [https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-207.pdf](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-207.pdf)
*   White House, 2022-01-26, [https://www.whitehouse.gov/wp-content/uploads/2022/01/M-22-09.pdf](https://www.whitehouse.gov/wp-content/uploads/2022/01/M-22-09.pdf)
*   BleepingComputer, 2022, [https://www.bleepingcomputer.com/news/security/lapsus-suspects-arrested-for-microsoft-nvidia-okta-hacks/](https://www.bleepingcomputer.com/news/security/lapsus-suspects-arrested-for-microsoft-nvidia-okta-hacks/)
*   Wikipedia, 2022, [https://en.wikipedia.org/wiki/2022_Costa_Rican_ransomware_attack](https://en.wikipedia.org/wiki/2022_Costa_Rican_ransomware_attack)
*   Fortune, 2022-03-24, [https://fortune.com/2022/03/24/mastermind-lapsus-microsoft-nvidia-okta-hack-16-year-old-living-mom/](https://fortune.com/2022/03/24/mastermind-lapsus-microsoft-nvidia-okta-hack-16-year-old-living-mom/)
*   Verizon DBIR 2022, [https://www.verizon.com/business/resources/reports/2022-dbir-data-breach-investigations-report.pdf](https://www.verizon.com/business/resources/reports/2022-dbir-data-breach-investigations-report.pdf)
*   Varonis, [https://www.varonis.com/blog/ransomware-statistics](https://www.varonis.com/blog/ransomware-statistics)
*   StationX, [https://app.stationx.net/articles/ransomware-statistics](https://app.stationx.net/articles/ransomware-statistics)
*   Wikipedia, 2023, [https://en.wikipedia.org/wiki/2023_MOVEit_data_breach](https://en.wikipedia.org/wiki/2023_MOVEit_data_breach)
*   CISA, 2023, [https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-158a](https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-158a)
*   CISA, 2023-04-11, [https://www.cisa.gov/news-events/alerts/2023/04/11/cisa-releases-zero-trust-maturity-model-version-2](https://www.cisa.gov/news-events/alerts/2023/04/11/cisa-releases-zero-trust-maturity-model-version-2)
*   OWASP GenAI, 2023, [https://genai.owasp.org/llm-top-10/](https://genai.owasp.org/llm-top-10/)
*   디지털데일리, 2023-01-10, [https://m.ddaily.co.kr/page/view/2023011018500482750](https://m.ddaily.co.kr/page/view/2023011018500482750)
*   Chainalysis, 2024, [https://www.chainalysis.com/blog/ransomware-2024/](https://www.chainalysis.com/blog/ransomware-2024/)
*   BlackFog, 2024, [https://www.blackfog.com/change-healthcare-landmark-cybersecurity-breach/](https://www.blackfog.com/change-healthcare-landmark-cybersecurity-breach/)
*   Europol, 2024, [https://www.europol.europ.eu/media-press/newsroom/news/law-enforcement-disrupt-worlds-biggest-ransomware-operation](https://www.europol.europ.eu/media-press/newsroom/news/law-enforcement-disrupt-worlds-biggest-ransomware-operation)
*   NIST, 2024-08, [https://www.nist.gov/news-events/news/2024/08/nist-releases-first-3-finalized-post-quantum-encryption-standards](https://www.nist.gov/news-events/news/2024/08/nist-releases-first-3-finalized-post-quantum-encryption-standards)
*   SecurityWeek, 2025, [https://www.securityweek.com/ransomware-payments-dropped-to-813-million-in-2024/](https://www.securityweek.com/ransomware-payments-dropped-to-813-million-in-2024/)
*   TechCrunch, 2025-01-27, [https://techcrunch.com/2025/01/27/how-the-ransomware-attack-at-change-healthcare-went-down-a-timeline/](https://techcrunch.com/2025/01/27/how-the-ransomware-attack-at-change-healthcare-went-down-a-timeline/)
*   Wikipedia, 2024, [https://en.wikipedia.org/wiki/2024_CrowdStrike-related_IT_outages](https://en.wikipedia.org/wiki/2024_CrowdStrike-related_IT_outages)
*   데일리시큐, 2025-07-04, [https://www.dailysecu.com/news/articleView.html?idxno=167661](https://www.dailysecu.com/news/articleView.html?idxno=167661)
*   대한민국 정책브리핑, 2025-05-19, [https://www.korea.kr/news/policyNewsView.do?newsId=148943312](https://www.korea.kr/news/policyNewsView.do?newsId=148943312)
*   보안뉴스, 2025, [https://m.boannews.com/html/detail.html?idx=141268](https://m.boannews.com/html/detail.html?idx=141268)
*   한국경제, 2025-12-29, [https://www.hankyung.com/article/202512299817i](https://www.hankyung.com/article/202512299817i)
*   Nextgov/FCW, 2025-08-27, [https://www.nextgov.com/cybersecurity/2025/08/salt-typhoon-hackers-targeted-over-80-countries-fbi-says/407719/](https://www.nextgov.com/cybersecurity/2025/08/salt-typhoon-hackers-targeted-over-80-countries-fbi-says/407719/)
*   Mayer Brown, 2025-06, [https://www.mayerbrown.com/en/insights/publications/2025/06/president-trump-signs-cybersecurity-executive-order](https://www.mayerbrown.com/en/insights/publications/2025/06/president-trump-signs-cybersecurity-executive-order)
*   Anthropic, 2025-11-14, [https://www.anthropic.com/news/disrupting-AI-espionage](https://www.anthropic.com/news/disrupting-AI-espionage)
*   Wikipedia: Scattered Spider, [https://en.wikipedia.org/wiki/Scattered_Spider](https://en.wikipedia.org/wiki/Scattered_Spider)
*   Chainalysis, 2025-02, [https://www.chainalysis.com/blog/crypto-crime-ransomware-victim-extortion-2025/](https://www.chainalysis.com/blog/crypto-crime-ransomware-victim-extortion-2025/)
*   Gartner, 2025-07-29, [https://www.gartner.com/en/newsroom/press-releases/2025-07-29-gartner-forecasts-worldwide-end-user-spending-on-information-security-to-total-213-billion-us-dollars-in-2025](https://www.gartner.com/en/newsroom/press-releases/2025-07-29-gartner-forecasts-worldwide-end-user-spending-on-information-security-to-total-213-billion-us-dollars-in-2025)
*   Techzine, 2025, [https://www.techzine.eu/news/security/139330/2025-was-a-new-record-year-for-ransomware/](https://www.techzine.eu/news/security/139330/2025-was-a-new-record-year-for-ransomware/)
*   Industrial Cyber, 2025, [https://industrialcyber.co/ransomware/acronis-report-finds-80-of-ransomware-groups-promote-ai-features-as-phishing-and-automation-scale-operations/](https://industrialcyber.co/ransomware/acronis-report-finds-80-of-ransomware-groups-promote-ai-features-as-phishing-and-automation-scale-operations/)
*   IBM Newsroom, 2026-02-25, [https://newsroom.ibm.com/2026-02-25-ibm-2026-x-force-threat-index-ai-driven-attacks-are-escalating-as-basic-security-gaps-leave-enterprises-exposed](https://newsroom.ibm.com/2026-02-25-ibm-2026-x-force-threat-index-ai-driven-attacks-are-escalating-as-basic-security-gaps-leave-enterprises-exposed)
*   Securelist(Kaspersky), 2026, [https://securelist.com/state-of-ransomware-in-2026/119761/](https://securelist.com/state-of-ransomware-in-2026/119761/)
*   Cloud Security Alliance, 2026-02-02, [https://cloudsecurityalliance.org/blog/2026/02/02/the-agentic-trust-framework-zero-trust-governance-for-ai-agents](https://cloudsecurityalliance.org/blog/2026/02/02/the-agentic-trust-framework-zero-trust-governance-for-ai-agents)
*   Cloud Security Alliance, 2026-03-24, [https://cloudsecurityalliance.org/press-releases/2026/03/24/more-than-two-thirds-of-organizations-cannot-clearly-distinguish-ai-agent-from-human-actions](https://cloudsecurityalliance.org/press-releases/2026/03/24/more-than-two-thirds-of-organizations-cannot-clearly-distinguish-ai-agent-from-human-actions)
*   Google Cloud Threat Intelligence, 2025-10, [https://cloud.google.com/blog/topics/threat-intelligence/oracle-ebusiness-suite-zero-day-exploitation](https://cloud.google.com/blog/topics/threat-intelligence/oracle-ebusiness-suite-zero-day-exploitation)
*   Software Strategies Blog(Gartner 인용), 2026-02-10, [https://softwarestrategiesblog.com/2026/02/10/gartner-cybersecurity-trends-2026/](https://softwarestrategiesblog.com/2026/02/10/gartner-cybersecurity-trends-2026/)
*   Precedence Research, 2026, [https://www.precedenceresearch.com/zero-trust-security-market](https://www.precedenceresearch.com/zero-trust-security-market)
