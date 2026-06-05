# 클라우드 · 쿠버네티스 · DevOps (slug: `cloud`)

SSAFY PT면접 대비 IT 시사 자료. 연도별로 "그해 핵심 트렌드 → 대표 뉴스 → 키워드 → 수치 → 변화점 → 발표 주제 → 꼬리질문 → 참고문헌" 순으로 정리했다.

## 메인 학습문서
- [STUDY.md](./STUDY.md) — 6년치(2021~2026)를 종합한 메인 공부자료. 핵심 개념 사전, 연도별 흐름, PT 발표 주제 추천, 모범답안집(12문), 지원자 경험 연계, 빠른 암기 카드 수록.

## 연도별 자료
- [2021](./2021.md) — dockershim deprecation, GitOps(Argo CD·Flux) 확산, Log4Shell 공급망 보안 충격
- [2022](./2022.md) — 쿠버네티스 1.24 dockershim 제거, 플랫폼 엔지니어링·IDP 부상, FinOps, eBPF
- [2023](./2023.md) — Terraform BSL 전환·OpenTofu 포크, Cilium CNCF 졸업, 생성형 AI로 클라우드 재가속
- [2024](./2024.md) — 쿠버네티스 10주년, AI/ML·GPU 워크로드, Falco 졸업, Broadcom-VMware 격변
- [2025](./2025.md) — 쿠버네티스 'AI의 OS' 정착, MCP·DRA, IBM-HashiCorp 인수, AWS us-east-1 장애
- [2026](./2026.md) (1~6월) — 에이전트 인프라(agentgateway·Agent Sandbox), AI 플랫폼의 K8s 대수렴, 문화가 1순위 과제

## 관통 키워드
- 컨테이너 런타임: 도커 → containerd·CRI-O (dockershim deprecation 2020 → 제거 2022)
- 오케스트레이션: 쿠버네티스(2014 탄생 → 2024 10주년 → 2025 'AI의 OS')
- 운영 방식: GitOps(Argo CD·Flux) → 플랫폼 엔지니어링·IDP(Backstage)
- 커널 레벨 기술: eBPF(Cilium·Tetragon·Falco) — 네트워킹·관측·런타임 보안
- 비용·거버넌스: FinOps, 리패트리에이션, 오픈소스 라이선스(BSL·OpenTofu)
- 보안: 소프트웨어 공급망(SBOM·Sigstore), 런타임 위협 탐지(시스템 콜·eBPF)
- AI 전환: 생성형 AI(2023) → AI 추론 플랫폼(2025) → 에이전틱 인프라(2026)

## 지원자 강점 연계 포인트
컨테이너 보안·시스템 콜 동적 관측 기반 이상탐지·Linux 커널 이해는 이 주제와 직결된다.
- eBPF/Falco/Tetragon: 커널에서 시스템 콜을 파싱해 컨테이너 위협을 탐지 — 지원자가 직접 다룬 방식과 동일
- 컨테이너 격리(cgroups·namespace), 런타임 전환(CRI), GPU 자원 격리의 한계 설명 가능
- AI 에이전트 시대의 런타임 행위 탐지·아이덴티티 통제로 강점을 확장
