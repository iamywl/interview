# 피지컬 AI · 임베디드 AI · 온디바이스 — SSAFY PT면접 학습문서

## A. 왜 이 주제가 중요한가
AI가 클라우드를 넘어 사용자의 손안과 물리 세계로 확장되며 일상에 깊숙이 스며들고 있습니다. 온디바이스 AI는 네트워크 지연과 프라이버시 문제를 해결하며 즉각적인 AI 경험을 제공하고, 피지컬 AI는 로봇, 자율주행을 통해 현실의 문제를 직접 해결합니다. 이는 AI의 지능이 디지털을 넘어 물리적 '행동'으로 발현되는 새로운 시대를 열었기 때문입니다.

## B. 반드시 아는 핵심 개념 사전

### NPU (Neural Processing Unit, 신경망 처리장치)
*   **(1) 한 줄 정의**: AI 신경망의 핵심 연산인 행렬 곱셈을 초고속, 초저전력으로 처리하도록 설계된 AI 전용 반도체(AI 가속기)입니다.
*   **(2) 왜 나왔나**: CPU는 범용적인 작업에, GPU는 그래픽 처리에 최적화되어 있어 AI의 대규모 병렬 연산을 처리하기엔 비효율적이거나 전력 소모가 컸습니다. 스마트폰처럼 배터리가 제한된 기기에서 실시간 AI 기능을 항상 켜두려면, 적은 전력으로 AI 연산만 전문적으로 처리할 하드웨어가 필요했습니다.
*   **(3) 어떻게 동작하나**: 수천 개의 곱셈-누산기(MAC)를 반도체 회로에 직접 구현하여, 거대한 행렬 연산을 한 번의 클록 사이클에 병렬로 처리합니다. 또한 외부 메모리 접근을 최소화하고 8비트 정수(INT8) 같은 저정밀도 데이터 연산에 회로를 최적화하여 전력 소모를 극적으로 줄입니다.
*   **(4) 무엇이 달라지나**: NPU 덕분에 인터넷 연결 없이도 스마트폰이 실시간으로 통역하고, 사진 속 인물과 배경을 분리하며, 음성 비서를 즉각 호출할 수 있게 되었습니다. 다만, 특정 연산에만 최적화되어 있어 범용성은 떨어집니다.

### TinyML (마이크로컨트롤러 머신러닝)
*   **(1) 한 줄 정의**: 수백 KB의 메모리와 배터리 하나로 수년을 버텨야 하는 초소형, 초저전력 마이크로컨트롤러(MCU)에서 AI 모델을 구동하는 기술 분야입니다.
*   **(2) 왜 나왔나**: 모든 센서 데이터를 클라우드로 보내는 것은 통신 비용, 전력 소모, 네트워크 지연, 프라이버시 침해 문제를 야기합니다. "헤이 구글" 같은 간단한 명령어를 인식하거나 공장 설비의 미세한 진동을 감지하는 일은, 기기 자체에서 즉각 처리하는 것이 훨씬 효율적이기 때문입니다.
*   **(3) 어떻게 동작하나**: 서버에서 학습된 수백 MB 크기의 AI 모델을 '양자화'나 '가지치기' 같은 기술로 100KB 안팎까지 극단적으로 압축합니다. 이 초경량 모델을 TensorFlow Lite 같은 전용 실행 도구를 이용해 MCU에 탑재하여, '항상 켜져 있으면서' 특정 패턴을 감지하는 역할을 수행합니다.
*   **(4) 무엇이 달라지나**: 가전제품, 웨어러블, 산업용 센서 등 수십억 개의 사물에 지능을 부여하여 진정한 의미의 '스마트' 기기를 만들 수 있습니다. 하지만 모델이 극도로 경량화되어 복잡한 추론은 불가능하며, 모델의 보안과 신뢰성 확보가 새로운 과제로 떠오릅니다.

### 연합학습 (Federated Learning)
*   **(1) 한 줄 정의**: 사용자의 원본 데이터를 서버로 보내지 않고, 각자의 기기 위에서 AI 모델을 개별적으로 학습시킨 뒤, 그 학습 결과(모델 가중치 업데이트 값)만을 암호화하여 공유하고 종합하는 분산 학습 방식입니다.
*   **(2) 왜 나왔나**: 기존 AI는 모든 데이터를 중앙 서버로 모아야 해서 개인정보 유출 위험이 컸고, GDPR 같은 데이터 보호 규제도 강화되었습니다. 데이터를 중앙화하지 않으면서도 AI 모델을 개선하고 사용자 경험을 개인화할 방법이 필요했습니다.
*   **(3) 어떻게 동작하나**: 서버가 기본 모델을 각 기기로 보내면, 각 기기는 자신의 데이터(예: 타자 습관, 사진첩)를 이용해 이 모델을 학습시킵니다. 이후 학습으로 변경된 '업데이트' 정보만 서버로 보내고, 서버는 수많은 기기로부터 온 업데이트를 평균 내어 기본 모델을 개선합니다. 원본 데이터는 절대 기기 밖으로 나가지 않습니다.
*   **(4) 무엇이 달라지나**: 개인정보를 강력하게 보호하면서도 '나만의 AI'를 만들 수 있게 됩니다. 스마트폰 키보드가 나의 말투를 학습하고, 얼굴인식 모델이 내 얼굴에 더 정확하게 반응하는 것이 그 예입니다. 다만, 악의적인 사용자가 조작된 학습 결과를 보내 전체 모델을 망가뜨리는 '포이즈닝 공격'에 대한 방어 기술이 함께 요구됩니다.

### INT4 양자화 (INT4 Quantization)
*   **(1) 한 줄 정의:** AI 모델의 가중치를 기존 32비트 부동소수점(FP32) 대신 4비트 정수(INT4)로 압축해, 메모리 사용량과 연산량을 획기적으로 줄이는 기술입니다.
*   **(2) 왜 나왔나:** 스마트폰이나 소형 IoT 기기처럼 배터리, 메모리, 발열 등 자원이 극히 제한된 환경에서는 크고 무거운 AI 모델을 그대로 실행할 수 없습니다. 모델을 가볍게 만들어 기기 안에서 빠르고 효율적으로 AI를 실행하기 위해 양자화는 필수적입니다.
*   **(3) 어떻게 동작하나:** 학습이 완료된 모델의 가중치 값들이 갖는 범위를 분석해, 2의 4제곱, 즉 16단계의 정수로 값을 압축하여 표현합니다. 이 과정에서 발생하는 정확도 손실은, 양자화 오류를 학습 과정에 미리 반영해 훈련하는 '양자화 인식 학습(QAT)'이나, 정확도에 민감한 일부 계층만 높은 정밀도로 남기는 '혼합 정밀도' 기법으로 보완합니다.
*   **(4) 무엇이 달라지나:** 모델 크기가 1/8로 줄어들어(FP32 대비) 동일한 하드웨어에서 더 크고 복잡한 모델을 실행할 수 있게 됩니다. 또한 메모리 접근이 줄고 연산이 단순해져 전력 소모가 감소하므로, 배터리를 사용하는 모바일 기기에서 더 오래, 더 빠르게 AI 기능을 사용할 수 있습니다. 다만, 정밀도가 낮아져 발생하는 정확도 하락을 최소화하는 것이 기술적 과제입니다.

