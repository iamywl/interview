# 로봇 · 휴머노이드 — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
로봇 산업은 단순한 산업용 기계를 넘어, AI 기술의 발전과 함께 인간의 일상과 산업 전반에 걸쳐 혁신을 주도하고 있습니다. 특히 인공지능과 결합된 휴머노이드 로봇은 노동력 부족 문제의 근본적인 해결책이자 거대한 미래 시장의 핵심 동력으로 급부상하고 있습니다. 빅테크 기업과 대규모 자본이 참여하며 양산과 현장 실증이 본격화되는 가운데, 로봇의 물리적 안전과 사이버 보안 문제 해결이 필수적인 중요한 기술 분야로 부상했습니다.

## B. 반드시 아는 핵심 개념 사전
*   **휴머노이드 로봇 (Humanoid Robot)**
    *   **(1) 한 줄 정의**: 인간의 신체 구조를 모방하여, 사람이 생활하는 환경과 사용하는 도구를 그대로 활용하도록 만든 로봇입니다.
    *   **(2) 어떻게 동작하나**: 카메라, IMU, 힘/토크 센서 등으로 주변 환경과 자신의 자세를 인지하고, AI 두뇌가 행동을 계획하며, 수십 개의 정밀 모터(액추에이터)를 제어하여 균형을 잡고 걷거나 물체를 조작합니다.
    *   **(3) 무엇이 달라지나**: 이론적으로 인간의 모든 물리적 노동을 대체할 수 있는 '궁극의 범용 로봇'이 될 가능성을 열었으며, 공장, 물류창고를 넘어 가정, 재난 현장 등 모든 곳에서 활용될 수 있습니다.

*   **SLAM (Simultaneous Localization and Mapping)**
    *   **(1) 한 줄 정의**: 로봇이 처음 보는 낯선 환경을 돌아다니면서 실시간으로 '지도'를 그리고, 동시에 그 지도 안에서 '자신의 현재 위치'를 추정하는 기술입니다.
    *   **(2) 어떻게 동작하나**: LiDAR나 카메라 센서로 주변 환경의 특징점을 인식하고, 이 특징점들의 상대적 위치 관계를 바탕으로 지도를 만듭니다. 로봇이 움직이며 새로 관측되는 특징점 정보와 이전에 만든 지도를 비교하며 자신의 위치와 방향을 보정합니다.
    *   **(3) 무엇이 달라지나**: 로봇 청소기, 서빙 로봇, 물류 로봇, 자율주행차 등 스스로 움직이는 모든 로봇의 '눈'과 '공간지각능력'을 책임지는 핵심 기술로, 로봇이 변화하는 환경에 적응하는 지능형 에이전트가 되게 합니다.

*   **소프트웨어 정의 로봇 (Software-Defined Robot, SDR)**
    *   **(1) 한 줄 정의**: 로봇의 기능과 가치가 하드웨어보다 소프트웨어 업데이트에 의해 결정되고 지속적으로 향상되는 로봇입니다.
    *   **(2) 어떻게 동작하나**: 로봇의 모든 센서 데이터와 동작 정보를 중앙 서버로 전송하고, AI 슈퍼컴퓨터로 학습시켜 발전된 AI 모델을 만듭니다. 이 개선된 AI 모델을 무선 업데이트(OTA) 기술로 다시 모든 로봇에 내려보내 성능을 계속 발전시킵니다.
    *   **(3) 무엇이 달라지나**: 로봇의 가치 평가 기준이 '기계'에서 '플랫폼'으로 바뀌며, 로봇 제조사는 소프트웨어 업데이트와 서비스 구독을 통해 지속적인 수익을 창출할 수 있게 됩니다.

*   **액추에이터 (Actuator)**
    *   **(1) 한 줄 정의**: 로봇의 '관절' 역할을 하는 핵심 부품으로, 전기 신호를 받아 물리적인 힘이나 움직임을 만들어내는 장치입니다.
    *   **(2) 어떻게 동작하나**: 모터와 감속기, 센서 등으로 구성되며, 제어 신호에 따라 회전하거나 선형 운동을 하여 로봇 팔, 다리 등의 움직임을 구현합니다. 특히 휴머노이드 로봇은 정밀한 움직임과 미세한 힘 제어를 위해 자체 설계된 고성능 전기 액추에이터가 필요합니다.
    *   **(3) 무엇이 달라지나**: 로봇의 동작 정밀도, 반응 속도, 힘, 그리고 가장 중요한 로봇의 양산 단가를 결정하는 핵심 부품입니다. 자체 설계 및 대량생산을 통해 액추에이터 원가를 절감하는 것은 휴머노이드의 대중화를 가능하게 하는 핵심 열쇠입니다.

*   **비전-언어-행동 모델 (VLA, Vision-Language-Action Model) / 체화 AI (Embodied AI)**
    *   **(1) 한 줄 정의**: 로봇의 눈(Vision)으로 세상을 보고, 사람의 말(Language)을 이해하며, 그에 맞는 행동(Action)을 직접 생성하는 통합 인공지능 모델로, 로봇이 물리적 세계에 체화된 지능을 갖도록 합니다.
    *   **(2) 어떻게 동작하나**: 웹의 방대한 이미지-텍스트 데이터와 로봇의 실제 동작 데이터를 하나의 거대한 신경망으로 학습시킵니다. 이를 통해 언어적 지시와 시각적 정보, 물리적 행동의 연관성을 스스로 터득하여, 명시적인 코드 없이도 상황을 이해하고 행동을 생성합니다.
    *   **(3) 무엇이 달라지나**: 로봇이 특정 작업만 반복하는 기계에서 벗어나, 예측 불가능한 실제 환경에서 새로운 물건이나 추상적인 지시까지 이해하고 행동하는 '일반화' 능력을 갖추게 됩니다. 이는 인간과 로봇이 자연어로 소통하며 협업하는 길을 엽니다.

