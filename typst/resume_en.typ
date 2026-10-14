#import "template.typ": *

#let data = json("../data/resume.en.json")

#show: doc => resume(data: data, lang: "en", doc)

= Professional Experience

#for job in data.work [
  #let period = job.startDate + if job.endDate != none [ — #job.endDate] else [ — Present]
  #experience-item(
    title: job.position,
    company: job.name,
    period: period,
    summary: if "summary" in job { job.summary } else { "" },
    highlights: if "highlights" in job { job.highlights } else { () }
  )
]

= Education

#for edu in data.education [
  #let period = edu.startDate + if edu.endDate != edu.startDate [ — #edu.endDate] else []
  #let details = ()
  #if "area" in edu and edu.area != "" [ #let _ = details.push(edu.area) ]
  #if "score" in edu and edu.score != none [ #let _ = details.push(edu.score) ]
  #if "courses" in edu [
    #for c in edu.courses [ #let _ = details.push(c) ]
  ]
  #education-item(
    degree: edu.studyType,
    institution: edu.institution,
    period: period,
    details: details
  )
]

= Technical Skills

#for s in data.skills [
  #skill-badge(s.name, s.keywords)
]

= Languages & Interests

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #text(weight: "bold", size: 9pt)[Languages:] \
    #for l in data.languages [
      - #text(weight: "medium")[#l.language]: #text(fill: rgb("#4b5563"))[#l.fluency] \
    ]
  ],
  [
    #text(weight: "bold", size: 9pt)[Interests:] \
    #for i in data.interests [
      - #text(weight: "medium")[#i.name] #if i.keywords.len() > 0 [ (#i.keywords.join(", ")) ] \
    ]
  ]
)