### 온디바이스 생성형 AI (On-Device Generative AI)
*   **(1) 한 줄 정의**: 인터넷 연결 없이 스마트폰, 노트북 등 사용자 기기 내부에서 직접 텍스트, 이미지 등을 생성하는 AI 기술입니다.
*   **(2) 왜 나왔나?**: 기존 클라우드 AI는 요청마다 서버와 통신해야 해서 응답이 느리고(지연), 인터넷이 안 되면 무용지물이었습니다. 무엇보다 제 개인정보나 사진 같은 민감한 데이터가 외부 서버로 나간다는 점이 찜찜했습니다. 이런 속도, 연결성, 프라이버시 문제를 해결하기 위해 등장했습니다.
*   **(3) 어떻게 동작하나?**: 두 가지 핵심 기술의 조합입니다. 첫째, 모바일 AP에 탑재된 NPU(신경망 처리 장치)라는 AI 전용 반도체가 AI 연산을 CPU나 GPU보다 훨씬 빠르고 효율적으로 처리합니다. 둘째, 수천억 개 파라미터를 가진 거대 모델을 양자화(quantization), 지식 증류(knowledge distillation) 등의 기법으로 압축해 만든 소형 언어모델(SLM)을 사용해 제한된 기기 자원에서도 구동할 수 있게 만듭니다.
*   **(4) 무엇이 달라지나?**: 이제 AI가 비행기 모드에서도 동작합니다. 제 스마트폰이 저의 말투나 자주 쓰는 단어를 학습해 저만을 위한 문장을 제안하고, 민감한 정보 유출 걱정 없이 사진을 편집할 수 있게 됩니다. 다만 아직은 기기 성능 한계로 클라우드만큼 복잡한 작업은 어려우며, 배터리 소모를 어떻게 최적화할지가 중요한 과제입니다.

### 피지컬 AI (Physical AI)
*   **(1) 한 줄 정의**: 디지털 세계의 AI가 로봇이나 자율주행차처럼 물리적 실체를 통해 현실 세계와 상호작용하며 작업을 수행하는 기술입니다.
*   **(2) 왜 나왔나**: 기존 AI는 데이터 분석이나 콘텐츠 생성에 머물러, 실제 세상의 문제를 직접 해결하는 데 한계가 있었습니다. 물류, 제조, 돌봄, 탐사 등 현실의 물리적인 작업을 수행하려면 AI가 직접 환경을 인식하고 판단하며 움직일 수 있어야 했기 때문입니다. 기존 산업용 로봇은 정해진 규칙만 반복해, 예측 불가능한 환경에서는 무용지물이었습니다.
*   **(3) 어떻게 동작하나**: 카메라, 라이다 등 센서로 세상을 보고(Vision), 자연어 명령을 이해하며(Language), 어떻게 움직일지 행동 계획을 세워(Action) 실행합니다. AI 모델은 사람의 시범 동작을 보고 배우거나(모방 학습), 가상 환경에서 수없이 연습하며(강화 학습) 최적의 행동 방식을 터득한 뒤, 로봇 관절에 구체적인 움직임 명령을 내립니다.
*   **(4) 무엇이 달라지나**: AI의 역할이 분석가나 보조 작가에서, 실제 작업을 수행하는 노동자나 파트너로 확장됩니다. 제조업, 물류, 돌봄 서비스 등에서 인간과 로봇의 협업 수준을 한 차원 높여 진정한 자동화를 구현할 수 있습니다. 다만 오작동 시 물리적, 경제적 피해가 발생할 수 있어 안전과 신뢰성 확보가 무엇보다 중요한 과제가 됩니다.

### 하이브리드 AI (Hybrid AI)
*   **(1) 한 줄 정의:** 개인정보 보호와 즉각적 반응이 중요한 작업은 기기 자체에서(On-device), 방대한 연산이 필요할 때는 클라우드에서(Cloud) 처리하는 혼합형 AI 구조입니다.
*   **(2) 왜 나왔나:** 모든 것을 기기에서 처리하는 '온디바이스 AI'는 빠르고 안전하지만 성능 한계가 명확합니다. 반대로 모든 것을 '클라우드 AI'로 처리하면 강력하지만, 인터넷 연결이 필수고 개인정보 유출 위험과 비용 문제가 있습니다. 하이브리드 방식은 이 둘의 장점만 취한 현실적인 대안입니다.
*   **(3) 어떻게 동작하나:** 사용자의 요청이 발생하면, 운영체제(OS)나 AI 모델 자체가 '라우터(Router)' 역할을 합니다. 간단한 텍스트 요약이나 맞춤법 교정은 기기 내 경량 모델이, 복잡한 이미지 생성이나 장문 보고서 작성 요청은 핵심 데이터만 암호화하여 클라우드의 거대 모델로 보내 처리한 뒤 결과만 돌려받습니다. 애플의 '프라이빗 클라우드 컴퓨트(PCC)'가 대표적인 예입니다.
*   **(4) 무엇이 달라지나:** 사용자는 AI가 온디바이스에서 작동하는지 클라우드에서 작동하는지 신경 쓸 필요 없이, 항상 빠르고 안전하며 강력한 AI 서비스를 경험하게 됩니다. 개발자는 기기 제약과 클라우드 비용 사이에서 최적의 솔루션을 설계해야 하는 새로운 과제를 안게 됩니다.

### VLA(Vision-Language-Action) 모델
*   **(1) 한 줄 정의**: 카메라로 본 장면(Vision)과 사람이 말로 준 명령(Language)을 이해해서, 로봇의 실제 움직임(Action)을 만들어내는 통합 인공지능 모델입니다.
*   **(2) 왜 나왔나**: 기존 로봇은 '인식', '해석', '계획', '제어'를 각각 다른 부품처럼 만들어서 사람이 규칙으로 일일이 연결했습니다. 그래서 정해진 규칙에 없는 물건이나 상황을 만나면 쉽게 고장 나고, 작업마다 새로 프로그래밍해야 해서 범용성이 떨어졌습니다.
*   **(3) 어떻게 동작하나**: 인터넷의 방대한 정보로 미리 학습한 '비전-언어 모델'이 장면과 명령을 종합적으로 이해해 "무엇을, 어떻게 할지" 큰 그림을 그립니다. 그러면 가볍고 빠른 '정책 모델'이 이 계획을 받아, 아주 짧은 순간마다 로봇 관절을 얼마나 꺾고 얼마나 빨리 움직일지 구체적인 수치로 바꿔줍니다. 큰 판단은 신중하게, 실제 움직임은 재빠르게 역할을 나눈 셈입니다.
*   **(4) 무엇이 달라지나**: 로봇이 특정 작업을 반복하는 것을 넘어, 사람의 말을 이해하고 행동을 모방하며 비정형 환경에 적응하는 시대의 서막을 엽니다. 자율주행의 경우, 카메라 영상(Vision) 입력부터 차량 제어(Action)까지 하나의 AI가 담당하면서, 왜 그런 판단을 했는지 사람의 언어(Language)로 설명하는 단계로 발전합니다.