*   **휴머노이드 파운데이션 모델 (Humanoid Foundation Model)**
    *   **(1) 한 줄 정의**: 다양한 종류의 휴머노이드 로봇과 여러 상황에 범용적으로 사용될 수 있도록, 방대한 데이터로 미리 학습시켜 놓은 대규모 AI 모델입니다.
    *   **(2) 어떻게 동작하나**: 사람의 동작 비디오, 시뮬레이션 데이터, 실제 로봇 동작 데이터 등 방대한 정보를 학습하여 '물건 잡기', '걷기' 같은 기본적인 행동 원리를 스스로 터득합니다. 개발자는 이 범용 모델을 자신의 로봇 하드웨어에 맞게 미세조정하여 사용할 수 있습니다.
    *   **(3) 무엇이 달라지나**: 로봇 소프트웨어 개발의 복잡성과 비용을 획기적으로 낮춰, 더 많은 개발자가 로봇 애플리케이션을 만들 수 있게 합니다. 이는 로봇 기술 발전과 보급을 가속하는 표준 운영체제와 같은 역할을 합니다.

*   **온보드 추론 (Onboard Inference)**
    *   **(1) 한 줄 정의**: AI 모델의 연산 및 판단(추론)을 원격 클라우드 서버가 아닌, 로봇 본체에 탑재된 고성능 AI 반도체에서 직접 수행하는 방식입니다.
    *   **(2) 어떻게 동작하나**: 로봇의 카메라와 센서가 수집한 정보를 외부로 보내지 않고, 로봇 내부에 탑재된 AI 전용 반도체가 파운데이션 모델을 직접 실행하여 실시간으로 동작 명령을 생성합니다.
    *   **(3) 무엇이 달라지나**: 로봇이 통신 환경에 구애받지 않고 빠르고 안정적으로 작동할 수 있게 되어, 사람과 함께 일하는 동적인 환경에서의 활용성이 크게 높아집니다. 보안 측면에서도 민감한 데이터의 외부 유출 위험을 줄입니다.

*   **피지컬 AI 보안 (Physical AI Security)**
    *   **(1) 한 줄 정의**: 해킹으로 인해 로봇, 드론 등 물리적 AI가 오작동하여 현실 세계에 물리적 피해를 주는 것을 막기 위한 모든 기술적, 관리적 보안 활동입니다.
    *   **(2) 어떻게 동작하나**: 로봇 운영체제 수준에서 정상적인 명령 패턴을 학습하고 비정상적인 명령을 실시간 탐지 및 차단합니다. 소프트웨어를 안전한 격리 환경(컨테이너)에서 실행하고 모든 통신을 암호화하여 로봇 전체의 제어권 탈취를 방지합니다.
    *   **(3) 무엇이 달라지나**: 로봇을 우리 생활 공간에 안전하게 도입할 수 있는 전제 조건이 되며, 로봇 제조사는 '보안'을 핵심 경쟁력으로 내세우게 됩니다. 로봇의 소프트웨어 동작을 커널 수준에서부터 감시하고 통제하는 기술의 중요성이 매우 커집니다.

## C. 연도별 흐름 한눈에
*   **2021년**: 로봇 산업이 공장 생산 영역을 넘어 우리 생활 속으로 진입, 테슬라와 현대차 등 빅테크 및 완성차 기업이 휴머노이드 시장에 본격 참전. ([2021.md](2021.md))
*   **2022년**: 휴머노이드가 '기술 시연'에서 '양산 단가' 경쟁으로 전환, 소프트웨어 정의 로봇 패러다임 부상과 인간-로봇 공존 시대 개막. ([2022.md](2022.md))
*   **2023년**: 생성형 AI가 로봇의 두뇌가 되는 '체화 AI' 시대 개막, VLA 모델 등장 및 휴머노이드의 현장 실증 진입, 정교한 손 조작 능력의 중요성 부각. ([2023.md](2023.md))
*   **2024년**: 휴머노이드가 연구실을 넘어 실제 산업 현장의 '일꾼'으로 투입된 상업화 원년, AI 파운데이션 모델 선점 경쟁과 전기 구동 방식 대세화. ([2024.md](2024.md))
*   **2025년**: 휴머노이드 시장이 양산과 현장 배치 시대로 본격 진입, VLA 파운데이션 모델이 표준화되고 미-중 진영 분화 심화, 한국 대기업의 적극적 참여. ([2025.md](2025.md))
*   **2026년**: 휴머노이드 로봇이 상업적 임계점에 도달하며 양산 로드맵 구체화, 액추에이터 공급망과 VLA 모델이 핵심 승부처로 부상, 소매 유통 진입과 피지컬 AI 보안 문제의 현실화. ([2026.md](2026.md))

## D. PT 발표 주제 추천
*   **제목**: 휴머노이드, 데모를 넘어 라인으로 — 상업화 원년의 의미와 과제
    *   **핵심 메시지**: 휴머노이드 로봇은 시연 단계를 졸업하고 실제 산업 현장에서 가치를 창출하는 '일꾼'으로의 가능성을 증명하기 시작했으며, 이제 검증 가능한 데이터와 안전한 협업이 핵심 과제입니다.
    *   **발표 3단 구조**:
        *   **문제**: 지금까지 휴머노이드는 높은 개발 비용과 불확실한 효용성 때문에 '비싼 연구 장비'라는 인식을 넘지 못했습니다.
        *   **근거**: 2024년부터 Agility-GXO의 RaaS 계약, Figure-BMW의 공장 실증 등 유의미한 상업적 이정표가 등장했으며, 이는 빅테크의 AI 플랫폼 투자와 맞물려 있습니다.
        *   **제언**: 단순 시연을 넘어, 실제 현장의 가동 데이터(Uptime, ROI)에 기반한 효용성 검증과 함께, 인간 작업자와의 안전한 협업을 위한 기술적·제도적 장치 마련에 집중해야 합니다.

*   **제목**: 로봇, 드디어 세상과 대화하기 시작하다: VLA 모델과 체화 AI의 미래
    *   **핵심 메시지**: VLA 모델은 로봇을 '프로그래밍된 기계'에서 '스스로 보고 배우며 소통하는 파트너'로 바꾸는 첫걸음이며, '지능' 문제를 해결하는 핵심 기술입니다.
    *   **발표 3단 구조**:
        *   **문제**: 기존 로봇은 특정 작업만 반복 가능해, 예측 불가능한 실제 환경에 적용하기 어려웠습니다.
        *   **근거**: 구글 RT-2와 Figure Helix 등은 웹 지식으로 처음 보는 물체도 다룰 수 있음을 증명하며 로봇의 '일반화' 문제 해결의 단초를 제공했습니다.
        *   **제언**: VLA의 환각 문제를 해결할 '안전성'과 무거운 모델을 실시간으로 구동할 '경량화'가 상용화의 핵심 과제이며, 이를 위한 시스템 아키텍처 연구가 시급합니다.

