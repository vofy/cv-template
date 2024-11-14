#import "@preview/fontawesome:0.5.0": *
#import "@preview/cades:0.3.0": qr-code
#import "@preview/wrap-it:0.1.0": wrap-content

#let version = "1.3"
#let lang = "en"

#let entry(title, body, details) = [
  #heading(level: 2, title)
  #block(inset: (right: 2em), body)
  #block(above: 0.7em, text(fill: gray, details))
]

#let __(cs, en) = [
  #if lang == "cs" {eval(cs, mode: "markup")} else {eval(en, mode: "markup")}
]

#let chip(body) = [
  #box(
    inset: 2pt,
    box(fill: black.lighten(40%), radius: 2pt, inset: 2pt, outset: 2pt, text(white, body))
  )
]

#let years(body) = [
  #text(black.lighten(50%), "[" + body + "]")
]

#let resume(name: "", about: "", accent-color: rgb("111"), aside: [], body) = {
  let margin = 16pt
  let header_height = 125pt
  set page(
    margin: (bottom: 32pt, rest: 0pt), 
    background: place(top + left, rect(fill: accent-color, width: 100%, height: header_height)),
    footer: context [
      #grid(
        columns: (2fr, 1fr, 2fr),
        inset: (left: margin, right: margin, bottom: margin),
        link("https://github.com/vofy/cv-template")[Template: vofy/cv-template-#text(version) #fa-icon("github")],
        align(center, counter(page).display(
          "1/1",
          both: true,
        )),
        align(right, [Version: #datetime.today().display("[day].[month].[year]") | #if lang == "cs" {lang} else {"en"}])
      )
    ]
  )
  set text(font: "Noto Sans", size: 10pt)
  set block(above: 0pt, below: 0pt)
  set par(justify: true)

  grid(
    columns: (2fr, 5fr),
    block(
      {
        square(
          stroke: none,
          width: 100%,
          inset: (bottom: 0pt,rest: 16pt),
          image("/picture.jpg")
        )
        set block(inset: (left: margin, right: margin))
        show heading: it => align(left, upper(it))
        set list(marker: "")
        show list: it => {
          set par(justify: false, linebreaks: "optimized")
          set text(size: 10pt)
          align(left, it)
        }
        aside
      }
    ),
    block(width: 100%, {
      align(horizon, box(
        height: header_height,
        inset: (top: 16pt, right: 16pt),
        {
          show heading.where(level: 1): set text(size: 18pt, fill: rgb("fff"))
          show heading.where(level: 2): set text(size: 10pt, fill: rgb("fff"), weight: "regular")
              
          heading(level: 1, upper(name))
          heading(level: 2, about)
        }
      ))
      box(
        inset: (right: 16pt),
        {
        set block(above: 8pt)
        show heading.where(level: 1): it => context {
          let h = text(size: 16pt, upper(it))
          let dim = measure(h)
          stack(
            dir: ltr,
            h,
            place(
              dy: 7pt,
              dx: 10pt,
              horizon + left,
              line(stroke: accent-color, length: 100% - dim.width - 10pt)
            ),
          )
        }
        body
      })
    })
  )
}
