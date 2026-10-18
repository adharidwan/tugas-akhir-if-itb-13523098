// Pratinjau Bab 2 tanpa halaman muka dan bab lain dari template.
#set document(title: "Draf Bab 2: Tinjauan Pustaka", author: "Muhammad Adha Ridwan")
#set page(
  paper: "a4",
  margin: (left: 4cm, top: 3cm, right: 3cm, bottom: 3cm),
  numbering: "1",
  number-align: center + bottom,
)
#set text(font: "Liberation Serif", size: 12pt, lang: "id")
#set par(justify: true, leading: 1.25em, first-line-indent: (amount: 1.25cm, all: true))
#set heading(numbering: (..nums) => {
  if nums.pos().len() == 1 {
    "BAB " + numbering("I", ..nums)
  } else {
    numbering("1.1", ..nums)
  }
})
#show heading.where(level: 1): it => {
  align(center)[
    #set par(first-line-indent: 0pt)
    #text(size: 14pt, weight: "bold")[
      #counter(heading).display(it.numbering)\
      #upper(it.body)
    ]
  ]
  v(1.5em)
}
#show heading.where(level: 2): set text(size: 12pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set figure(supplement: [Tabel])
#counter(heading).update(1)
#include "../../chapters/02-studi-literatur.typ"
