#import "@preview/fontawesome:0.6.0": *
#import "@preview/cades:0.3.1": qr-code

#let chip(body) = box(
  fill: black.lighten(40%),
  inset: (x: 5pt, y: 3pt),
  radius: 2pt,
  text(fill: white, size: 8.5pt, body),
)

// Label with the chips that belong to it, so a group stays one unit when it wraps.
#let skill-group(name, ..tags) = block(above: 8pt, below: 0pt)[
  #text(size: 9pt, weight: "bold", name)
  #v(1pt)
  #set par(leading: 0.6em)
  #tags.pos().map(chip).join(h(4pt))
]

#let side-title(title) = block(
  above: 15pt,
  below: 4pt,
  text(size: 11pt, weight: "bold", upper(title)),
)

// Inline link with a trailing up-right arrow; the whole thing is clickable and not underlined.
// The free Font Awesome set has no plain up-right arrow, so a right arrow is rotated.
#let icon-link(url, body) = {
  set underline(stroke: 0pt)
  link(url)[#body#h(0.1em)#box(
    width: 0.5em,
    height: 0.6em,
    move(dy: -0.3em, align(center + horizon, rotate(-45deg, fa-icon("arrow-right", solid: true, size: 0.5em)))),
  )]
}

#let contacts(..cells) = {
  set underline(stroke: 0pt)
  table(
    columns: (auto, 1fr),
    column-gutter: 6pt,
    row-gutter: 5pt,
    inset: 0pt,
    stroke: none,
    align: horizon,
    ..cells.pos(),
  )
}

// Title and dates on one row, organization underneath, description last.
#let entry(title, years: none, org: none, ..rest) = {
  let body = if rest.pos().len() > 0 { rest.pos().first() } else { none }
  block(above: 14pt, below: 4pt)[
    #grid(
      columns: (1fr, auto),
      column-gutter: 10pt,
      align: (left + top, right + top),
      text(weight: "bold", title),
      if years != none {
        text(fill: black.lighten(45%), size: 9pt, years)
      },
    )
    #if org != none [
      #v(2pt)
      #text(style: "italic", fill: black.lighten(35%), org)
    ]
    #if body != none [
      #v(4pt)
      #body
    ]
  ]
}

#let resume(
  name: "",
  about: [],
  accent-color: rgb("222"),
  aside: [],
  photo: "/picture.jpg",
  body,
) = {
  let margin = 16pt
  let header-height = 112pt
  let header-fill = rgb("111")
  let stripe = rgb("EE5522")

  set document(title: name, author: name)
  set page(
    margin: (bottom: 32pt, rest: 0pt),
    background: place(
      top + left,
      block(width: 100%, height: header-height)[
        #rect(fill: header-fill, width: 100%, height: header-height)
        #place(bottom, line(length: 100%, stroke: 2pt + stripe))
      ],
    ),
    footer: context {
      set text(size: 8pt, fill: black.lighten(35%))
      grid(
        columns: (2fr, 1fr, 2fr),
        inset: (x: margin, bottom: margin),
        link("https://github.com/vofy/cv-template")[Šablona: vofy/cv-template #fa-icon("github")],
        align(center, counter(page).display("1/1", both: true)),
        align(right)[Exportováno dne: #datetime.today().display("[day].[month].[year]")],
      )
    },
  )

  set text(font: "Liberation Serif", size: 10pt, lang: "cs")
  set par(justify: false, leading: 0.55em, spacing: 0.65em)
  set list(indent: 0.7em, body-indent: 0.35em)
  show link: underline

  show heading.where(level: 1): it => block(above: 20pt, below: 2pt)[
    #set text(size: 13pt, weight: "bold")
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: horizon,
      upper(it.body),
      line(length: 100%, stroke: 0.7pt + accent-color),
    )
  ]

  grid(
    columns: (7.4cm, 1fr),
    block[
      #square(
        width: 100%,
        stroke: none,
        inset: margin,
        image(photo),
      )
      #block(inset: (x: margin))[#aside]
    ],
    block(inset: (left: 4pt, right: margin))[
      #block(height: header-height, inset: (top: 16pt, bottom: 10pt))[
        #align(horizon)[
          #set text(fill: white)
          #text(size: 18pt, weight: "bold", upper(name))
          #v(5pt)
          #set par(leading: 0.45em)
          #text(size: 11pt, fill: rgb("eee"), about)
        ]
      ]
      #body
    ],
  )
}
