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
  show heading.where(level: 2): it => text(fill: theme_color, size: 1.2em, weight: "medium", [
    #{ it.body }
    #v(-7pt)
    #line(length: 100%, stroke: 1pt + theme_color)
  ])

  show heading.where(level: 1): it => block(width: 100%)[
    #set text(size: 1.6em, weight: "medium")
    #it.body
    #v(2pt)
  ]
  // Body style
  set par(justify: true, leading: 0.9em)
  doc
}

// Icons
#let icon(path) = box(baseline: 0.3em, height: 1.25em, image(path))

// Contact information
#let contact_information(..it) = {
  set text(size: 1.2em, weight: "regular")
  it.pos().map(item => {
    box({
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
  }).join("\n")
}

//personal information
#let personal_information(name, contact_information, photograph)={
  // Contact information and photograph
  grid(columns: (auto, 1fr, auto), gutter: (auto, auto), {
    name
  } + contact_information, if (photograph != "") {
    align(top + end, image(photograph, width: 2.5cm, height: 3.75cm))
  })
}

// Education background
#let education(school, major, degree, date_range) = {
  set text(size: 1.1em)
  grid(
    columns: (1fr, 2%, auto, 15%, auto, 30%, auto),
    column-gutter: (0em),
    school,
    "",
    major,
    "",
    degree,
    "",
    align(right, text(gray, weight: "semibold", date_range)),
  )
}

// Work experience
#let work(company, job_name, date_range, job_content) = {
  {
    set text(size: 1.1em)
    grid(
      columns: (1fr, 2%, auto, 30%, auto),
      column-gutter: (0em),
      company,
      "",
      job_name,
      "",
      align(right, text(gray, weight: "semibold", date_range)),
    )
  }
  v(0.2em)
  { job_content }
}

// Project experience
#let project(project_name, date_range, technology, project_content, project_feature) = {
  {
    set text(size: 1.1em)
    grid(
      columns: (1fr, auto, auto),
      column-gutter: (0em),
      align(left, project_name),
      align(right, text(gray, weight: "semibold", date_range)),
    )
  }
  { technology }
  v(0.1em)
  { project_content }
  v(0.2em)
  { project_feature }
}

// Technology
#let technology(..it) = {
  set par(justify: false, leading: 1em)
  it.pos().map(item => {
    box(
      fill: luma(235),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      item,
    )
  }).join(" ")
}

#let certificate(body) = {
  set text(size: 1.1em)
  body
}

#let award(body) = {
  set text(size: 1.1em)
  body
}