*   **제목**: 뇌는 미국, 몸은 중국 — 진영 분화 속, 한국 휴머노이드의 생존 전략
    *   **핵심 메시지**: AI 모델(미국)과 저가 양산(중국)으로 갈라진 구도에서, 한국은 우리의 강점인 '정밀 부품'과 '현장 데이터'를 결합한 융합 전략으로 돌파해야 합니다.
    *   **발표 3단 구조**:
        *   **문제**: 휴머노이드 시장이 AI 모델을 주도하는 미국과 하드웨어 양산을 주도하는 중국의 양강 구도로 재편되면서, 한국의 입지가 불투명해지고 있습니다.
        *   **근거**: 삼성과 현대차는 각각 로봇 부품(레인보우로보틱스)과 실제 적용 현장(공장)이라는 강력한 무기를 가지고 있으며, 이는 AI 모델 학습에 필수적인 양질의 데이터를 확보할 기회입니다.
        *   **제언**: 미국·중국을 모방하기보다, 우리의 강점인 정밀제조 역량과 실제 산업 현장을 결합해 '특화된 고품질 데이터'를 생산하고, 이를 기반으로 특정 산업에 최적화된 '버티컬 휴머노이드' 시장을 선점하는 틈새 전략이 필요합니다.

*   **제목**: 피지컬 AI 보안의 시급성: 마트 로봇 시대의 새로운 안전 패러다임
    *   **핵심 메시지**: 휴머노이드 로봇이 소매점에서 판매되기 시작하면서, 해킹이 물리적 사고로 직결되는 '피지컬 AI 보안' 문제는 더 이상 미룰 수 없는 최우선 과제가 되었습니다.
    *   **발표 3단 구조**:
        *   **문제**: 유니트리 G1의 소매 판매는 로봇 대중화의 신호탄이지만, 동시에 잠재적 물리적 위협이 우리 일상으로 들어왔음을 의미합니다.
        *   **근거**: 실제로 발견된 UniPwn 취약점 사례(2026년)는 해커가 로봇의 제어권을 탈취해 의도적인 오작동을 일으킬 수 있음을 보여주었으며, 이는 심각한 물리적 피해로 이어질 수 있습니다.
        *   **제언**: 로봇 출시 전 보안 인증 의무화, 시스템 콜 감시 기반 이상 행위 탐지 기술처럼 런타임에 로봇 동작을 지속적으로 감시하고 통제하는 보안 솔루션 도입을 법제화해야 합니다.

## E. 모범답안집
*   **질문 1: 지원자가 경험한 컨테이너 보안 기술을 휴머노이드 로봇에 적용한다면, 어떤 아키텍처를 제안하고 싶습니까? 특히 로봇의 물리적 안전과 직결되는 부분을 중심으로 설명해 주세요.**
    *   **모범답안**: 네, 로봇의 물리적 안전을 최우선으로 고려하여 '최소 권한 원칙'에 기반한 계층적 보안 아키텍처를 제안하겠습니다. 제가 컨테이너의 공격 표면을 줄이기 위해 불필요한 시스템 콜을 제한했던 경험처럼, 로봇의 소프트웨어 모듈들도 각자에게 꼭 필요한 시스템 자원과 하드웨어에만 접근하도록 격리하는 것이 핵심입니다. 구체적으로, 실시간 균형 제어나 모터 구동처럼 즉각적인 반응이 필수적인 핵심 기능은 가장 안쪽의 신뢰 실행 환경(Trusted Execution Environment)에서 실행하고, 비전 처리, 음성 인식, 외부 통신 등 상대적으로 덜 치명적인 기능들은 컨테이너 기술로 샌드박싱하여 바깥 계층에 배치하겠습니다. 이렇게 하면 만약 외부 공격으로 비전 인식 컨테이너가 탈취되더라도, 사전에 허가되지 않은 시스템 콜, 예를 들어 모터 제어기에 직접 접근하는 호출은 커널 수준에서 원천적으로 차단할 수 있습니다. 이를 통해 소프트웨어 결함이나 외부 공격이 로봇의 물리적 오작동으로 이어지는 것을 막을 수 있습니다.

*   **질문 2: 협동로봇의 안전을 위해 힘/토크 센서 외에, 지원자가 연구한 '시스템 콜 동적 관측' 같은 소프트웨어적 이상탐지 기법을 적용할 수 있을까요? 가능하다면 어떤 방식으로 구현하고 싶으신가요?**
    *   **모범답안**: 네, 매우 효과적이고 중요한 접근이라고 생각합니다. 물리적 센서가 '충돌 후'의 반응이라면, 소프트웨어적 이상탐지는 '충돌 전'의 이상 징후를 포착하는 예측적 안전 장치가 될 수 있습니다. 제가 컨테이너 내부 프로세스의 시스템 콜 순서를 관찰하여 정상 행위 프로파일을 만들고, 여기서 벗어나는 패턴을 이상 행위로 탐지했던 것처럼, 협동로봇에도 동일한 원리를 적용할 수 있습니다. 먼저 로봇이 정상적인 용접이나 조립 작업을 수행할 때 발생하는 관절 각도, 속도, 모터 전류, 토크 센서 값의 시계열 데이터를 학습하여 '정상 작업 모델'을 구축합니다. 그 후 실제 작업 중에 이 모델의 예측에서 통계적으로 크게 벗어나는 센서 패턴이 실시간으로 관측되면, 물리적 충돌이 일어나기 전이라도 이를 잠재적 위험 상황으로 판단하고 로봇을 즉시 정지시키거나 속도를 줄이는 방식입니다. 이는 현재의 물리적 센서 기반 안전 시스템을 보완하는 강력한 다중 방어 체계가 될 것입니다.

