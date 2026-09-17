// ===== MA201 Study Notes — Template =====

#let ink    = rgb("#2b2d42")
#let paper  = rgb("#fffdf8")
#let teal   = rgb("#0f8b8d")
#let teal-l = rgb("#e3f3f2")
#let amber  = rgb("#e0a458")
#let amber-l= rgb("#fbf0e0")
#let coral  = rgb("#ef6461")
#let coral-l= rgb("#fdeceb")
#let lilac  = rgb("#8e7dbe")
#let lilac-l= rgb("#f1eef8")
#let grid-c = rgb("#d8d8d8")

#let body-font  = "Atkinson Hyperlegible"
#let head-font  = "Patrick Hand"
#let note-font  = "Caveat"

#let doc(title: "", subtitle: "", landscape: true, body) = {
  set page(
    paper: "us-letter",
    flipped: landscape,
    margin: if landscape { (x: 1.8cm, y: 1.4cm) } else { (x: 1.5cm, y: 1.6cm) },
    fill: paper,
    footer: context [
      #set text(size: 8pt, fill: ink.lighten(40%), font: body-font)
      #line(length: 100%, stroke: 0.5pt + grid-c)
      #v(2pt)
      #h(1fr) MA201 study notes · #title #h(1fr) #counter(page).display("1")
    ]
  )
  set text(font: body-font, size: 10.3pt, fill: ink, lang: "en")
  set par(justify: true, leading: 0.62em, spacing: 0.9em)
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    v(0.3em)
    block(width: 100%, fill: ink, radius: 4pt, inset: (x: 10pt, y: 7pt))[
      #set text(font: head-font, size: 18pt, fill: white)
      #it.body
    ]
    v(0.35em)
  }
  show heading.where(level: 2): it => {
    v(0.5em)
    text(font: head-font, size: 14pt, fill: teal.darken(10%))[#it.body]
    v(-0.3em)
    line(length: 100%, stroke: 1.2pt + teal.lighten(40%))
    v(0.2em)
  }

  // cover strip
  block(width: 100%, above: 0em, below: 0.8em)[
    #text(font: head-font, size: 26pt, fill: ink)[#title]
    #linebreak()
    #text(font: body-font, size: 11pt, fill: ink.lighten(25%), style: "italic")[#subtitle]
  ]

  body
}

// ---- colored concept box ----
#let cbox(color, light, icon, label, body) = block(
  width: 100%,
  fill: light,
  stroke: (left: 3pt + color),
  radius: 3pt,
  inset: 9pt,
  above: 0.6em, below: 0.6em,
  breakable: false,
)[
  #text(font: head-font, size: 12pt, fill: color.darken(15%))[#icon #label]
  #v(2pt)
  #set text(size: 9.8pt)
  #body
]

#let definition(title: "Definition", body) = cbox(teal, teal-l, "◆", title, body)
#let keytip(title: "Key Tip", body) = cbox(amber, amber-l, "★", title, body)
#let example(title: "Worked Example", body) = cbox(lilac, lilac-l, "✎", title, body)

// ---- inline highlighter ----
#let hl(body, color: amber) = box(fill: color.lighten(55%), outset: (x: 2pt, y: 1pt), radius: 1.5pt)[#body]

// ---- reference chip row ----
#let refs(..items) = block(width: 100%, above: 0.5em, below: 0.9em)[
  #set text(size: 8.6pt, font: body-font, fill: ink.lighten(10%))
  #for it in items.pos() [
    #box(fill: coral-l, stroke: 0.6pt + coral.lighten(20%), radius: 8pt, inset: (x: 7pt, y: 3.5pt))[#it]
    #h(5pt)
  ]
]

// ---- figure card ----
#let fig(path, caption: "", w: 100%) = block(width: 100%, above: 0.2em, below: 0.2em)[
  #align(center)[
    #box(fill: white, stroke: 0.7pt + grid-c, radius: 5pt, inset: 6pt)[
      #image(path, width: w)
    ]
    #v(2pt)
    #text(size: 8.3pt, style: "italic", fill: ink.lighten(30%))[#caption]
  ]
]

