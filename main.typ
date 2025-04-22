
#let titulo = "Template de Informe"
#let codigo-curso = "CC1234"

#let meta = (
  "Nombre del Estudiante": "Juanito Perez",
  "Email del Estudiante": "jperez@domain.net",
  "Teléfono del Estudiante": "+56 8 1234 5679",
)

#let marginline = line(length: 100%, stroke: 0.2mm + gray.darken(23%))

#let chapter = context {
  let loc = here()
  let headings-after-pos = query(selector(heading.where(level: 1)).after(loc))

  if headings-after-pos != () and headings-after-pos.first().location().page() == loc.page() {
    headings-after-pos.first().body

  } else {
    let headings-before-pos = query(selector(heading.where(level: 1)).before(loc))

    if headings-before-pos != () {
      headings-before-pos.last().body
    }
  }
}

#set text(lang: "es", region: "CL", font: "Times New Roman", size: 11pt, top-edge: 1em, bottom-edge: 0em)
#set par(justify: true, spacing: 1.2em, leading: 0.2em)

#set page(
  paper: "us-letter",
  margin: 2.5cm,
  numbering: "i",
  header: [
    #grid(
      columns: (auto, 1fr),
      rows: (auto, 1em),
      chapter,
      align(right, context counter(page).display()),

      grid.cell(colspan: 2, marginline)
    )
  ],
  footer: [
    #grid(
      columns: (1fr, 1fr),
      rows: (1em, auto),
      grid.cell(colspan: 2, marginline),

      titulo,
      align(right, codigo-curso)
    )
  ]
)

#counter(page).update(0)

#page(
  margin: (
    top: 1cm,
    bottom: 2cm,
  ),
  header: [],
  footer: []
)[
  #align(top, 
    box(height: 2.1cm,
      grid(
        columns: (auto, 1fr),
        rows: (1fr, auto),

        align(left + horizon, 
          box(height: 70%,
            stack(
              dir: ttb,
              spacing: 1fr,
              "Universidad de Chile",
              "Facultad de Ciencias Físicas y Matemáticas",
              "Departamento de Ciencias de la Computación"
            )
          )
        ),

        align(right + horizon, image(height: 90%, "dcc.svg")),

        grid.cell(colspan: 2, marginline)
      )
    )
  )

  #set align(horizon + center)
  #set par(spacing: 8mm, justify: false)
  #text(size: 14mm, titulo)

  #text(size: 10mm, codigo-curso)
  #align(bottom + right,
    stack(dir: ltr, {
      let parts = ()
      for (key, value) in meta {
        parts.push(key + ":  ")
        parts.push(align(left, value))
      }
      grid(columns: 2, gutter: 1.3mm, ..parts)
    })
  )
]

#heading(numbering: none, outlined: false, bookmarked: true, "Resumen")
// Aquí el resumen

#pagebreak()

#heading(numbering: none, outlined: false, bookmarked: true, "Índice")
#outline(title: none)

#set page(numbering: "1")
#counter(page).update(1)

#set heading(numbering: none, outlined: false, bookmarked: true)
#show heading.where(level: 1): set heading(numbering: "I.", outlined: true)
#show heading.where(level: 1): it => [
    #pagebreak()
    #it
]
#counter(heading).update(0)

= Desarrollo
// Resto del informe

= Bibliografía
#bibliography("biblio.yml", style: "ieee", title: none)