### 월드 파운데이션 모델 (World Foundation Model)
*   **(1) 한 줄 정의**: 현실 세계의 물리 법칙, 즉 '세상은 어떻게 돌아가는가'를 학습한 AI 모델입니다. 이걸 바탕으로, 특정 상황을 주면 앞으로 어떤 일이 일어날지 현실 같은 영상이나 센서 데이터로 미리 시뮬레이션해서 보여줍니다.
*   **(2) 왜 나왔나**: 로봇이나 자율주행차를 학습시키려면 어마어마하게 많은 데이터가 필요합니다. 특히 자동차 사고처럼 드물지만 중요한 상황의 데이터는 현실에서 모으기가 거의 불가능하고 위험하죠. 이런 데이터 부족 문제를 해결하기 위해, 가상 세계에서 필요한 데이터를 무한정 만들어내는 기술이 필요해졌습니다.
*   **(3) 어떻게 동작하나**: 엔비디아의 '코스모스(Cosmos)'를 예로 들면, 실제 세상의 수많은 동영상으로 물체의 움직임, 충돌, 그림자 같은 물리 규칙을 배웁니다. 그 다음, "자동차가 시속 100km로 달리다 비를 만난다" 같은 조건을 주면, 그 상황을 현실적인 영상과 가상의 센서 데이터로 만들어 AI 학습에 사용합니다.
*   **(4) 무엇이 달라지나**: 현실에서 수집하기 어려운 위험하거나 희귀한 상황의 데이터를 가상으로 대량 생성하여, 피지컬 AI의 학습 방식 자체를 바꾸고 있습니다. 이는 로봇, 자율주행 등 피지컬 AI 개발의 데이터 병목을 해소하는 핵심 인프라로 부상합니다.

### 온디바이스 멀티 에이전트 AI (On-Device Multi-Agent AI)
*   **(1) 한 줄 정의**: 하나의 기기 안에서 여러 AI 비서(에이전트)가 각자 잘하는 역할을 나눠 협력하며, 특히 개인정보처럼 민감한 작업은 외부 서버 없이 기기 자체에서(On-Device) 처리하는 구조입니다.
*   **(2) 왜 나왔나?**: 모든 작업을 강력한 클라우드 AI에 의존하면 인터넷 연결이 끊겼을 때 무용지물이 되고 반응 속도가 느려집니다. 또한 개인의 일정이나 메시지 내용을 모두 서버로 보내는 것은 프라이버시 침해 우려가 큽니다. 그렇다고 기기 안의 AI만 쓰기엔 복잡한 작업을 처리하는 데 성능 한계가 있었습니다.
*   **(3) 어떻게 동작하나?**: 사용자가 명령을 내리면, 기기 내의 ‘교통정리’ AI(예: 갤럭시의 빅스비)가 작업의 성격을 판단합니다. 복잡한 추론이나 최신 정보 검색은 클라우드 AI(예: 구글 제미나이)에 요청하고, 개인정보 분석이나 앱 제어처럼 민감하거나 빠른 반응이 필요한 작업은 기기 내 NPU 칩 위에서 동작하는 온디바이스 AI가 처리합니다.
*   **(4) 무엇이 달라지나?**: 사용자는 인터넷 연결이나 개인정보 유출 걱정 없이 더 빠르고 안전하게 AI 비서를 활용할 수 있게 됩니다. 기기 자체의 컴퓨팅 성능이 중요해지면서 NPU와 같은 AI 반도체의 역할이 더욱 커지고, 기기 내에서 AI 모델을 효율적으로 실행하고 보안을 유지하는 기술이 핵심 경쟁력이 됩니다.

## C. 연도별 흐름 한눈에
*   **2021**: NPU 발전과 빅테크의 칩 수직통합으로 온디바이스 AI와 TinyML이 태동하며 AI가 기기로 들어오기 시작했습니다. ([2021](@claude/research/physical_ai/2021.md))
*   **2022**: INT4 양자화와 엔비디아 Jetson Orin 시리즈의 등장으로 엣지 AI 슈퍼컴퓨터 시대가 열리며 와트당 성능이 중요해졌고, 연말 ChatGPT는 온디바이스 AI에 새로운 질문을 던졌습니다. ([2022](@claude/research/physical_ai/2022.md))
*   **2023**: 퀄컴의 온디바이스 Stable Diffusion 시연과 구글 Gemini Nano의 상용화로 온디바이스 생성형 AI의 막이 올랐고, 소형 언어모델(SLM)의 가능성이 입증되며 하이브리드 AI 전략이 공식화되었습니다. ([2023](@claude/research/physical_ai/2023.md))
*   **2024**: 엔비디아의 휴머노이드 로봇 플랫폼 발표로 피지컬 AI가 부상하고, 삼성 갤럭시 S24와 애플 인텔리전스로 온디바이스 AI가 대중화되며 AI PC 카테고리가 탄생했습니다. ([2024](@claude/research/physical_ai/2024.md))
*   **2025**: 피지컬 AI가 산업 표준 용어화되고 VLA 모델이 사실상 표준 아키텍처로 자리 잡았으며, 월드 모델로 합성 데이터 생성이 실용화되고 온디바이스 AI 에이전트화가 가속화되었습니다. ([2025](@claude/research/physical_ai/2025.md))
*   **2026**: 엔비디아 Rubin 플랫폼과 Alpamayo R1의 추론형 자율주행, 삼성 갤럭시 S26의 온디바이스 멀티 에이전트 AI가 등장하며 피지컬 AI와 하이브리드 AI 시대가 본격화되었습니다. ([2026](@claude/research/physical_ai/2026.md))

## D. PT 발표 주제 추천

### 주제 1: 온디바이스 AI의 진화와 하이브리드 AI 전략: 클라우드와 엣지의 최적의 역할 분담
*   **핵심 메시지**: 온디바이스 AI는 클라우드 AI의 한계를 보완하며 프라이버시, 속도, 비용 효율성을 제공합니다. 앞으로 클라우드와 온디바이스 AI는 상호 보완적인 하이브리드 형태로 발전할 것입니다.
*   **발표 3단 구조**:
    *   **문제**: 클라우드 AI는 강력하지만 네트워크 지연, 프라이버시 문제, 지속적인 통신 비용이라는 한계를 가집니다.
    *   **근거**: 2021년 NPU의 등장부터 2023년 온디바이스 생성형 AI의 상용화, 그리고 2024년 애플의 PCC 전략까지 온디바이스 AI는 이 문제를 해결하며 성장해왔습니다.
    *   **제언**: 모든 AI 워크로드를 한곳에 집중하는 대신, 민감 데이터 처리 및 저지연이 필요한 작업은 온디바이스에서, 방대한 학습 및 복잡한 연산은 클라우드에서 분담하는 하이브리드 AI 아키텍처 구축이 필수적입니다.

