#import "../lib.typ": *
#import emoji: hands

#set page(paper: "a4", flipped: true, margin: 1cm)
#set text(font: "New Computer Modern", size: 11pt)
// #set text(font: "New Computer Modern Math", size: 11pt)

#let jstr(body: str) = { raw(body, lang: "Java") }
#let aenum(..body) = {
  enum(numbering: "(a)", ..body)
}

#show: cheatsheet.with(
  title: "MA2113",
  authors: "chuanhao01",
  write-title: true,
  font-size: 9pt,
  line-skip: 2pt,
  margin: (x: 0.4in, y: 0.4in),
  num-columns: 3,
  column-gutter: 4pt,
)
#set par(spacing: 5pt)

// #set math.equation(numbering: "(1)")


Probability reference sheet

= Permutations

#aenum[
  The number of permutations of $n "distinct objects"$ is $n!$
][
  The number of permutations of n distinct objects taken r at a time:
  $
    attach(P, bl: n, br: r) = n!/(n-r)!
  $
][
  The number of permutations of n distinct objects arranged in a #strong[circle]
  is $(n−1)!$. (Permutations that occur by arranging objects in a circle
  are called circular permutations.)
][
  The number of distinct permutations of n objects, of which $n_1 "are alike",
  n_2 "are alike", ..., n_k$ are alike, is:
  $
    binom(n, n_1, n_2, ..., n_k) = n! / (n_1! n_2! ... n_k!)
  $
  With $n = n_1 + n_2 + ... + n_k$
][
  The eqn above can also be used to parition n objects into k cells with each cell being size $n_k$
  In this case, all objects have to be distinct
]

= Combinations

#aenum[
  The number of combinations of n distinct objects taken k at a time is:
  $
    binom(n, k) = n! / (k!(n-k)!) = binom(n, n-k)
  $
  Also works for finding total number of subsets with k elements
][
  Binomial
  $
    (x + y)^n = sum_(k=0)^(n) binom(n, k) x^k y^(n-k)
  $
][
  From binomial or sum of all possible subsets of $|S| = n$, Powerset $|P(S)| = 2^n$
  $
    2^n = sum_(k=0)^n binom(n, k)
  $
][
  From binomial,
  $
    0 = sum_(k=0)^n (-1)^k binom(n, k)
  $
]

= Probability
Defining a probability space, $(S, cal(A), bb(P))$,
S = "sample space", $cal(A)$ = "Any possible event, any possible subset of S", $bb(P)$ "Probability Function"

Events written as $A_1 A_2 = A_1 inter A_2$

Axioms
#aenum[
]