*   **질문 3: 로봇의 정밀한 움직임을 제어하기 위해 '실시간 운영체제(RTOS)'가 중요하다고 합니다. 지원자가 이해하는 리눅스 커널과 비교하여 RTOS의 핵심적인 특징은 무엇이라고 생각하십니까?**
    *   **모범답안**: 제가 리눅스 커널을 공부하며 이해한 바로, 일반 리눅스 커널 스케줄러의 최우선 목표는 '공정성'과 '전체 처리율'입니다. 여러 프로세스에게 CPU 시간을 최대한 공평하게 나눠주어 시스템 전체의 작업량을 높이는 데 초점을 맞춥니다. 하지만 RTOS의 핵심 목표는 '결정성(Determinism)', 즉 '시간 약속을 반드시 지키는 것'입니다. 로봇의 균형을 잡는 제어 코드가 1밀리초 안에 반드시 끝나야 한다면, RTOS는 다른 모든 작업을 멈춰서라도 이 시간을 보장해줍니다. 반면 일반 리눅스에서는 다른 백그라운드 프로세스 때문에 이 시간이 지연될 수 있고, 이는 로봇의 넘어짐과 같은 치명적인 물리적 불안정으로 이어질 수 있습니다. 이처럼 어떤 상황에서도 주어진 시간 제약을 반드시 지켜준다는 '응답 시간 보장'이 RTOS가 리눅스와 구별되는 가장 핵심적인 특징이라고 생각합니다.

*   **질문 4: 로봇 운영체제(ROS)의 핵심 모듈을 컨테이너화하여 배포하고 관리하는 프로젝트를 맡는다면, 가장 먼저 고려할 기술적 문제는 무엇이며 어떻게 해결하시겠습니까?**
    *   **모범답안**: ROS 모듈을 컨테이너화할 때 가장 먼저 '실시간 통신 성능 저하'와 '하드웨어 접근' 문제를 고려하겠습니다. ROS는 각 기능 모듈(노드)들이 네트워크 통신으로 데이터를 주고받는데, 컨테이너는 기본적으로 가상 네트워크 인터페이스를 통해 브릿지 네트워크를 거치므로 약간의 오버헤드와 지연(latency)을 유발합니다. 특히 고해상도 카메라나 LiDAR 데이터가 오가는 토픽(Topic)에서는 이 문제가 로봇의 반응 속도를 저하시킬 수 있습니다. 이를 해결하기 위해, 먼저 통신 성능이 중요한 컨테이너에는 'host' 네트워크 모드를 적용하여 커널의 네트워크 스택을 직접 사용하게 함으로써 오버헤드를 최소화하겠습니다. 또한, GPU나 특정 USB 카메라 같은 하드웨어에 직접 접근해야 하는 노드를 위해서는, 해당 디바이스 파일(`/dev`)을 컨테이너 내부에 명시적으로 마운트하여 직접 제어할 수 있도록 권한을 부여하겠습니다. 이렇게 하면 컨테이너의 격리 및 배포 용이성은 유지하면서도, 성능 저하와 하드웨어 제약 문제를 해결할 수 있을 것입니다.

*   **질문 5: VLA 모델은 출력이 '블랙박스' 같아 예측이 어렵다는 지적이 있습니다. 모델이 위험한 동작을 생성하지 않도록 통제할 기술적 아이디어가 있다면 무엇일까요?**
    *   **모범답안**: VLA 모델의 예측 불가능성은 안전이 최우선인 로봇 분야에서 반드시 해결해야 할 문제입니다. 저는 이 문제를 모델 자체를 제약하기보다, 모델의 출력물이 실행되는 마지막 단에서 안전을 확보하는 '런타임 가드' 방식이 현실적이라고 생각합니다. 이는 제가 컨테이너 보안을 연구하며 시스템 콜을 동적으로 관측해 이상 행위를 탐지했던 경험과 맞닿아 있습니다. 모델이 아무리 위험한 동작을 생성해도, 그것이 물리적으로 실행되기 직전의 시스템 콜 수준에서 '정의된 안전 범위를 벗어나는가'를 검증하고 차단하는 것입니다. 이를 통해 AI 모델의 유연성은 최대한 활용하면서도, 물리적 안전이라는 최후의 보루를 지킬 수 있습니다.

*   **질문 6: 온보드 추론 환경에서 로봇에 대한 물리적 접근을 통한 '런타임 공격'에 어떻게 방어하시겠습니까?**
    *   **모범답안**: 저는 리눅스 커널과 컨테이너 보안에 대한 이해를 바탕으로, 로봇의 온보드 AI 모델과 제어 소프트웨어가 실행되는 환경을 컨테이너처럼 논리적으로 격리해 다른 시스템 영역에 영향을 주지 못하도록 만들겠습니다. 그리고 제가 직접 구현해 본 시스템 콜 동적 관측 기술을 로봇 OS에 적용하여, 허가되지 않은 파일 접근이나 비정상적인 네트워크 통신 같은 이상 행위를 실시간으로 탐지하고 차단하는 체계를 구축할 것입니다. 이를 통해 악의적인 공격자가 USB나 네트워크 포트로 로봇에 직접 접근하여 악성코드를 심거나 AI 모델을 교체하여 오작동을 일으키는 것을 방어할 수 있습니다.

*   **질문 7: 유니트리 G1 같은 중국산 저가 휴머노이드 도입 시, 기술적으로 고려해야 할 보안 리스크는 무엇이며 어떻게 해결해야 한다고 생각하나요?**
    *   **모범답안**: 중국산 저가 로봇은 데이터 유출을 위한 잠재적 백도어나 공급망 공격에 노출될 위험이 가장 큰 기술적 리스크입니다. 저는 이 문제를 '제로 트러스트 기반의 강력한 격리'를 통해 해결해야 한다고 생각합니다. 즉, 로봇을 처음부터 신뢰할 수 없는 대상으로 간주하고, 제가 컨테이너 보안 프로젝트에서 활용했던 리눅스 커널의 네임스페이스나 cgroup 같은 기술을 이용해 로봇의 운영체제를 완벽한 '가상 샌드박스' 안에 가두는 것입니다. 이 샌드박스는 로봇이 외부 서버와 통신하거나 내부 시스템 파일에 접근하는 모든 행위를 통제합니다. 특히 로봇의 모든 시스템 콜과 네트워크 패킷을 실시간으로 분석하여 허가되지 않은 행위를 즉시 차단함으로써, 잠재적인 백도어가 작동할 수 있는 가능성을 원천적으로 제거하는 방식으로 대응할 수 있습니다.

