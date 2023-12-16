#let font_size = 11pt
#let theme_color = black

#let conf(doc) = {
  // Set page margins
  set page(paper: "a4", margin: (x: 1.1cm, y: 1.3cm))
  // Set base font
  set text(
    font: ("Source Sans 3", "Source Han Sans SC"),
    size: font_size,
    weight: "regular",
    lang: "zh",
    region: "CN",
    ligatures: false,
    number-type: "lining",
  )
  // Link color
  show link: set text(fill: theme_color)
  // Add a horizontal line under level 2 headings
  show heading.where(level: 2): it => text(fill: theme_color, [
    #{ it.body }
    #v(-7pt)
    #line(length: 100%, stroke: 1pt + theme_color)
  ])

  show heading.where(level: 1): it => block(width: 100%)[
    #set text(size: 1.5em, weight: "bold")
    #upper(it.body)
    #v(2pt)
  ]
  // Body style
  set par(justify: true)
  doc
}

// Icons
#let icon(path) = box(baseline: 0.2em, height: 1.25em, image(path))

// Contact information
#let contact_information(..it) = {
  set text(size: 1em, weight: "medium")
  it.pos().map(item => {
    box(baseline: 30%, {
      if "icon" in item {
        if (type(item.icon) == "string") {
          icon(item.icon)
        } else {
          item.icon
        }
      }
      h(0.2em)
      if "link" in item {
        link(item.link, item.content)
      } else {
        item.content
      }
    })
  }).join(h(1em) + "|" + h(1em))
}

//personal information
#let personal_information(contact_information, photograph)={
  // Contact information and photograph
  grid(
    columns: (auto, 1fr, auto),
    gutter: (auto, auto),
    contact_information,
    if (photograph != "") {
      align(end, image(photograph, width: 2.5cm, height: 3.75cm))
    },
  )
}

// Education background
#let education(school, major, degree, date_range) = {
  grid(
    columns: (1fr, 2%, auto, 15%, auto, 30%, auto),
    column-gutter: (0em),
    school,
    "",
    major,
    "",
    degree,
    "",
    align(right, text(gray, date_range)),
  )
}

// Work experience
#let work(company, job_name, date_range, job_content) = {
  grid(
    columns: (1fr, 2%, auto, 30%, auto),
    column-gutter: (0em),
    company,
    "",
    job_name,
    "",
    align(right, text(gray, date_range)),
  )
  { job_content }
}

// Project experience
#let project(project_name, date_range, technology, project_content, project_feature) = {
  grid(
    columns: (1fr, auto, auto),
    column-gutter: (0em),
    align(left, project_name),
    align(right, text(gray, date_range)),
  )
  { project_content }
  { project_feature }
}

// Technology
#let technology(..it) = {
  it.pos().map(item => {
    box(
      fill: luma(235),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
    )[item]
  }).join(" ")
}