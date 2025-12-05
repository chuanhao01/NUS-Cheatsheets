#import "../lib.typ": *
#import emoji: hands

#set page(paper: "a4", flipped: true, margin: 1cm)
#set text(font: "New Computer Modern", size: 11pt)
// #set text(font: "New Computer Modern Math", size: 11pt)

#let jstr(body: str) = { raw(body, lang: "Java") }

#show: cheatsheet.with(
  title: "MA2113",
  authors: "chuanhao01",
  write-title: true,
  font-size: 7pt,
  line-skip: 1.5pt,
  margin: (x: 0.4in, y: 0.4in),
  num-columns: 4,
  column-gutter: 4pt,
)

Probability and Math reference sheet

= Permutations

(a) The number of permutations of $n "distinct objects"$ is $n!$

(b) The number of permutations of n distinct objects taken r at a time:
$
  attach(P, bl: n, br: r) = n!/(n-r)!
$

(c) The number of permutations of n distinct objects arranged in a #strong[circle]
is $(n−1)!$. (Permutations that occur by arranging objects in a circle
are called circular permutations.)
