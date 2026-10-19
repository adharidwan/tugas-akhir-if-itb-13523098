// Pratinjau Bab 2 tanpa halaman muka dan bab lain dari template.
#set document(title: "Draf Bab 2: Tinjauan Pustaka", author: "Muhammad Adha Ridwan")
#set page(
  paper: "a4",
  margin: (left: 4cm, top: 3cm, right: 3cm, bottom: 3cm),
  numbering: "1",
  number-align: center + bottom,
)
#set text(font: "Times New Roman", size: 12pt, lang: "id")
#set par(justify: true, leading: 1.25em, first-line-indent: (amount: 1.25cm, all: true))
#set heading(numbering: (..nums) => {
  if nums.pos().len() == 1 {
    "BAB " + numbering("I", ..nums)
  } else {
    numbering("I.1", ..nums)
  }
})
#show heading.where(level: 1): it => {
  align(center)[
    #set par(first-line-indent: 0pt)
    #text(size: 14pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display(it.numbering)
        linebreak()
      }
      #upper(it.body)
    ]
  ]
  v(1.5em)
}
#show heading.where(level: 2): set text(size: 12pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")
#show heading.where(level: 4): it => block(width: 100%, breakable: false, above: 1em, below: 0.6em)[
  #set par(first-line-indent: 0pt)
  #text(size: 12pt, weight: "bold")[
    #if it.numbering != none {
      counter(heading).display(it.numbering)
      [ ]
    }
    #it.body
  ]
]
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set figure(supplement: [Tabel])
#counter(heading).update(1)
#include "../../chapters/02-studi-literatur.typ"

#pagebreak()
#bibliography("../../references.bib", style: "../../reference/apa.csl", title: [DAFTAR PUSTAKA])