*   **질문 8: 본인이 가진 역량을 바탕으로 휴머노이드 분야에 기여한다면, 어떤 부분에 가장 크게 기여하고 싶으며 그 이유는 무엇입니까?**
    *   **모범답안**: 저는 시스템의 가장 낮은 수준(low-level)을 이해하고 제어하는 역량을 바탕으로, 휴머노이드가 실제 현장에서 '안전하고 신뢰성 있게' 동작하도록 만드는 기반을 다지는 데 기여하고 싶습니다. 제가 컨테이너 보안을 위해 리눅스 커널과 시스템 콜을 깊이 파고들었던 이유는, 문제의 근본 원인이 가장 아래 단계에 있었기 때문입니다. 화려한 AI 모델이 아무리 발전해도, 결국 로봇은 물리 세계와 상호작용하는 기계이고, 이 과정에서의 안전과 신뢰성은 운영체제와 하드웨어 제어 수준에서 보장되어야 합니다. 저의 시스템 레벨 지식과 이상탐지 시스템 개발 경험은, 예측 불가능한 AI 두뇌와 실제 로봇의 몸 사이에서 '안전 감독관' 역할을 하는 런타임 보안 및 안정성 모듈을 개발하는 데 가장 큰 강점이 될 것이라 확신합니다. 저는 이 역할을 통해 커널 이해도와 서비스 구현 능력을 모두 갖춘 '융합형 개발자'로 성장하고 싶습니다.

## F. 지원자 경험 연계 포인트
*   **컨테이너 보안**: 로봇 소프트웨어 모듈을 컨테이너로 격리하여 외부 공격으로부터 시스템을 보호하고, 각 모듈의 접근 권한을 최소화하여 물리적 오작동을 방지하는 아키텍처 설계에 기여할 수 있습니다.
*   **시스템 콜 동적 관측 기반 이상탐지**: 로봇의 정상 동작 중 시스템 콜 패턴을 학습하고, 이를 벗어나는 비정상 행위(예: 악성코드 주입, 오작동 유발 명령)를 실시간으로 탐지하여 물리적 사고 발생 전에 차단하는 '런타임 보안 모니터' 구축에 핵심적인 역할을 할 수 있습니다.
*   **Linux 커널 이해**: 로봇 제어 시스템의 실시간성 보장을 위해 Linux 커널 튜닝(PREEMPT_RT 패치 등) 및 제어 프로세스 우선순위 설정에 기여하고, 시스템 콜 추적을 통해 미세한 지연의 원인을 분석하고 제거하여 로봇의 반응 속도와 안정성을 높일 수 있습니다.
*   **피지컬 AI 보안**: 로봇의 물리적 안전과 직결되는 해킹 위협에 대응하여, 커널 수준에서 로봇의 모든 시스템 콜과 네트워크 패킷을 감시하고 통제하는 '제로 트러스트' 기반의 보안 프레임워크 구현에 강점을 발휘할 수 있습니다.
*   **융합형 개발**: 컨테이너, 시스템 콜, 커널 등 low-level 시스템 지식과 서비스 구현 능력을 결합하여, AI 두뇌의 예측 불가능성을 안전하게 제어하고 신뢰할 수 있는 로봇 시스템을 만드는 데 기여할 수 있습니다.

## G. 빠른 암기 카드

| 카테고리 | 키워드 | 내용 | 연도 | 출처 |
| :------- | :----- | :--- | :--- | :--- |
| **핵심 기업** | 테슬라 | 휴머노이드 옵티머스 콘셉트 발표 (2021), 실물 시제품 및 2만 달러 양산 목표 제시 (2022), 손 설계 난제 인정 및 재설계 (2025-2026), 프리몬트 공장 옵티머스 전용 전환 및 연 100만 대 생산 목표 (2026) | 2021~2026 | Wikipedia, Electrek, TrendForce, ZDNet Korea |
| | 현대차그룹/보스턴 다이내믹스 | 보스턴 다이내믹스 인수 완료 (2021), 물류 로봇 Stretch 출시 (2021), 전기식 Atlas 공개 및 유압식 은퇴 (2024), LBM 적용 시연 (2025), Atlas 양산 로드맵 발표 (2026) | 2021~2026 | Hyundai Newsroom, Boston Dynamics, TechCrunch, Toyota Research Institute, 로봇신문, 테크42 |
| | Figure AI | 범용 휴머노이드 Figure 01 공개 (2023), 6.75억 달러 투자 유치 (2024), OpenAI와 AI 모델 공동개발 협약 (2024), BMW 공장 Figure 02 실증 투입 (2024), VLA 모델 Helix 공개 (2025), 10억 달러 이상 시리즈 C 유치 및 기업가치 390억 달러 (2025), BotQ 공장 양산 가동 (2026) | 2023~2026 | TechCrunch, PR Newswire, BimmerLife, 로봇신문, Figure 공식 보도자료 |
| | 엔비디아 | 로봇 학습 인프라(Isaac Sim), 휴머노이드 파운데이션 모델 GR00T 및 온보드 SoC Jetson Thor 발표 (2024), 오픈 휴머노이드 파운데이션 모델 Isaac GR00T N1 공개 (2025), 오픈 휴머노이드 레퍼런스 디자인 Isaac GR00T 공개 (2026) | 2024~2026 | NVIDIA Newsroom |
| | 삼성전자/레인보우로보틱스 | 로봇사업팀 신설 (2022), 레인보우로보틱스 지분 인수 (2023), 레인보우로보틱스 자회사 편입 및 미래로봇추진단 신설 (2025), 2028년 상용화 목표 휴머노이드 개발 가속 (2026) | 2022~2026 | KED Global, 삼성전자 뉴스룸, 전자신문 |
| | 유니트리 (Unitree) | 보급형 사족보행 로봇 Go1 공개 (2021), 휴머노이드 G1 1.6만 달러에 공개 (2024), G1 저가·대량 출하 및 유니콘 등극 (2025), G1 이마트/GS25 통해 소매 판매 시작 (2026) | 2021~2026 | IEEE Spectrum, The Robot Report, CNBC, KMJ, 디지털투데이 |
| **주요 기술** | VLA (비전-언어-행동) 모델 | 구글 딥마인드 PaLM-E, RT-2 공개 (2023), Figure AI Helix 공개 (2025), 로봇 지능의 표준 아키텍처로 자리매김 (2025-2026) | 2023~2026 | Google Research Blog, Google DeepMind Blog, The Robot Report |
| | 파운데이션 모델 | 엔비디아 GR00T 발표 (2024), Isaac GR00T N1 공개 (2025), 로봇 지능 개발의 표준으로 자리 잡음 (2025-2026) | 2024~2026 | NVIDIA Newsroom |
| | 액추에이터 | 테슬라 자체 설계 액추에이터 (2022), 현대모비스 아틀라스 액추에이터 독점 공급 (2026), 로봇 원가의 약 60% 차지 (2026) | 2022, 2026 | Electrek, 딜사이트 |
| | 피지컬 AI 보안 | 유니트리 UniPwn 취약점 공개 (2026), '피지컬 AI 보안 특별법' 논의 부상 (2026) | 2026 | 로봇신문, 뉴시스 |
| **시장 수치** | 휴머노이드 양산 단가 목표 | 테슬라 옵티머스 2만 달러 미만 (2022), 유니트리 G1 1.6만 달러 (2024) | 2022, 2024 | Electrek, The Robot Report |
| | Figure AI 기업가치 | 26억 달러 (2024-02), 390억 달러 (2025-09) | 2024~2025 | PR Newswire, Figure 공식 보도자료 |
| | 2026년 휴머노이드 출하량 전망 | 뱅크오브아메리카 9만 대 (전망) | 2026 | 글로벌이코노믹 |
| | 장기 시장 규모 전망 | 골드만삭스 2035년 380억 달러 (전망), 모건스탠리 2050년 5조 달러 (추정) | 2022, 2025, 2026 | CNBC, Goldman Sachs, Morgan Stanley, Investing.com |

