export const meta = {
  name: 'ssafy-pt-research-v2',
  description: 'SSAFY PT면접 학습자료 v2 재조사: 96개 연도셀(개념설명+모범답안 강화) + 16개 STUDY.md + 인덱스',
  phases: [
    { title: '연도조사·작성', detail: '16주제 × 6년 = 96셀을 웹검색 근거로 재작성(v2 10목차)' },
    { title: '주제 STUDY·README', detail: '주제별 6년치 종합 학습문서 + 인덱스' },
    { title: '루트 인덱스', detail: 'research/README.md 전체 인덱스' },
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
const YEARS = ['2021', '2022', '2023', '2024', '2025', '2026']

const APPLICANT = [
  '지원자 배경: 컨테이너 보안, 시스템 콜 동적 관측(eBPF/strace류) 기반 이상탐지,',
  'Linux 커널 이해를 가진 SSAFY 지원자. 풀스택·코딩테스트로 역량을 확장하려 함.',
].join(' ')

const SOURCING = [
  '근거 규칙(필수): 모든 서술은 실제 뉴스기사/공식발표에 근거한다. 근거 없는 추정 금지.',
  'WebSearch/WebFetch를 적극 사용해 실제 기사·공식 발표를 찾아 인용한다.',
  '대표 뉴스 각 항목 끝에 (매체명, YYYY-MM-DD, 마크다운 링크) 출처를 붙인다.',
  '공식 출처(기업 뉴스룸·정부/공공·표준문서·위키피디아·주요 언론) 우선. 수치·날짜는 교차확인.',
  '미확정·전망치는 본문에 "전망" 또는 "추정"으로 표기. 2026년은 진행 중이라 상반기 사실 위주 + 전망 명시.',
].join('\n')

function yearPrompt(slug, label, year, path) {
  return [
    `너는 SSAFY PT면접 학습자료를 만드는 IT 시사 리서처다. 주제 "${label}"(slug=${slug})의 ${year}년 셀을 재작성한다.`,
    APPLICANT,
    '',
    `먼저 기존 파일 ${path} 를 Read로 읽어 출발점으로 삼되, 반드시 웹검색으로 사실을 검증하고 내용을 더 깊고 세밀하게 보강한다(기존보다 분량·깊이 모두 향상).`,
    '',
    SOURCING,
    '',
    '아래 v2 10목차를 그대로 사용해 한국어로 작성한다(비유·유추 금지, 직접 기술):',
    '',
    `## ${year} · ${label}`,
    '### 1. 한눈에 보기  — 3~4줄 압축',
    '### 2. 그해 핵심 트렌드  — 불릿 4~6개',
    '### 3. 대표 뉴스·사건  — 불릿 6개 이상, 각 항목 끝에 (매체·날짜·링크) 출처 필수',
    '### 4. 신기술 개념설명  — 그해 등장/부상한 핵심 기술·용어 2~3개. 각 기술마다 (1)한 줄 정의 (2)왜 나왔나(기존 한계) (3)어떻게 동작하나(원리, 비전공 면접관도 이해하게) (4)무엇이 달라지나(의의·한계)',
    '### 5. 핵심 기업·제품·기술 키워드',
    '### 6. 시장 수치·전망  — 미확정·전망치는 "전망/추정" 표기',
    '### 7. 전년 대비 변화점  — 새로 뜬 것 / 식은 것',
    '### 8. PT 발표 주제 후보  — 2~3개, 각: 제목 + 한 줄 메시지 + 발표 3단 구조(문제→근거→제언)',
    '### 9. 예상 질문 + 모범답안  — 4개 이상. 각 질문에 면접장에서 그대로 말할 대본형 모범답안(3~6문장). 일부 답변에 지원자 경험(컨테이너 보안·시스템콜 이상탐지·커널)을 자연스럽게 연계',
    '### 10. 참고문헌  — 본문 인용 출처를 매체·날짜와 함께 목록으로',
    '',
    `완성한 문서를 Write로 정확히 이 경로에 저장한다: ${path}`,
    '저장 후에는 status만 반환한다(파일 본문을 응답에 다시 쓰지 말 것).',
  ].join('\n')
}

function studyPrompt(slug, label, dir) {
  return [
    `너는 SSAFY PT면접 학습자료를 만드는 IT 시사 리서처다. 주제 "${label}"(slug=${slug})의 6년치를 종합한 메인 공부자료 STUDY.md와 README.md를 만든다.`,
    APPLICANT,
    '',
    `먼저 ${dir}/2021.md ~ ${dir}/2026.md 6개 연도파일을 모두 Read로 읽어 종합한다. 필요하면 WebSearch로 핵심 개념·최신 사실을 보강한다.`,
    SOURCING,
    '',
    `[1] ${dir}/STUDY.md 를 아래 목차로 한국어 작성(비유 금지):`,
    `# ${label} — SSAFY PT면접 학습문서`,
    '## A. 왜 이 주제가 중요한가 (3줄)',
    '## B. 반드시 아는 핵심 개념 사전 — 면접 빈출 용어·기술을 정의/원리/의의로 설명(6개 이상)',
    '## C. 연도별 흐름 한눈에 — 2021→2026 각 한 줄 + 연도파일 상대링크([2024](2024.md) 형식)',
    '## D. PT 발표 주제 추천 — 3~5개, 각: 제목 / 핵심 메시지 / 발표 3단 구조(문제→근거→제언)',
    '## E. 모범답안집 — 예상질문 8개 이상 + 면접장에서 그대로 말할 대본형 모범답안. 일부는 지원자 경험 연계',
    '## F. 지원자 경험 연계 포인트 — 컨테이너 보안·시스템콜 이상탐지·커널을 이 주제와 잇는 멘트 모음',
    '## G. 빠른 암기 카드 — 핵심 수치·날짜·키워드 표',
    '## H. 참고 — 연도파일 링크 + 주요 출처',
    '',
    `[2] ${dir}/README.md 를 작성: "${label}" 주제의 인덱스. STUDY.md와 2021~2026.md로의 상대링크 목록 + 한 줄 설명.`,
    '',
    '두 파일을 Write로 저장 후 status만 반환한다(본문 재출력 금지).',
  ].join('\n')
}

const STATUS = {
  type: 'object',
  additionalProperties: false,
  properties: {
    ok: { type: 'boolean' },
    path: { type: 'string' },
    sources: { type: 'number', description: '인용한 출처 개수(대략)' },
    note: { type: 'string', description: '한 줄 메모(특이사항/누락)' },
  },
  required: ['ok', 'path'],
}

// Phase 1+2: 주제별 파이프라인 — 6년 작성(stage1) → STUDY/README(stage2)
const results = await pipeline(
  TOPICS,
  (t) =>
    parallel(
      YEARS.map((y) => () =>
        agent(yearPrompt(t.slug, t.label, y, `${ROOT}/${t.slug}/${y}.md`), {
          label: `${t.slug}/${y}`,
          phase: '연도조사·작성',
          schema: STATUS,
        })
      )
    ),
  (yearStatuses, t) =>
    agent(studyPrompt(t.slug, t.label, `${ROOT}/${t.slug}`), {
      label: `${t.slug}/STUDY`,
      phase: '주제 STUDY·README',
      schema: STATUS,
    }).then((s) => ({ slug: t.slug, label: t.label, study: s, years: (yearStatuses || []).filter(Boolean).length }))
)

// Phase 3: 루트 인덱스
phase('루트 인덱스')
const topicList = TOPICS.map((t, i) => `${i + 1}. ${t.slug} — ${t.label} (./${t.slug}/STUDY.md)`).join('\n')
const rootStatus = await agent(
  [
    `${ROOT}/README.md 를 작성한다. 이것은 SSAFY PT면접 학습자료의 루트 인덱스다.`,
    '구성: (1) 자료 목적·사용법 한 문단 (2) 16개 주제 표(슬러그·라벨·STUDY.md 상대링크·연도파일 링크)',
    '(3) "면접 활용 가이드" — 발표 준비 순서(개념설명→뉴스→발표주제→모범답안), 빈출 주제 추천.',
    '아래 16개 주제 목록을 사용한다(각 디렉토리에는 STUDY.md와 2021~2026.md가 있다):',
    topicList,
    '한국어로 작성하고 Write로 저장한 뒤 status만 반환한다.',
  ].join('\n'),
  { label: 'root/README', phase: '루트 인덱스', schema: STATUS }
)

return {
  topics: results.filter(Boolean).length,
  yearCellsDone: results.filter(Boolean).reduce((a, r) => a + (r.years || 0), 0),
  root: rootStatus,
  perTopic: results.filter(Boolean).map((r) => ({ slug: r.slug, years: r.years, study: r.study?.ok })),
}