### 주제 2: 피지컬 AI 시대, '지능'을 넘어 '행동'을 설계하는 개발자의 역할과 보안 과제
*   **핵심 메시지**: 피지컬 AI는 AI의 지능을 물리적 행동으로 확장하며 새로운 기회를 창출하지만, 이는 시스템 수준의 보안과 안정성 확보라는 중대한 과제를 동반합니다.
*   **발표 3단 구조**:
    *   **문제**: 로봇, 자율주행차 등 피지컬 AI의 오작동은 물리적 사고로 직결되며, 기존 디지털 보안 모델로는 예측 불가능한 현실 세계의 위협에 충분히 대응하기 어렵습니다.
    *   **근거**: 2024년 엔비디아의 휴머노이드 로봇 플랫폼 발표와 2026년 Alpamayo R1의 추론형 자율주행 모델 등은 피지컬 AI의 잠재력을 보여주지만, 동시에 물리적 상호작용이 가져올 새로운 보안 위협에 대한 대비가 시급합니다.
    *   **제언**: AI 모델의 정확성뿐만 아니라, 로봇 운영체제(Linux)의 커널 수준에서 AI 프로세스의 시스템 콜을 동적으로 관측하고 제어하여 이상 행위를 탐지하며, 물리적 안전장치를 설계하는 융합형 개발자의 역량과 시스템적 접근이 필수적입니다.

### 주제 3: 월드 모델이 만드는 데이터: 시뮬레이션 기반 학습이 피지컬 AI 병목 현상을 푸는 방법
*   **핵심 메시지**: 엔비디아 Cosmos와 같은 월드 모델은 현실 세계의 물리 법칙을 학습하여 고품질의 합성 데이터를 대량 생성함으로써, 피지컬 AI 개발의 데이터 수집 병목을 해결하고 학습 패러다임을 전환하고 있습니다.
*   **발표 3단 구조**:
    *   **문제**: 로봇이나 자율주행차를 학습시키기 위한 현실 세계 데이터 수집은 막대한 비용, 시간, 위험이 따르며, 특히 사고와 같은 희귀 상황 데이터는 확보하기 매우 어렵습니다.
    *   **근거**: 2025년 엔비디아의 Cosmos 월드 파운데이션 모델 공개는 가상 시뮬레이션을 통해 실제와 유사한 데이터를 무한정 생성할 수 있는 가능성을 열었습니다. 이는 2026년 Alpamayo R1 자율주행 시스템 개발에도 활용되었습니다.
    *   **제언**: 합성 데이터 학습은 'sim-to-real gap'이라는 현실과의 격차 문제를 내포하므로, 생성된 데이터의 품질 검증 및 소량의 실제 데이터 미세조정을 통한 모델 편향 보정, 그리고 배포 전 철저한 실제 환경 테스트를 포함하는 체계적인 데이터 거버넌스 수립이 필요합니다.

### 주제 4: 온디바이스 멀티 에이전트 AI와 새로운 단말 보안의 지정학
*   **핵심 메시지**: 스마트폰 내 AI 에이전트가 개인의 모든 작업을 자율적으로 처리하게 되면서, 기기 자체가 전례 없는 가치를 지닌 공격 표적이 되었고 시스템 수준의 런타임 보안이 핵심 과제로 부상했습니다.
*   **발표 3단 구조**:
    *   **문제**: 온디바이스 멀티 에이전트 AI는 개인화된 편리함을 제공하지만, 스마트폰이 해킹당할 경우 개인의 디지털 자산과 프라이버시 전체가 통째로 유출될 수 있는 치명적인 위협에 노출됩니다.
    *   **근거**: 2025년 갤럭시 S25의 Personal Data Engine과 2026년 갤럭시 S26의 멀티 에이전트 통합은 온디바이스 AI의 지능화와 함께, 기존 클라우드 보안 모델로는 방어하기 어려운 새로운 단말 보안의 중요성을 부각시킵니다.
    *   **제언**: 컨테이너 보안에서 시스템 콜을 감시해 이상행위를 탐지하듯, 온디바이스 AI 런타임에 대한 '동적 행위 분석'을 도입해야 합니다. AI 모델의 정상적인 시스템 콜, 메모리 접근 패턴을 프로파일링하고, 이를 벗어나는 의심스러운 동작을 실시간으로 탐지 및 차단하는 시스템 수준의 방어 체계를 구축해야 합니다.

## E. 모범답안집

**1. 온디바이스 AI가 클라우드 AI에 비해 보안, 프라이버시 측면에서 유리한 이유와, 그럼에도 불구하고 발생하는 새로운 보안 위협은 무엇인가요?**
네, 온디바이스 AI의 가장 큰 보안 장점은 데이터가 기기 밖으로 나가지 않아, 전송 과정에서의 해킹이나 서버 데이터 유출 가능성을 원천적으로 차단한다는 점입니다. 하지만 이는 기기 자체가 새로운 공격 목표가 된다는 뜻이기도 합니다. 공격자가 악성코드를 통해 AI 모델을 훔치거나 변조된 입력값으로 오작동을 유도하는 '적대적 공격'이 새로운 위협으로 떠오릅니다. 제가 컨테이너 환경에서 시스템 콜을 관측해 이상 행위를 탐지했던 경험처럼, 온디바이스 환경에서도 AI 모델의 정상적인 작동 패턴에서 벗어나는 행위를 탐지하는 경량화된 보안 메커니즘이 반드시 필요하다고 생각합니다.

**2. Jetson Orin 같은 고성능 엣지 디바이스를 공장 내 로봇에 대량 배포한다고 가정할 때, 가장 먼저 고려해야 할 보안 위협은 무엇이고, 본인의 경험을 바탕으로 어떻게 대응하시겠습니까?**
물리적 탈취나 접근이 가장 크고 직접적인 보안 위협이라고 생각합니다. 클라우드 서버와 달리 현장에 노출된 엣지 디바이스는 USB 포트 등을 통한 직접 공격에 매우 취약하기 때문입니다. 저는 컨테이너 환경에서 시스템 콜을 관측해 이상 행위를 탐지하며 보안을 강화해 본 경험이 있습니다. 이 경험을 살려, 먼저 보안 부팅과 신뢰 실행 환경(TEE)으로 허가되지 않은 소프트웨어 실행을 원천 차단하겠습니다. 그리고 제가 다뤘던 리눅스 커널의 AppArmor나 SELinux 같은 접근 제어 기능으로 각 프로세스의 권한을 최소화하여 공격 표면을 줄이겠습니다. 마지막으로, 정상 상태의 시스템 콜 패턴을 학습시켜 이를 벗어나는 비정상 행위가 관측되면 즉시 경고하고 네트워크를 차단하는 동적 이상탐지 시스템을 구축하여 다층 방어 체계를 만들고 싶습니다.

**3. 본인이 가진 리눅스 커널과 시스템 콜에 대한 이해가, Jetson Orin 같은 임베디드 리눅스 환경에서 AI 모델의 성능을 최적화하는 데 어떻게 기여할 수 있을까요?**
네, AI 모델 성능은 알고리즘뿐만 아니라 그 모델이 실행되는 시스템 환경에 크게 좌우된다고 생각합니다. 리눅스 커널과 시스템 콜에 대한 이해는, AI 모델과 하드웨어 가속기 사이의 다리인 운영체제를 최적화하여 모델의 잠재력을 최대한 끌어내는 데 기여할 수 있습니다. 예를 들어, Jetson Orin에는 고성능 코어와 저전력 코어가 혼재하는데, 커널의 스케줄러 설정을 조정하여 AI 추론처럼 중요한 작업은 항상 고성능 코어에 할당되도록 보장할 수 있습니다. 또한, 시스템 콜을 추적해 데이터가 센서 드라이버에서 NPU로 전달될 때 불필요한 메모리 복사가 발생하는지 분석하고, 이를 제거하여 지연 시간을 줄일 수 있습니다. 이처럼 시스템의 가장 낮은 수준까지 이해하고 제어하는 역량은 0.1초의 응답속도가 중요한 로봇 분야에서 큰 경쟁력이 될 것이라 확신합니다.