## H. 참고
*   2021.md (@claude/research/robotics/2021.md)
*   2022.md (@claude/research/robotics/2022.md)
*   2023.md (@claude/research/robotics/2023.md)
*   2024.md (@claude/research/robotics/2024.md)
*   2025.md (@claude/research/robotics/2025.md)
*   2026.md (@claude/research/robotics/2026.md)
*   Wikipedia, "Optimus (robot)", 2021-08-19, [https://en.wikipedia.org/wiki/Optimus_(robot)](https://en.wikipedia.org/wiki/Optimus_(robot))
*   Hyundai Newsroom, "Hyundai Motor Group Completes Acquisition of Boston Dynamics from SoftBank", 2021-06-21, [https://www.hyundai.com/worldwide/en/newsroom/detail/hyundai-motor-group-completes-acquisition-of-boston-dynamics-from-softbank-0000000516](https://www.hyundai.com/worldwide/en/newsroom/detail/hyundai-motor-group-completes-acquisition-of-boston-dynamics-from-softbank-0000000516)
*   Boston Dynamics, "Boston Dynamics Unveils New Robot for Warehouse Automation (Stretch)", 2021-03-29, [https://bostondynamics.com/news/boston-dynamics-unveils-new-robot-for-warehouse-automation/](https://bostondynamics.com/news/boston-dynamics-unveils-new-robot-for-warehouse-automation/)
*   IEEE Spectrum, "Unitree's Go1 Robot Dog Looks Pretty Great, Costs Just USD $2700", 2021-06-11, [https://spectrum.ieee.org/unitrees-go1-robot-dog-looks-pretty-great-costs-just-usd-2700](https://spectrum.ieee.org/unitrees-go1-robot-dog-looks-pretty-great-costs-just-usd-2700)
*   The Robot Report, "Meet CyberDog, Xiaomi's open-source quadruped robot", 2021-08-10, [https://www.therobotreport.com/meet-cyberdog-a-new-open-source-quadruped-robot-from-xiaomi/](https://www.therobotreport.com/meet-cyberdog-a-new-open-source-quadruped-robot-from-xiaomi/)
*   한국경제, "협동로봇 연간 판매량 1000대 돌파한 두산로보틱스…국내 최초 글로벌 톱5 진입", 2021-12-22, [https://www.hankyung.com/economy/article/202112226954i](https://www.hankyung.com/economy/article/202112226954i)
*   IFR, "IFR presents World Robotics 2021 reports — Robot sales rise again", 2021-10-28, [https://ifr.org/ifr-press-releases/news/robot-sales-rise-again](https://ifr.org/ifr-press-releases/news/robot-sales-rise-again)
*   CNN Business, 2022-09-30 — [Tesla robot slowly walks on stage at AI Day](https://www.cnn.com/2022/09/30/business/tesla-bot-robot/index.html)
*   Electrek, 2022-09-30 — [Tesla unveils its humanoid robot for 'less than $20,000'](https://electrek.co/2022/09/30/tesla-optimus-humanoid-robot/)
*   Electrek, 2022-10-01 — [Tesla unveils new Dojo supercomputer so powerful it tripped the power grid](https://electrek.co/2022/10/01/tesla-dojo-supercomputer-tripped-power-grid/)
*   Designboom, 2022-08-15 — [Xiaomi's humanoid robot 'CyberOne' can detect 45 human emotions](https://www.designboom.com/technology/xiaomi-humanoid-robot-cyberone-artificial-intelligence-08-15-2022/)
*   Engadget, 2022-06-21 — [Proteus is Amazon's first fully autonomous warehouse robot](https://www.engadget.com/proteus-amazon-first-fully-autonomous-warehouse-robot-074341277.html)
*   CNBC, 2022-11-02 — [Goldman says humanoid robots will be a $6 billion market in 10 years](https://www.cnbc.com/2022/11/02/goldman-predicts-humanoid-robots-will-be-a-6-billion-market-in-10-years.html)
*   Google Research Blog, 2023-03-10 — PaLM-E 체화형 멀티모달 모델 / RT-2 맥락: [https://blog.google/innovation-and-ai/products/google-deepmind-rt2-robotics-vla-model/](https://blog.google/innovation-and-ai/products/google-deepmind-rt2-robotics-vla-model/)
*   Google DeepMind Blog, 2023-07-28 — RT-2 비전-언어-행동 모델 발표: [https://deepmind.google/blog/rt-2-new-model-translates-vision-and-language-into-action/](https://deepmind.google/blog/rt-2-new-model-translates-vision-and-language-into-action/)
*   TechCrunch, 2023-05-24 — Figure AI 7,000만 달러 시리즈A: [https://techcrunch.com/2023/05/24/2546360/](https://techcrunch.com/2023/05/24/2546360/)
*   Sanctuary AI 블로그, 2023-05-16 — Phoenix·Carbon 공개: [https://www.sanctuary.ai/blog/sanctuary-ai-unveils-phoenix-a-humanoid-general-purpose-robot-designed-for-work](https://www.sanctuary.ai/blog/sanctuary-ai-unveils-phoenix-a-humanoid-general-purpose-robot-designed-for-work)
*   The Robot Report, 2023-08-23 — Apptronik Apollo 공개·사양: [https://www.therobotreport.com/apptronik-unveils-apollo-humanoid-robot/](https://www.therobotreport.com/apptronik-unveils-apollo-humanoid-robot/)
*   TechCrunch, 2023-10-18 — 아마존 Digit 창고 시범 투입: [https://techcrunch.com/2023/10/18/amazon-begins-testing-agilitys-digit-robot-for-warehouse-work/](https://techcrunch.com/2023/10/18/amazon-begins-testing-agilitys-digit-robot-for-warehouse-work/)
*   레인보우로보틱스/삼성전자 뉴스룸, 2023-03 — 삼성전자 레인보우로보틱스 투자·최대주주 지위: [https://www.rainbow-robotics.com/pr/241231-1](https://www.rainbow-robotics.com/pr/241231-1)
*   인베스트조선, 2023-10-05 — 두산로보틱스 상장 첫날 시초가·종가: [https://www.investchosun.com/site/data/html_dir/2023/10/05/2023100580190.html](https://www.investchosun.com/site/data/html_dir/2023/10/05/2023100580190.html)
*   Gizguide, 2023-12-12 — 테슬라 옵티머스 Gen 2 사양: [https://www.gizguide.com/2023/12/tesla-optimus-gen-2-demo-video-released.html](https://www.gizguide.com/2023/12/tesla-optimus-gen-2-demo-video-released.html)
*   PR Newswire, 2024-02-29 — Figure Raises $675M at $2.6B Valuation and Signs Collaboration Agreement with OpenAI: [https://www.prnewswire.com/news-releases/figure-raises-675m-at-2-6b-valuation-and-signs-collaboration-agreement-with-openai-302074897.html](https://www.prnewswire.com/news-releases/figure-raises-675m-at-2-6b-valuation-and-signs-collaboration-agreement-with-openai-302074897.html)
*   NVIDIA Newsroom, 2024-03-18 — NVIDIA Announces Project GR00T Foundation Model and Isaac Robotics Platform Update: [https://nvidianews.nvidia.com/news/foundation-model-isaac-robotics-platform](https://nvidianews.nvidia.com/news/foundation-model-isaac-robotics-platform)
*   TechCrunch, 2024-04-17 — Boston Dynamics' Atlas humanoid robot goes electric: [https://techcrunch.com/2024/04/17/boston-dynamics-atlas-humanoid-robot-goes-electric/](https://techcrunch.com/2024/04/17/boston-dynamics-atlas-humanoid-robot-goes-electric/)
*   The Robot Report, 2024-05 — Unitree Robotics unveils G1 humanoid for $16K: [https://www.therobotreport.com/unitree-robotics-unveils-g1-humanoid-for-16k/](https://www.therobotreport.com/unitree-robotics-unveils-g1-humanoid-for-16k/)
*   GlobeNewswire (GXO·Agility Robotics), 2024-06-27 — GXO Signs Industry-First Multi-Year Agreement with Agility Robotics: [https://www.globenewswire.com/news-release/2024/06/27/2905556/0/en/GXO-Signs-Industry-First-Multi-Year-Agreement-with-Agility-Robotics.html](https://www.globenewswire.com/news-release/2024/06/27/2905556/0/en/GXO-Signs-Industry-First-Multi-Year-Agreement-with-Agility-Robotics.html)
*   BMW Group PressClub, 2024-08 — Successful test of humanoid robots at BMW Group Plant Spartanburg: [https://www.press.bmwgroup.com/usa/article/detail/T0444268EN_US/successful-test-of-humanoid-robots-at-bmw-group-plant-spartanburg?language=en_US](https://www.press.bmwgroup.com/usa/article/detail/T0444268EN_US/successful-test-of-humanoid-robots-at-bmw-group-plant-spartanburg?language=en_US)
*   Bloomberg, 2024-10-14 — Tesla's Optimus Robots Were Remotely Operated at Cybercab Event: [https://www.bloomberg.com/news/articles/2024-10-14/tesla-s-optimus-robots-were-remotely-operated-at-cybercab-event](https://www.bloomberg.com/news/articles/2024-10-14/tesla-s-optimus-robots-were-remotely-operated-at-cybercab-event)
*   Electrek, 2024-11-29 — Tesla unveils upgraded Optimus robot hand, but impressive demo is again teleoperated: [https://electrek.co/2024/11/29/tesla-unveils-upgraded-optimus-robot-hand-but-impressive-demo-is-again-teleoperated/](https://electrek.co/2024/11/29/tesla-unveils-upgraded-optimus-robot-hand-but-impressive-demo-is-again-teleoperated/)
*   NVIDIA Newsroom — Isaac GR00T N1 공개 (2025-03-18, [https://nvidianews.nvidia.com/news/nvidia-isaac-gr00t-n1-open-humanoid-robot-foundation-model-simulation-frameworks](https://nvidianews.nvidia.com/news/nvidia-isaac-gr00t-n1-open-humanoid-robot-foundation-model-simulation-frameworks))
*   The Robot Report — Figure 휴머노이드 Helix 시연 (2025-02-21, [https://www.therobotreport.com/figure-humanoid-robots-demonstrate-helix-model-household-chores/](https://www.therobotreport.com/figure-humanoid-robots-demonstrate-helix-model-household-chores/))
*   Figure 공식 보도자료 — 시리즈 C 10억 달러·390억 달러 가치 (2025-09-16, [https://www.figure.ai/news/series-c](https://www.figure.ai/news/series-c))
*   TrendForce — 옵티머스 양산 축소·손 설계 난제 (2025-10-10, [https://www.trendforce.com/news/2025/10/10/news-tesla-reportedly-scales-back-optimus-production-as-hand-design-issues-stall-assembly/](https://www.trendforce.com/news/2025/10/10/news-tesla-reportedly-scales-back-optimus-production-as-hand-design-issues-stall-assembly/))
*   Unitree 공식 — G1 사양·가격 ([https://www.unitree.com/g1/](https://www.unitree.com/g1/))
*   CNBC — 엔비디아·유니트리, G1 출하·유니콘 등극 (2026-06-01, [https://www.cnbc.com/2026/06/01/nvidia-unitree-humanoid-robotics-system-researchers.html](https://www.cnbc.com/2026/06/01/nvidia-unitree-humanoid-robotics-system-researchers.html))
*   Toyota Research Institute — 전기형 Atlas LBM 시연 (2025-08, [https://www.tri.global/news/ai-powered-robot-boston-dynamics-and-toyota-research-institute-takes-key-step-towards-general](https://www.tri.global/news/ai-powered-robot-boston-dynamics-and-toyota-research-institute-takes-key-step-towards-general))
*   전자신문 — 공정위, 삼성-레인보우로보틱스 인수 승인 (2025-03-05, [https://www.etnews.com/20250305000031](https://www.etnews.com/20250305000031))
*   삼성 뉴스룸 — 레인보우로보틱스 최대주주 확보 ([https://news.samsung.com/kr/삼성전자-레인보우로보틱스-최대주주-지위-확보](https://news.samsung.com/kr/삼성전자-레인보우로보틱스-최대주주-지위-확보))
*   Boston Dynamics — 현대차그룹 협력 확대 ([https://bostondynamics.com/news/boston-dynamics-hyundai-motor-group-expand-collaboration-drive-mobility-manufacturing-innovation/](https://bostondynamics.com/news/boston-dynamics-hyundai-motor-group-expand-collaboration-drive-mobility-manufacturing-innovation/))
*   로봇신문, 2026-01 — CES 2026 아틀라스 공개 ([https://www.irobotnews.com/news/articleView.html?idxno=44341](https://www.irobotnews.com/news/articleView.html?idxno=44341))
*   테크42, 2026-01 — 현대차 아틀라스 공개·2028년 공장 배치 ([https://www.tech42.co.kr/현대차-보스턴다이내믹스-아틀라스-공개-2028년-공장/](https://www.tech42.co.kr/현대차-보스턴다이내믹스-아틀라스-공개-2028년-공장/))
*   딜사이트, 2026-01 — 현대모비스 아틀라스 액추에이터 공급·35만 개 ([https://dealsite.co.kr/articles/154500](https://dealsite.co.kr/articles/154500))
*   글로벌이코노믹, 2026-01-20 — 현대모비스 아틀라스 핵심부품 독점 공급 ([https://www.g-enews.com/article/Global-Biz/2026/01/202601200951295091fbbec65dfb_1](https://www.g-enews.com/article/Global-Biz/2026/01/202601200951295091fbbec65dfb_1))
*   글로벌이코노믹, 2026-04-21 — 머스크 옵티머스 손 설계 실패 인정 ([https://www.g-enews.com/article/Global-Biz/2026/04/2026042120083072892bd56fbc3c_1](https://www.g-enews.com/article/Global-Biz/2026/04/2026042120083072892bd56fbc3c_1))
*   ZDNet Korea, 2026-04-23 — 옵티머스 7~8월 생산, 프리몬트 라인 전환 ([https://zdnet.co.kr/view/?no=20260423133812](https://zdnet.co.kr/view/?no=20260423133812))
*   로봇신문, 2026-05 — Figure AI 시간당 1대 양산, BotQ ([https://www.irobotnews.com/news/articleView.html?idxno=46175](https://www.irobotnews.com/news/articleView.html?idxno=46175))
*   NVIDIA Newsroom, 2026 — Isaac GR00T 개방형 휴머노이드 레퍼런스 ([https://nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design](https://nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design))
*   KMJ, 2026-05-15 — 유니트리 G1 이마트 3,100만 원 판매 ([https://www.kmjournal.net/news/articleView.html?idxno=8001](https://www.kmjournal.net/news/articleView.html?idxno=8001))
*   로봇신문, 2026 — 유니트리 로봇 UniPwn 보안 취약점 ([https://www.irobotnews.com/news/articleView.html?idxno=42667](https://www.irobotnews.com/news/articleView.html?idxno=42667))
*   한국기계연구원 — 2026 휴머노이드 상업적 임계점·골든타임 ([https://www.kimm.re.kr/sub0504/view/id/21054](https://www.kimm.re.kr/sub0504/view/id/21054))
*   글로벌이코노믹, 2026-05-13 — BofA 2030년 출하 120만 대 전망 ([https://www.g-enews.com/article/Global-Biz/2026/05/2026051321562438172bd56fbc3c_1](https://www.g-enews.com/article/Global-Biz/2026/05/2026051321562438172bd56fbc3c_1))
*   Fortune Business Insights — 휴머노이드 시장 전망 ([https://www.fortunebusinessinsights.com/humanoid-robots-market-110188](https://www.fortunebusinessinsights.com/humanoid-robots-market-110188))
*   MarketsandMarkets — 휴머노이드 시장 전망 ([https://www.marketsandmarkets.com/Market-Reports/humanoid-robot-market-99567653.html](https://www.marketsandmarkets.com/Market-Reports/humanoid-robot-market-99567653.html))
*   Investing.com — 2026 휴머노이드 전망(모건스탠리 등) ([https://kr.investing.com/news/stock-market-news/article-1767394](https://kr.investing.com/news/stock-market-news/article-1767394))
*   Wikipedia — Figure AI ([https://en.wikipedia.org/wiki/Figure_AI](https://en.wikipedia.org/wiki/Figure_AI))