// ---- side-by-side text + figure ----
#let split(left, right, ratio: 1fr) = grid(
  columns: (ratio, ratio),
  gutter: 12pt,
  left, right
)

// ---- annotation (handwritten-style margin note) ----
#let note(body) = text(font: note-font, size: 15pt, fill: coral.darken(10%))[#body]

// ---- compact quadric-surface card: image + formula + short blurb ----
#let qcard(name, formula, img, blurb) = block(
  width: 100%,
  fill: white,
  stroke: 0.8pt + grid-c,
  radius: 5pt,
  inset: 8pt,
  above: 0pt, below: 0pt,
)[
  #text(font: head-font, size: 12.5pt, fill: teal.darken(10%))[#name]
  #v(-2pt)
  #line(length: 100%, stroke: 0.8pt + teal.lighten(55%))
  #grid(
    columns: (1.15fr, 1fr),
    gutter: 6pt,
    align(center + horizon)[
      #v(2pt)
      #formula
      #v(2pt)
      #text(size: 8.6pt)[#blurb]
    ],
    align(center + horizon)[#image(img, width: 92%)],
  )
]

// ===== Framework additions: alert cards, matrices, worksheet =====

#let emerald  = rgb("#2a9d5c")
#let emerald-l= rgb("#e4f4ea")
#let indigo   = rgb("#3d5a99")
#let indigo-l = rgb("#e8edf7")

#let quizalert(title: "iClicker / Quiz Alert", body) = cbox(coral, coral-l, "⚠", title, body)
#let mapletip(title: "Maple Lab Tip", body) = cbox(emerald, emerald-l, "⌘", title, body)
#let assignalert(title: "Assignment / Test Alert", body) = cbox(indigo, indigo-l, "✓", title, body)

// recognition matrix / comparison table
#let matrix(headers, ..rows) = align(center)[
  #table(
    columns: headers.len(),
    stroke: 0.6pt + grid-c,
    inset: (x: 6pt, y: 5pt),
    align: left + horizon,
    fill: (x, y) => if y == 0 { ink } else if calc.odd(y) { white } else { teal-l.lighten(45%) },
    ..headers.map(h => text(fill: white, weight: "bold", size: 9pt)[#h]),
    ..rows.pos().map(c => text(size: 8.8pt)[#c]),
  )
]

// monospace code block (Maple) — raw() disables smart-dash/quote substitution
// so the text pastes into Maple verbatim
#let code(src) = block(
  width: 100%, fill: ink.lighten(94%), radius: 3pt, inset: 7pt,
  above: 0.4em, below: 0.4em, breakable: false,
)[#text(font: "DejaVu Sans Mono", size: 8.3pt, fill: ink)[#raw(src, block: true)]]

// worksheet question
#let question(n, body) = block(
  width: 100%, fill: white, stroke: 0.8pt + grid-c, radius: 4pt,
  inset: 9pt, above: 0.5em, below: 0.5em, breakable: false,
)[
  #text(font: head-font, size: 12pt, fill: indigo)[Q#n]
  #v(2pt)
  #body
]

// answer-key entry
#let answer(n, body) = block(
  width: 100%, above: 0.9em, below: 0.9em, breakable: false,
)[
  #line(length: 100%, stroke: 0.5pt + grid-c.lighten(20%))
  #v(4pt)
  #text(font: head-font, size: 12pt, fill: emerald.darken(10%))[A#n]
  #v(3pt)
  #text(size: 9.3pt)[#body]
]

// faint ruled writing space for printed worksheets
#let worklines(n) = block(above: 7pt, below: 2pt)[
  #for _ in range(n) [
    #line(length: 100%, stroke: 0.5pt + grid-c.lighten(15%))
    #v(13pt)
  ]
]
