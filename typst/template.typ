// Modern Executive Resume Template in Typst

#let resume(
  data: none,
  lang: "fr",
  body
) = {
  // Page setup
  set page(
    paper: "a4",
    margin: (x: 1.6cm, y: 1.5cm),
    header: none,
    footer: none,
  )

  // Typography settings
  set text(
    font: ("Inter", "Roboto", "Segoe UI", "Arial"),
    size: 9.5pt,
    weight: "regular",
    fill: rgb("#1f2937"),
    lang: lang,
  )

  set par(justify: false, leading: 0.55em)

  // Colors
  let primary = rgb("#1e40af") // Indigo / Deep Blue
  let dark = rgb("#0f172a")
  let muted = rgb("#4b5563")
  let line-color = rgb("#e2e8f0")

  // Header
  block(width: 100%, inset: (bottom: 10pt))[
    #grid(
      columns: (1fr, auto),
      gutter: 15pt,
      [
        #text(size: 22pt, weight: "bold", fill: dark)[#data.basics.name]
        #v(2pt)
        #text(size: 11pt, weight: "medium", fill: primary)[#data.basics.label]
        #v(4pt)
        #text(size: 8.5pt, fill: muted)[#data.basics.summary]
      ],
      [
        #set text(size: 8.5pt, fill: muted)
        #align(right)[
          #data.basics.email \
          #data.basics.phone \
          #data.basics.location.city, #data.basics.location.countryCode \
          #link(data.basics.url)[#data.basics.url.replace("https://", "")]
        ]
      ]
    )
  ]

  // Section heading style
  show heading.where(level: 1): it => block(width: 100%, inset: (top: 8pt, bottom: 4pt))[
    #text(size: 11pt, weight: "bold", fill: primary)[#upper(it.body)]
    #v(2pt)
    #line(length: 100%, stroke: 0.75pt + primary)
  ]

  body
}

#let experience-item(
  title: "",
  company: "",
  location: "",
  period: "",
  highlights: (),
  summary: ""
) = {
  block(width: 100%, inset: (bottom: 6pt))[
    #grid(
      columns: (1fr, auto),
      [
        #text(weight: "bold", fill: rgb("#0f172a"))[#title] #text(fill: rgb("#64748b"))[—] #text(weight: "semibold", fill: rgb("#1e40af"))[#company]
        #if location != "" [ #text(fill: rgb("#64748b"), size: 8.5pt)[(#location)] ]
      ],
      [
        #text(size: 8.5pt, weight: "medium", fill: rgb("#64748b"))[#period]
      ]
    )
    #if summary != "" [
      #v(1pt)
      #text(size: 8.5pt, fill: rgb("#4b5563"), style: "italic")[#summary]
    ]
    #if highlights.len() > 0 [
      #v(2pt)
      #list(
        ..highlights.map(h => text(size: 8.8pt)[#h])
      )
    ]
  ]
}

#let education-item(
  degree: "",
  institution: "",
  period: "",
  details: ()
) = {
  block(width: 100%, inset: (bottom: 5pt))[
    #grid(
      columns: (1fr, auto),
      [
        #text(weight: "bold", fill: rgb("#0f172a"))[#degree] #text(fill: rgb("#64748b"))[—] #text(weight: "semibold", fill: rgb("#1e40af"))[#institution]
      ],
      [
        #text(size: 8.5pt, weight: "medium", fill: rgb("#64748b"))[#period]
      ]
    )
    #if details.len() > 0 [
      #v(1pt)
      #for d in details [
        #text(size: 8.5pt, fill: rgb("#4b5563"))[#d] \
      ]
    ]
  ]
}

#let skill-badge(name, keywords) = {
  block(width: 100%, inset: (bottom: 4pt))[
    #text(weight: "bold", size: 8.8pt, fill: rgb("#0f172a"))[#name: ]
    #text(size: 8.8pt, fill: rgb("#334155"))[#keywords.join(" • ")]
  ]
}