**4. 하이브리드 AI 환경에서 데이터 보안과 프라이버시를 어떻게 보장할 수 있을까요? 본인의 경험과 연결해서 설명해보세요.**
하이브리드 AI의 보안은 기기와 클라우드 사이의 '신뢰 경계'를 시스템적으로 설계하는 것이 핵심입니다. 제가 컨테이너 보안 프로젝트에서 시스템 콜을 동적으로 관측해 정보 유출을 막는 이상탐지 기법을 개발했던 경험을 적용해보고 싶습니다. 예를 들어, AI 애플리케이션이 클라우드로 데이터를 보내기 위해 호출하는 네트워크 관련 시스템 콜을 커널 레벨에서 실시간으로 감시하는 것입니다. 이를 통해 사전에 허가된 종류와 형식의 데이터만 전송되도록 강제하고, 만약 개인 식별 정보 같은 민감 데이터의 전송 시도가 탐지되면 즉시 차단하는 보안 계층을 구축하여 사용자의 프라이버시를 원천적으로 보호할 수 있습니다.

**5. MS의 Recall 기능이 프라이버시 논란을 겪은 이유는 무엇이며, 본인이 설계자라면 이 문제를 어떻게 해결했을지 시스템 관점에서 설명해주세요.**
Recall 기능의 문제는 단순히 '온디바이스' 처리라는 사실만으로 보안이 해결될 것이라 안일하게 생각한 점입니다. 데이터가 기기 안에만 있어도, 일반 사용자 권한을 탈취한 악성코드가 암호화되지 않은 스크린샷 DB에 쉽게 접근할 수 있는 구조적 허점이 있었습니다. 제가 설계자였다면, 컨테이너 격리 기술에서 아이디어를 얻어 Recall 데이터를 위한 '보안 엔클레이브'를 구축하겠습니다. 즉, 하드웨어 암호화 기술을 활용해 스크린샷 데이터베이스를 OS 커널조차 직접 접근할 수 없는 독립된 메모리 공간에 저장하고, 오직 서명된 Recall 프로세스만이 접근을 허용하도록 시스템 콜 레벨에서 엄격한 접근 제어 정책을 적용하여 이 문제를 해결하겠습니다.

**6. 로봇이나 자율주행차 같은 피지컬 AI 기기가 우리 생활에 들어오면서 가장 우려되는 보안 위협은 무엇이며, 본인의 경험을 바탕으로 어떤 해결책을 제시할 수 있나요?**
가장 큰 위협은 사이버 공격이 물리적 사고로 이어진다는 점입니다. 해커가 로봇 팔의 제어 시스템을 탈취해 사람을 다치게 하거나, 자율주행차를 급발진시키는 상황이 발생할 수 있습니다. 저는 컨테이너 환경의 구조적 보안 문제를 해결하기 위해 시스템 콜을 동적으로 관측해 이상 행위를 탐지하는 연구를 했습니다. 이 경험에 비춰볼 때, 로봇 운영체제(대부분 Linux 기반)의 시스템 콜을 실시간으로 감시하는 것이 효과적인 해결책이 될 수 있습니다. 로봇이 평소와 다른 프로세스를 실행하거나, 허가되지 않은 네트워크에 접속하려는 등 비정상적인 시스템 콜 패턴이 나타나면 즉시 관리자에게 알리고 동작을 안전 모드로 전환하는, 커널 수준의 '면역 시스템'을 구축하는 것입니다.

**7. 온디바이스 AI가 에이전트 수준으로 발전하면서 보안 위협도 커졌을 텐데, 본인의 컨테이너 보안 경험을 바탕으로 어떻게 대응할 수 있을지 구체적으로 설명해 보세요.**
네, 온디바이스 AI가 고도화되며 기기 자체가 해커의 핵심 공격 목표가 되었다고 생각합니다. 저는 이 문제를 컨테이너 보안과 동일한 관점에서, 즉 신뢰하되 검증하는(Trust, but Verify) 방식으로 접근해야 한다고 봅니다. 과거 컨테이너의 이상행위를 탐지하기 위해 시스템 콜을 동적으로 관측했던 경험을 온디바이스 AI 런타임에 적용할 수 있습니다. AI 모델이 실행되며 발생하는 시스템 콜, 메모리 접근, 네트워크 요청 같은 저수준 활동 패턴을 실시간으로 관찰하고, 정상 범위를 벗어나는 의심스러운 동작, 예를 들어 허가 없이 개인정보 파일에 접근하거나 비정상적인 서버와 통신을 시도하는 행위를 즉시 탐지하고 격리하는 것입니다. 이는 AI의 행동 경계를 시스템 수준에서 강제하는 가장 효과적이고 현실적인 방어 체계가 될 것입니다.

**8. 클라우드 AI의 성능이 훨씬 강력한데, 굳이 NPU 성능을 높여가며 온디바이스 AI를 발전시키는 근본적인 이유는 무엇이라고 생각하나요?**
온디바이스 AI는 클라우드 AI를 대체하는 것이 아니라, 서로의 약점을 보완하는 ‘역할 분담’의 관점에서 필수적이라고 생각합니다. 근본적인 이유는 세 가지입니다. 첫째는 ‘반응 속도’입니다. 자율주행차의 긴급 제동처럼 1밀리초의 지연도 치명적인 작업은 데이터를 서버까지 보낼 시간 없이 기기 자체에서 즉시 처리해야 합니다. 둘째는 ‘프라이버시’입니다. 제 건강 정보나 금융 정보 같은 민감한 데이터를 외부 서버로 보내지 않고 내 기기 안에서 안전하게 처리하고 싶어 하는 요구는 당연합니다. 마지막으로 ‘연결 독립성’과 ‘비용’입니다. 인터넷이 안 되는 환경에서도 AI를 사용하고, 데이터 통신 비용 없이 기능을 쓰고 싶은 요구도 분명히 존재합니다. 따라서 범용적인 고성능 추론은 클라우드가, 저지연·프라이버시·고효율이 중요한 작업은 온디바이스가 맡는 하이브리드 구조가 가장 합리적인 방향이라고 생각합니다.

