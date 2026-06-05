export const meta = {
  name: 'ssafy-pt-research-v2b',
  description: 'SSAFY PT면접 자료 마무리: 연도파일 2개 재작성 + 16개 STUDY.md/README + 루트 인덱스 (schema 미사용)',
  phases: [
    { title: '연도파일 보수', detail: 'ai_governance/2026, network/2025 v2 재작성' },
    { title: '주제 STUDY·README', detail: '16개 주제 종합 학습문서 + 인덱스' },
    { title: '루트 인덱스', detail: 'research/README.md' },
  ],
}

const ROOT = '/home/ywlee/interview/claude/research'

const TOPICS = [
  { slug: 'genai',         label: '생성형 AI · LLM · 파운데이션 모델' },
  { slug: 'agent',         label: 'AI 에이전트 · 에이전틱 AI' },
  { slug: 'semiconductor', label: '반도체 · HBM · AI 인프라' },
  { slug: 'cloud',         label: '클라우드 · 쿠버네티스 · DevOps' },
  { slug: 'security',      label: '보안 · 제로트러스트 · 랜섬웨어' },
  { slug: 'bigtech',       label: '빅테크 전략 · 동향(M&A · 실적 · 규제)' },
  { slug: 'emergingtech',  label: '신기술 · 양자컴퓨팅 · 차세대 컴퓨팅' },
  { slug: 'korea_it',      label: '한국 IT · 삼성 (지원동기 연계)' },
  { slug: 'robotics',      label: '로봇 · 휴머노이드' },
  { slug: 'physical_ai',   label: '피지컬 AI · 임베디드 AI · 온디바이스' },
  { slug: 'data',          label: '데이터 · 빅데이터 · 벡터DB' },
  { slug: 'mobility',      label: '모빌리티 · 자율주행 · 전기차' },
  { slug: 'fintech',       label: '핀테크 · 블록체인 · 디지털자산' },
  { slug: 'ai_governance', label: 'AI 규제 · 거버넌스 · 윤리' },
  { slug: 'network',       label: '네트워크 · 엣지 · 6G' },
  { slug: 'opensource',    label: '오픈소스 · 개발자 생태계' },
]

const APPLICANT =
  '지원자 배경: 컨테이너 보안, 시스템 콜 동적 관측(eBPF/strace류) 기반 이상탐지, Linux 커널 이해를 가진 SSAFY 지원자. 풀스택·코딩테스트로 역량을 확장하려 함.'

const NOFAKE = [
  '오늘은 2026-06-05이다. 미래(2026-06-05 이후) 사건을 일어난 것처럼 지어내지 마라.',
  '절대 허구의 뉴스·기업명·URL을 만들지 마라. WebSearch/WebFetch로 실제 확인한 출처만 인용한다.',
  '실제 URL을 못 찾으면 매체·날짜만 적고 URL은 생략한다(가짜 링크 금지).',
  '파일 본문은 반드시 "## "로 시작하고, 본문 외에 "작업을 완료했습니다" 같은 군더더기 문장을 파일에 쓰지 마라.',
].join('\n')

function yearPrompt(slug, label, year, path) {
  return [
    `너는 SSAFY PT면접 학습자료를 만드는 IT 시사 리서처다. 주제 "${label}"(slug=${slug})의 ${year}년 셀을 v2 형식으로 새로 작성한다.`,
    APPLICANT,
    NOFAKE,
    '',
    `기존 파일 ${path}를 Read로 참고하되, WebSearch로 사실을 검증·보강한다.`,
    '아래 v2 10목차를 그대로 사용해 한국어로 작성한다(비유·유추 금지):',
    `## ${year} · ${label}`,
    '### 1. 한눈에 보기 — 3~4줄',
    '### 2. 그해 핵심 트렌드 — 불릿 4~6개',
    '### 3. 대표 뉴스·사건 — 불릿 6개 이상, 각 항목 끝 (매체·날짜·링크) 출처 필수',
    '### 4. 신기술 개념설명 — 핵심 기술·용어 2~3개, 각: (1)정의 (2)왜 나왔나 (3)원리 (4)의의·한계',
    '### 5. 핵심 기업·제품·기술 키워드',
    '### 6. 시장 수치·전망 — 전망/추정 표기',
    '### 7. 전년 대비 변화점',
    '### 8. PT 발표 주제 후보 — 2~3개, 제목+한 줄 메시지+발표 3단 구조',
    '### 9. 예상 질문 + 모범답안 — 4개 이상, 대본형 답안(3~6문장), 일부 지원자 경험 연계',
    '### 10. 참고문헌 — 본문 인용 출처 목록',
    '',
    `완성 문서를 Write로 ${path}에 저장한다. 그 후 한 줄로 "완료: ${slug}/${year}, 출처 N개"만 답한다.`,
  ].join('\n')
}

