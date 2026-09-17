// MA201 Study Guide Template (Typst)

#let primary-color = rgb("#1e3a8a")
#let accent-blue = rgb("#2563eb")
#let bg-def = rgb("#eff6ff")
#let border-def = rgb("#93c5fd")
#let bg-tip = rgb("#f0fdf4")
#let border-tip = rgb("#86efac")
#let bg-prob = rgb("#fff7ed")
#let border-prob = rgb("#fdba74")

#let conf(
  title: "MA201 Study Guide",
  subtitle: "Multivariable Calculus",
  lecture: "Lecture 01",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  doc
) = {
  set page(
    paper: "us-letter",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 [
        #text(size: 8pt, fill: luma(100))[
          *MA201: Multivariable Calculus* | #lecture
          #h(1fr)
          #date
        ]
        #v(-4pt)
        #line(length: 100%, stroke: 0.5pt + luma(180))
      ]
    },
    footer: context {
      text(size: 8pt, fill: luma(120))[
        #h(1fr)
        Page #counter(page).get().first()
      ]
    }
  )

  set text(
    font: ("Atkinson Hyperlegible", "Calibri", "Liberation Sans", "Arial"),
    size: 10.5pt,
    fill: rgb("#0f172a"),
    weight: "regular"
  )

  set par(justify: true, leading: 0.65em)

  // Title Block
  block(
    width: 100%,
    fill: rgb("#f8fafc"),
    inset: 14pt,
    radius: 6pt,
    stroke: 0.5pt + rgb("#e2e8f0"),
    [
      #text(fill: primary-color, size: 18pt, weight: "bold")[#title] \
      #v(2pt)
      #text(fill: accent-blue, size: 12pt, weight: "medium")[#subtitle --- #lecture]
      #h(1fr)
      #text(fill: luma(100), size: 9pt)[#date]
    ]
  )
  v(10pt)

  doc
}

// Callout Cards
#let definition(title: "Definition", body) = {
  v(6pt)
  block(
    width: 100%,
    fill: bg-def,
    stroke: (left: 4pt + border-def, rest: 0.5pt + border-def),
    inset: (x: 12pt, y: 10pt),
    radius: (right: 4pt),
    [
      #text(weight: "bold", fill: rgb("#1d4ed8"))[📘 #title] \
      #v(3pt)
      #body
    ]
  )
  v(6pt)
}

#let keytip(title: "Key Tip", body) = {
  v(6pt)
  block(
    width: 100%,
    fill: bg-tip,
    stroke: (left: 4pt + border-tip, rest: 0.5pt + border-tip),
    inset: (x: 12pt, y: 10pt),
    radius: (right: 4pt),
    [
      #text(weight: "bold", fill: rgb("#15803d"))[💡 #title] \
      #v(3pt)
      #body
    ]
  )
  v(6pt)
}

#let problem(title: "Practice Problem", body) = {
  v(6pt)
  block(
    width: 100%,
    fill: bg-prob,
    stroke: (left: 4pt + border-prob, rest: 0.5pt + border-prob),
    inset: (x: 12pt, y: 10pt),
    radius: (right: 4pt),
    [
      #text(weight: "bold", fill: rgb("#c2410c"))[✏️ #title] \
      #v(3pt)
      #body
    ]
  )
  v(6pt)
}