**9. SSAFY의 파이썬 풀스택 과정이 오늘 발표한 피지컬 AI나 온디바이스 AI 트렌드와 어떻게 연결될 수 있다고 생각하나요?**
피지컬 AI와 온디바이스 AI는 결국 사용자와 상호작용하는 서비스로 구현되어야 그 가치가 완성된다고 생각합니다. SSAFY의 파이썬 풀스택 과정은 바로 이 지점에서 핵심적인 역할을 합니다. 예를 들어, 온디바이스 AI가 탑재된 스마트폰의 새로운 기능들을 사용자가 쉽게 제어하고 그 결과를 확인할 수 있는 웹 대시보드나 모바일 앱을 개발할 수 있습니다. 또한, 수많은 엣지 디바이스로부터 수집된 데이터를 처리하고, 분석하며, 다시 모델 학습에 활용하는 강력한 백엔드 시스템을 Django와 같은 프레임워크로 구축할 수 있습니다. 제가 가진 시스템 수준의 이해와 SSAFY에서 배울 웹 풀스택 개발 역량을 결합한다면, 하드웨어부터 사용자 인터페이스까지 전 과정을 이해하는 ‘융합형 개발자’로 성장하여 새로운 AI 서비스의 가치를 고객에게 온전히 전달할 수 있다고 확신합니다.

## F. 지원자 경험 연계 포인트
*   **시스템 콜 동적 관측을 통한 AI 모델 런타임 이상 행위 탐지**: 컨테이너 보안 프로젝트에서 학습한 시스템 콜 모니터링 기법을 온디바이스 AI 런타임 보안 강화에 적용.
*   **리눅스 커널 스케줄러 최적화를 통한 AI 가속기 성능 극대화**: Jetson Orin과 같은 임베디드 리눅스 환경에서 커널 지식을 활용하여 AI 연산 우선순위 및 자원 할당 최적화.
*   **컨테이너 격리 기술을 활용한 온디바이스 AI 데이터 보안 엔클레이브 설계**: MS Recall 사례처럼 기기 내 민감 데이터에 대한 접근 제어 및 암호화된 격리 공간 구현.
*   **시스템 수준 이해 기반의 피지컬 AI 물리적 안전장치 설계**: AI 오작동 시 물리적 피해를 방지하기 위해 커널 보안 모듈(LSM)에서 영감을 얻은 독립적 안전 감시 시스템 구축.
*   **하드웨어부터 서비스까지 아우르는 융합형 개발 역량**: 리눅스 커널 이해와 SSAFY 풀스택 과정을 결합하여 AI 서비스 전반의 성능 및 보안 최적화 기여.

## G. 빠른 암기 카드

| 카테고리 | 키워드/수치 | 설명 |
| :------- | :---------- | :--- |
| **핵심 개념** | NPU | AI 전용 반도체, 초고속/초저전력 행렬 연산 |
| | TinyML | 초소형 MCU에서 AI 구동, 수백 KB 메모리 |
| | 연합학습 | 데이터 서버 전송 없이 기기 내 학습 후 결과만 공유 |
| | INT4 양자화 | 4비트 정수로 모델 압축, 모델 크기 1/8 감소 (FP32 대비) |
| | 온디바이스 생성형 AI | 기기 내에서 텍스트, 이미지 생성 (인터넷 연결 불필요) |
| | 피지컬 AI | AI가 로봇 등 물리적 실체로 현실 세계와 상호작용 |
| | 하이브리드 AI | 온디바이스 + 클라우드 역할 분담 |
| | VLA 모델 | Vision-Language-Action, 로봇이 보고 듣고 행동하는 통합 AI |
| | 월드 모델 | 현실 세계의 물리 법칙 학습, 합성 데이터 생성 (예: Cosmos) |
| | 온디바이스 멀티 에이전트 AI | 기기 내 여러 AI 비서 협력, 민감 작업 로컬 처리 |
| **주요 제품** | 스냅드래곤 | 8 Gen 2 (INT4, 4.35배 AI↑), 8 Gen 3 (10B LLM), X Elite/Plus (AI PC), 8 Elite Gen 5 (NPU 39%↑) |
| | 엑시노스 2100 | 5nm, 3코어 NPU, 26 TOPS (SoC) |
| | 애플 A15/A17 Pro | A15 (15.8 TOPS), A17 Pro (3nm, 35 TOPS 뉴럴 엔진) |
| | 구글 Tensor/G2/G3 | 픽셀폰 전용 AP, 온디바이스 AI 가속 |
| | 엔비디아 Jetson Orin | AGX Orin (최대 275 TOPS), Orin Nano (최대 40 TOPS) |
| | 엔비디아 Project GR00T | 휴머노이드 로봇 파운데이션 모델 |
| | 엔비디아 Cosmos | 월드 파운데이션 모델 (물리 법칙 학습, 합성 데이터 생성) |
| | 삼성 갤럭시 S24/S25/S26 | 온디바이스 AI/Personal Data Engine/멀티 에이전트 AI |
| | 마이크로소프트 Copilot+ PC | NPU 40 TOPS 이상, AI PC 기준 제시 |
| | Alpamayo R1 | 추론형 종단간 자율주행 VLA 모델 |
| **성능 수치** | NPU TOPS | 26 (Exynos 2100, Snapdragon 888), 15.8 (A15), 35 (A17 Pro), 40 (Orin Nano), 48 (Lunar Lake NPU), 50 (Ryzen AI 300), 275 (AGX Orin), 550 (Isaac Nova Orin), 800 (Jetson Thor, 8비트 FP) |
| | 와트당 성능 | 스냅드래곤 8 Gen 2, INT4 적용 시 60% 향상 |
| | 모델 크기 | Phi-2 (2.7B 파라미터), Llama 2 (7B, 13B, 70B), Apple Intelligence (3B 온디바이스) |
| **시장 전망** | TinyML | 2021년 이후 연평균 20% 이상 고성장 (전망) |
| | 엣지 AI | 2025년 약 249억 달러, 2033년 약 1,186억 달러 (연평균 21.7% 성장, 전망) |
| | 온디바이스 AI | 2025년 약 178억 달러, 2032년 약 894억 달러 (연평균 26% 성장, 전망) |
| | AI PC | 2024년 전체 PC의 약 18% (4,800만 대), 2025년 약 40% (전망) |
| **주요 사건/시기** | 2021 | NPU 플래그십 AP 탑재, TinyML 표준화, 연합학습 현실화 |
| | 2022 | INT4 양자화 본격화, 엣지 AI 슈퍼컴퓨터 등장, ChatGPT 등장(새로운 화두) |
| | 2023 | 온디바이스 생성형 AI 상용화 시작, SLM 부상, 하이브리드 AI 공식화 |
| | 2024 | 피지컬 AI 부상 (GR00T), 온디바이스 AI 대중화 (Galaxy AI), AI PC 카테고리 확립 |
| | 2025 | 피지컬 AI 산업 표준화, VLA 모델 보편화, 월드 모델 실배포, 온디바이스 AI 에이전트화 |
| | 2026 | 추론형 자율주행(Alpamayo R1), 온디바이스 멀티 에이전트 AI 상용화(Galaxy S26) |