function studyPrompt(slug, label, dir) {
  return [
    `너는 SSAFY PT면접 학습자료를 만드는 IT 시사 리서처다. 주제 "${label}"(slug=${slug})의 6년치를 종합한 메인 공부자료 STUDY.md와 인덱스 README.md를 만든다.`,
    APPLICANT,
    NOFAKE,
    '',
    `먼저 ${dir}/2021.md ~ ${dir}/2026.md 6개 연도파일을 모두 Read로 읽어 종합한다. 핵심 개념·사실은 필요시 WebSearch로 보강한다.`,
    '',
    `[1] ${dir}/STUDY.md 를 아래 목차로 한국어 작성:`,
    `# ${label} — SSAFY PT면접 학습문서`,
    '## A. 왜 이 주제가 중요한가 (3줄)',
    '## B. 반드시 아는 핵심 개념 사전 — 빈출 용어·기술 6개 이상을 정의/원리/의의로 설명',
    '## C. 연도별 흐름 한눈에 — 2021→2026 각 한 줄 + 연도파일 상대링크([2024](2024.md) 형식)',
    '## D. PT 발표 주제 추천 — 3~5개, 각: 제목 / 핵심 메시지 / 발표 3단 구조(문제→근거→제언)',
    '## E. 모범답안집 — 예상질문 8개 이상 + 면접장 대본형 모범답안. 일부 지원자 경험 연계',
    '## F. 지원자 경험 연계 포인트 — 컨테이너 보안·시스템콜 이상탐지·커널을 이 주제와 잇는 멘트',
    '## G. 빠른 암기 카드 — 핵심 수치·날짜·키워드 표',
    '## H. 참고 — 연도파일 링크 + 주요 출처',
    '',
    `[2] ${dir}/README.md 를 작성: "${label}" 주제 인덱스. STUDY.md와 2021~2026.md 상대링크 + 각 한 줄 설명.`,
    '',
    `두 파일을 Write로 저장 후 한 줄로 "완료: ${slug} STUDY+README"만 답한다.`,
  ].join('\n')
}

// Phase 1: 연도파일 2개 보수 (STUDY가 읽기 전에 먼저)
phase('연도파일 보수')
await parallel([
  () => agent(yearPrompt('ai_governance', 'AI 규제 · 거버넌스 · 윤리', '2026', `${ROOT}/ai_governance/2026.md`), { label: 'ai_governance/2026', phase: '연도파일 보수' }),
  () => agent(yearPrompt('network', '네트워크 · 엣지 · 6G', '2025', `${ROOT}/network/2025.md`), { label: 'network/2025', phase: '연도파일 보수' }),
])

// Phase 2: 16개 주제 STUDY + README
phase('주제 STUDY·README')
await parallel(
  TOPICS.map((t) => () =>
    agent(studyPrompt(t.slug, t.label, `${ROOT}/${t.slug}`), { label: `${t.slug}/STUDY`, phase: '주제 STUDY·README' })
  )
)

// Phase 3: 루트 인덱스
phase('루트 인덱스')
const topicList = TOPICS.map((t, i) => `${i + 1}. ${t.slug} — ${t.label} (디렉토리: ./${t.slug}/, 메인: ./${t.slug}/STUDY.md)`).join('\n')
await agent(
  [
    `${ROOT}/README.md 를 작성한다. SSAFY PT면접 학습자료의 루트 인덱스다.`,
    NOFAKE,
    '구성: (1) 자료 목적·사용법 한 문단 (2) 16개 주제 표(번호·슬러그·라벨·STUDY.md 상대링크) (3) "면접 활용 가이드" — 준비 순서(개념설명→뉴스→발표주제→모범답안)와 빈출 주제 추천.',
    '각 디렉토리에는 STUDY.md와 2021~2026.md가 있다. 주제 목록:',
    topicList,
    '한국어로 작성하고 Write로 저장 후 한 줄 "완료"만 답한다.',
  ].join('\n'),
  { label: 'root/README', phase: '루트 인덱스' }
)

return '마무리 워크플로 완료: 연도파일 2개 + STUDY/README 16개 + 루트 인덱스'
