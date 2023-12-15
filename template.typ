// Font
#let font = (
  main: "Source Han Sans SC",
  mono: "Source Han Sans SC",
  cjk: "Source Han Sans SC",
)

// Icons
#let icon(path) = box(baseline: 0.125em, height: 1em, width: 1em, image(path))

// Resume
#let resume(
  // Base font size
  size: 8.5pt,
  // Title color
  themeColor: rgb(0, 0, 0),
  // Control paper margins
  top: 1cm,
  bottom: 1cm,
  left: 2cm,
  right: 2cm,
  // Profile photo
  photograph: "images/profile.jpg",
  photographWidth: 6em,
  photographHeight: 9em,
  gutterWidth: 0em,
  header,
  body,
) = {
  // Set page margins
  set page(
    paper: "a4",
    numbering: none,
    margin: (top: top, bottom: bottom, left: left, right: right),
  )

  // Set base font
  set text(font: (font.main, font.cjk), size: size, weight: "regular", lang: "zh")

  // Heading styles
  show heading.where(level: 1): set text(themeColor, 1.2em)
  show heading.where(level: 2): set text(themeColor, 0.9em)

  // Add a horizontal line under level 2 headings
  show heading.where(level: 2): it => stack(
    v(0em),
    it,
    v(0.25em),
    line(length: 100%, stroke: 0.05em + themeColor),
    v(0.05em),
  )

  // Change bullet list icons
  set list(tight: true)

  // Link color
  show link: set text(fill: themeColor)

  // Body style
  set par(justify: true)
  show par: set block(spacing: 0.5em)

  // Header and photograph
  grid(
    columns: (auto, 1fr, auto),
    gutter: (gutterWidth, 0em),
    header,
    if (photograph != "") {
      align(
        image(photograph, width: photographWidth, height: photographHeight),
        end,
      )
    },
  )

  body
}

// Personal information
#let info(color: black, ..infos) = {
  v(0.5em)
  set text(font: (font.mono, font.cjk), fill: color, size: 11pt)
  infos.pos().map(dir => {
    box({
      if "icon" in dir {
        if (type(dir.icon) == "string") {
          icon(dir.icon)
        } else {
          dir.icon
        }
      }
      h(0.2em)
      if "link" in dir {
        link(dir.link, dir.content)
      } else {
        dir.content
      }
    })
  }).join("\n")
}

// Education background
#let education(school, major, degree, dateRange) = {
  grid(
    columns: (1fr, 2%, auto, 15%, auto, 30%, auto),
    gutter: (0em),
    school,
    "",
    major,
    "",
    degree,
    "",
    align(dateRange, right),
  )
}

// Work experience
#let workExperience(company, jobTitle, dateRange) = {
  grid(
    columns: (1fr, 2%, auto, 30%, auto),
    gutter: (0em),
    company,
    "",
    jobTitle,
    "",
    align(dateRange, right),
  )
}

// Project experience
#let projectExperience(projectName, dateRange) = {
  grid(
    columns: (1fr, auto, auto),
    gutter: (0em),
    align(left, projectName),
    align(right, dateRange),
  )
}

// Technology names
#let technologyNames(bodies) = {
  let cell = rect.with(
    radius: 5pt,
    inset: (top: 4pt, bottom: 4pt, left: 5pt, right: 5pt),
    fill: rgb(243, 244, 244),
  )
  let boxes = for body in bodies {
    (box(cell(body)),)
  }
  { boxes.join(" ") }
}