## H. 참고
*   @claude/research/physical_ai/2021.md
*   @claude/research/physical_ai/2022.md
*   @claude/research/physical_ai/2023.md
*   @claude/research/physical_ai/2024.md
*   @claude/research/physical_ai/2025.md
*   @claude/research/physical_ai/2026.md
*   Samsung Newsroom — Exynos 2100 발표, 2021-01-12 (https://news.samsung.com/global/samsung-sets-new-standard-for-flagship-mobile-processors-with-exynos-2100)
*   XDA Developers — Snapdragon 888 설명(Hexagon 780, 26 TOPS), 2020-12-02 (https://www.xda-developers.com/qualcomm-snapdragon-888-explained-specs-features/)
*   MLCommons — MLPerf Tiny Inference Benchmark v0.5 공개, 2021-06-16 (https://mlcommons.org/2021/06/mlperf-tiny-inference-benchmark/)
*   Google Blog — Google Tensor debuts on Pixel 6, 2021-08-02 (https://blog.google/products/pixel/google-tensor-debuts-new-pixel-6-fall/)
*   Wikipedia — Apple A15, 2021-09-14 (https://en.wikipedia.org/wiki/Apple_A15)
*   SEC 8-K — Veoneer/Qualcomm 인수 발표, 2021-10-04 (https://www.sec.gov/Archives/edgar/data/0001733186/000114036121033476/ny20000913x1_ex99-1.htm)
*   TensorFlow Blog — On-device training in TensorFlow Lite, 2021-11 (https://blog.tensorflow.org/2021/11/on-device-training-in-tensorflow-lite.html)
*   WikiChip Fuse — Arm Cortex-M55 & Ethos-U55 마이크로 NPU, 2020-02-10 (https://fuse.wikichip.org/news/3306/arm-launches-the-cortex-m55-and-its-micronpu-companion-the-ethos-u55/)
*   Roots Analysis — TinyML Market 보고 (https://www.rootsanalysis.com/tiny-machine-learning-market)
*   Edge AI and Vision Alliance — 스냅드래곤 8 Gen 2, 2022-11-16 (https://www.edge-ai-vision.com/2022/11/snapdragon-8-gen-2-defines-a-new-standard-for-premium-smartphones/)
*   Qualcomm — 스냅드래곤 8 Gen 2 AI 딥다이브(마이크로 타일 추론), 2023-03 (https://www.qualcomm.com/news/onq/2023/03/snapdragon-8-gen-2-ai-powerhouse-deep-dive-video)
*   NVIDIA Newsroom — Jetson AGX Orin 개발자 키트 출시, 2022-03 (https://nvidianews.nvidia.com/news/nvidia-announces-availability-of-jetson-agx-orin-developer-kit-to-advance-robotics-and-edge-ai)
*   NVIDIA Newsroom — Jetson Orin Nano 공개, 2022-09-20 (https://nvidianews.nvidia.com/news/nvidia-jetson-orin-nano-sets-new-standard-for-entry-level-edge-ai-and-robotics-with-80x-performance-leap)
*   NVIDIA Blog — Isaac Nova Orin(AMR 플랫폼), 2022-09-20 (https://blogs.nvidia.com/blog/2022/09/20/nvidia-isaac-nova-orin/)
*   9to5Google — Tensor G2 Photo Unblur, 2022-10-06 (https://9to5google.com/2022/10/06/photo-unblur-pixel-7/)
*   MLCommons — MLPerf 추론·Tiny 결과, 2022-04 (https://mlcommons.org/2022/04/mlperf-results-show-advances-in-machine-learning-inference-performance-and-efficiency/)
*   Embedded.com — 마이크로 NPU와 TinyML 컴퓨터 비전 (https://www.embedded.com/tinyml-computer-vision-is-turning-into-reality-with-micronpus-%C2%B5npus/)
*   Mordor Intelligence — Edge AI Chipset Market, 2022 (https://www.mordorintelligence.com/industry-reports/edge-ai-chipset-market)
*   Qualcomm — 세계 최초 온디바이스 Stable Diffusion 시연, 2023-02-23 (https://www.qualcomm.com/news/onq/2023/02/worlds-first-on-device-demonstration-of-stable-diffusion-on-android)
*   NVIDIA Technical Blog — Jetson Orin Nano 개발자 키트 공개, 2023-03 (https://developer.nvidia.com/blog/develop-ai-powered-robots-smart-vision-systems-and-more-with-nvidia-jetson-orin-nano-developer-kit/)
*   Qualcomm — The future of AI is hybrid(온디바이스 AI), 2023-05 (https://www.qualcomm.com/news/onq/2023/05/how-on-device-ai-is-enabling-generative-ai-to-scale)
*   Meta — Llama 2 공개, 2023-07-18 (https://about.fb.com/news/2023/07/llama-2/)
*   Wikipedia — Apple A17 Pro(3nm·35 TOPS), 2023-09 (https://en.wikipedia.org/wiki/Apple_A17)
*   TechCrunch — 픽셀 8 Pro 온디바이스 생성형 AI 구동, 2023-10-04 (https://techcrunch.com/2023/10/04/pixel-8-pro-runs-googles-generative-ai-models-on-device/)
*   Counterpoint Research — 스냅드래곤 8 Gen 3 온디바이스 생성형 AI, 2023-10 (https://counterpointresearch.com/en/insights/qualcomm-snapdragon-8-gen-3-on-device-generative-ai)
*   Samsung Global Newsroom — 삼성 가우스 공개(AI 포럼), 2023-11-08 (https://news.samsung.com/global/samsung-ai-forum-2023-day-2-discussing-technological-trends-and-the-future-of-generative-ai)
*   Google Blog — 픽셀 8 Pro Gemini Nano 탑재(12월 피처 드롭), 2023-12-06 (https://blog.google/products/pixel/feature-drop-december-2023/)
*   Microsoft Research — Phi-2: 소형 언어모델의 놀라운 성능, 2023-12-12 (https://www.microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/)
*   market.us — Edge AI Market(시장 규모/전망, 추정) (https://market.us/report/edge-ai-market/)
*   Samsung Global Newsroom — 갤럭시 S24·Galaxy AI 공개, 2024-01-17 (https://news.samsung.com/global/enter-the-new-era-of-mobile-ai-with-samsung-galaxy-s24-series)
*   TechFinitive — 엔비디아 CES 2024 로봇 ChatGPT 모먼트 선언, 2024-01-09 (https://www.techfinitive.com/nvidia-declares-chatgpt-moment-for-robotics-at-ces/)
*   NVIDIA Newsroom — Project GR00T·Jetson Thor·Isaac 업데이트, 2024-03-18 (https://nvidianews.nvidia.com/news/foundation-model-isaac-robotics-platform)
*   The Official Microsoft Blog — Copilot+ PC 발표(NPU 40 TOPS), 2024-05-20 (https://blogs.microsoft.com/blog/2024/05/20/introducing-copilot-pcs/)
*   Apple Machine Learning Research — On-Device/Server Foundation Models·Private Cloud Compute, 2024-06-10 (https://machinelearning.apple.com/research/introducing-apple-foundation-models)
*   Intel Newsroom — Lunar Lake(Core Ultra 200V) 출시, 2024-09-03 (https://newsroom.intel.com/artificial-intelligence/intels-lunar-lake-processors-arriving-q3-2024)
*   MobileSyrup — 퀄컴 스냅드래곤 8 Elite 발표, 2024-10-21 (https://mobilesyrup.com/2024/10/21/qualcomm-announces-snapdragon-8-elite-mobile-platform-with-oryon-cpu/)
*   Canalys/Omdia — AI PC 시장 전망(2024), 2024 (https://canalys.com/newsroom/ai-pc-market-2024)
*   Canalys Newsroom — AI 지원 PC Q4 2024 출하 점유 23%, 2025-02 (https://canalys.com/newsroom/ai-capable-pc-shipment-q4-2024)
*   Lightreading/Canalys — 2025년 AI PC 40% 전망, 2024 (https://www.lightreading.com/ai-machine-learning/ai-capable-pcs-forecast-to-make-up-40-of-global-pc-shipments-in-2025-canalys)
*   NVIDIA Newsroom, 2025-01-06, [NVIDIA Launches Cosmos World Foundation Model Platform to Accelerate Physical AI Development](https://nvidianews.nvidia.com/news/nvidia-launches-cosmos-world-foundation-model-platform-to-accelerate-physical-ai-development)
*   Samsung Newsroom, 2025-01-22, [Samsung Galaxy S25 Series Sets the Standard of AI Phone as a True AI Companion](https://news.samsung.com/global/samsung-galaxy-s25-series-sets-the-standard-of-ai-phone-as-a-true-ai-companion)
*   Figure AI, 2025-02-20, [Helix: A Vision-Language-Action Model for Generalist Humanoid Control](https://www.figure.ai/news/helix)
*   NVIDIA Newsroom, 2025-03-18, [NVIDIA Announces Isaac GR00T N1 — the World's First Open Humanoid Robot Foundation Model](https://nvidianews.nvidia.com/news/nvidia-isaac-gr00t-n1-open-humanoid-robot-foundation-model-simulation-frameworks)
*   NVIDIA Newsroom, 2025-03-18, [NVIDIA Announces Major Release of Cosmos World Foundation Models and Physical AI Data Tools](https://nvidianews.nvidia.com/news/nvidia-announces-major-release-of-cosmos-world-foundation-models-and-physical-ai-data-tools)
*   Google DeepMind, 2025-06-24, [Gemini Robotics On-Device brings AI to local robotic devices](https://deepmind.google/blog/gemini-robotics-on-device-brings-ai-to-local-robotic-devices/)
*   Google DeepMind, 2025-03, [Introducing Gemini Robotics and Gemini Robotics-ER](https://deepmind.google/blog/gemini-robotics-brings-ai-into-the-physical-world/)
*   Physical Intelligence, 2025, [π₀: Our First Generalist Policy](https://www.physicalintelligence.company/blog/pi0)
*   Fortune, 2025-01-30, [Elon Musk reveals massive plans for Tesla and Optimus](https://fortune.com/2025/01/30/elon-musk-reveals-massive-plans-tesla-optimus-self-driving-cars-humanoid-robots/)
*   Computer Weekly, 2025, [Samsung unpacks Galaxy AI's personal data engine](https://www.computerweekly.com/news/366618319/Samsung-unpacks-Galaxy-AIs-personal-data-engine)
*   Coherent Market Insights, 2026 전망, [On-Device AI Market](https://www.coherentmarketinsights.com/industry-reports/on-device-ai-market)
*   SNS Insider (GlobeNewswire), 2026-05-26 전망, [On-Device AI Market Size to Hit USD 185.23 Billion by 2035](https://www.globenewswire.com/news-release/2026/05/26/3301200/0/en/On-Device-AI-Market-Size-to-Hit-USD-185-23-Billion-by-2035-Research-by-SNS-Insider.html)
*   Grand View Research, 2025 전망, [Edge AI Market Report](https://www.grandviewresearch.com/industry-analysis/edge-ai-market-report)
*   Grand View Research, 2025 전망, [On-Device AI Market Report](https://www.grandviewresearch.com/industry-analysis/on-device-ai-market-report)
*   Morningstar/AccessWire, 2026 전망, [Neural Processors Market to Reach USD 1,010 Million by 2035](https://www.morningstar.com/news/accesswire/1159857msn/neural-processors-market-to-reach-usd-1010-million-by-2035-driven-by-edge-ai-expansion-and-on-device-intelligence-revolution)
*   NVIDIA Blog — CES 2026 특별 발표(Rubin·Alpamayo·Cosmos·6대 도메인), 2026-01-06, [https://blogs.nvidia.com/blog/2026-ces-special-presentation/](https://blogs.nvidia.com/blog/2026-ces-special-presentation/)
*   NVIDIA Newsroom — 새 피지컬 AI 모델·차세대 로봇, 2026-01, [https://nvidianews.nvidia.com/news/nvidia-releases-new-physical-ai-models-as-global-partners-unveil-next-generation-robots](https://nvidianews.nvidia.com/news/nvidia-releases-new-physical-ai-models-as-global-partners-unveil-next-generation-robots)
*   Hugging Face / NVIDIA — Isaac GR00T N1.7 Open Reasoning VLA, 2026, [https://huggingface.co/blog/nvidia/gr00t-n1-7](https://huggingface.co/blog/nvidia/gr00t-n1-7)
*   NVIDIA Developer Forums — Isaac GR00T N1.7 얼리 액세스, 2026, [https://forums.developer.nvidia.com/t/early-access-isaac-gr00t-n1-7-open-reasoning-vla-model-for-humanoid-robotics/366916](https://forums.developer.nvidia.com/t/early-access-isaac-gr00t-n1-7-open-reasoning-vla-model-for-humanoid-robotics/366916)
*   GitHub — NVIDIA/Isaac-GR00T (N1.7), [https://github.com/NVIDIA/Isaac-GR00T](https://github.com/NVIDIA/Isaac-GR00T)
*   Qualcomm — 스냅드래곤 8 Elite Gen 5 for Galaxy, 2026-02, [https://www.qualcomm.com/news/releases/2026/02/qualcomm-unveils-the-snapdragon-8-elite-gen-5-for-galaxy--drivin](https://www.qualcomm.com/news/releases/2026/02/qualcomm-unveils-the-snapdragon-8-elite-gen-5-for-galaxy--drivin)
*   Samsung Newsroom — 갤럭시 언팩 2026: 진정한 에이전틱 AI의 시작, 2026-02, [https://news.samsung.com/global/galaxy-unpacked-2026-highlights-from-galaxy-unpacked-the-beginning-of-truly-agentic-ai](https://news.samsung.com/global/galaxy-unpacked-2026-highlights-from-galaxy-unpacked-the-beginning-of-truly-agentic-ai)
*   SamMobile — 스냅드래곤 8 Elite Gen 5·갤럭시 S26 Ultra AI, 2026, [https://www.sammobile.com/news/how-snapdragon-8-elite-gen-5-improves-ai-performance-galaxy-s26-ultra/](https://www.sammobile.com/news/how-snapdragon-8-elite-gen-5-improves-ai-performance-galaxy-s26-ultra/)
*   Companies History — AI Edge Computing Market 2026, 2026, [https://www.companieshistory.com/ai-edge-computing-market](https://www.companieshistory.com/ai-edge-computing-market)
*   Mordor Intelligence — Edge AI Hardware Market, 2026, [https://www.mordorintelligence.com/industry-reports/edge-ai-hardware-market](https://www.mordorintelligence.com/industry-reports/edge-ai-hardware-market)
