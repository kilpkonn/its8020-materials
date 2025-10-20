#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus

#import "@preview/colorful-boxes:1.4.3": *

#let project(
  body,
) = {
  show: metropolis.setup

  // Make the paper dimensions fit for a presentation and the text larger
  set page(paper: "presentation-16-9")
  set text(size: 25pt)
  set text(font: "Inria Sans")

  show link: it => {
    set text(blue)
    if type(it.dest) != str {
      it
    }
    else {
      underline(it)
    }
  }

  body
}

  #let note(body) = outline-colorbox(
    title: "Note",
    radius: 5pt,
    color: "blue",
    width: 100%,
  )[
    #body
  ]
