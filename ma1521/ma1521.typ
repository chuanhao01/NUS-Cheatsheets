#set page(paper: "a4", margin: 1cm)
#set text(font: "New Computer Modern", size: 11pt)

= Chapter 6 Sequences and Series

Usually, $n in ZZ^+$\
AP, with common difference: $d in RR$, starting term, $a in RR$\
$a_n = a + (n-1)d$\

GP, with ratio, $r in RR$, starting term, $a in RR$\
$a_n = a r^(n-1)$


#strong[Theorem 6.2.]
(Squeeze Theorem)
If $a_n <= b_n <= c_n$ for all $n$
and $limits(lim)_(n->infinity) a_n = limits(lim)_(n->infinity) b_n = limits(lim)_(n->infinity) c_n = L$
then $limits(lim)_(n->infinity) b_n = L$

== Series

If the series #emph[converges], you can find the limit $S_n = limits(sum)_(k=1)^n a_k$

$
sum_(n=1)^infinity a_n = limits(lim)_(n->infinity) S_n
$

GS:
$
sum_(n=1)^infinity a r^(n-1) = a / (1-r), (a eq.not 0)
$
when $|r| < 1$

== Convergence

#let an-series = {
    $limits(sum)_(n=1)^infinity a_n$
}
#let bn-series = {
    $limits(sum)_(n=1)^infinity b_n$
}

If $limits(sum)_(n=1)^infinity |a_n|$ is convergent, then #an-series is absolutely convergent.

If #an-series is convergent and $limits(sum)_(n=1)^infinity |a_n|$ is not convergent then it is conditional convergent.

== Tests

#strong[$n$#super[th]] term test for divergence\
If $limits(lim)_(n->infinity) a_n$ does not exists or if $limits(lim)_(n->infinity) a_n eq.not 0$ then the series $limits(sum)_(n=1)^infinity a_n$ is divergent\
Do not use this test for convergence

#strong[Partial Upper Bound]\
If series #an-series for $a_n >= 0$ converges iff its partial sums are bounded from above.\
I.e. $exists K, S_n < K, forall n$

#strong[Integral Test]

For $f(n) = a_n, #" " integral_1^infinity f(x) d x$\
If its convergent, then #an-series is also convergent\
If its divergent, then #an-series is also divergent

#strong[p-series]

$limits(sum)_(n=1)^infinity 1/n^p$ is convergent iff $p>1$

#strong[Comparison Test]

If #an-series and #bn-series with $0<=a_n<=b_n, forall n$\ \
If #bn-series is convergent then #an-series is convergent\ \
If #an-series is divergent then #bn-series is divergent

#strong[Ratio and Root Test]

For #an-series, s.t. $limits(lim)_(n->infinity) |a_(n+1)/a_n| = L$ $limits(lim)_(n->infinity) root(n, |a_n|) = R$

(i) If $0 <= L,R < 1$, then #an-series is #strong[absolutely convergent]\
(ii) If $L,R > 1$ then #an-series is divergent\
(iii) If $L,R = 1$ then the tests are inconclusive

#strong[Alternating Series Test]

(i) $b_n >= 0$\
(ii) $b_n$ is decreasing $b_n >= b_(n+1) forall n$\
(iii) $limits(lim)_(n -> infinity) b_n = 0$

Then the series,\

$limits(sum)_(n=1)^infinity (-1)^(n-1) b_n = b_1 - b_2 + b_3 - b_4 + ... $\

$limits(sum)_(n=1)^infinity (-1)^(n) b_n = -b_1 + b_2 - b_3 + b_4 - ... $\

are convergent

== Power Series

#let cn-series = {
   $limits(sum)_(n=0)^infinity c_n (x-a)^n$
}

Consider, #cn-series, where $c_n eq.not 0, forall n$

If $limits(lim)_(n->infinity) |c_(n+1)/c_n| = L$ or $limits(lim)_(n->infinity) root(n, |c_n|) = L$, then $R = 1/L$\
If $L = 0 -> R = infinity$ and $L = infinity -> R = 0$\
L is the #strong[radius of convergence].


#strong[Differentiable]\
If $f(x) = #cn-series$ is differentiable on $|x-a| < R$ then

(i) $f'(x) = limits(sum)_(n=1)^infinity n c_n (x-a)^(n-1)$ for $|x-a| < R$\ \
(ii) $integral f(x) d x = limits(sum)_(n=1)^infinity c_n (x-a)^(n+1) / (n+1) + C$ for $|x-a| < R$

= Chatper 7 Vectors

== Definitions

3D Vector can be written as:

$
    angle.l x_0, y_0, z_0 angle.r + t angle.l a, b, c angle.r\
    vec(x_0, y_0, z_0) + t vec(a, b, c)\
    bold(r)(t) = r_0 + vec(f(t), g(t), h(t))
    "where"
    r_0 = vec(x_0, y_0, z_0), vec(f(t) = a t, g(t) = b t, h(t) = c t, delim: #none)
$


= Chapter 8 Partial Differentiation

== For One Variable functions

This mainly deals with functions mapping from Domain $D subset.eq RR$ to Range $R subset.eq RR^3$ such as:

#let rt_func = {
  $
    bold(r)(t) = vec(f(t), g(t), h(t))
  $
}

#rt_func

To find partial derivatives at $t = a$
$
  bold(r)'(a) = vec(f'(a), g'(a), h'(a))
$

Rules
$
  "Given" bold(r)(t) "and" bold(s)(t) "are single variable vector functions, " f(t) "is a normal function" \
  "(i)" d / (d t) f(t)bold(r)(t) = f'(t)bold(r)(t) + f(t)bold(r)'(t)\
  "(ii)" d / (d t) bold(r)(t) dot bold(s)(t) = bold(r)'(t) dot bold(s)(t) + bold(r)(t) dot bold(s)'(t)\
  "(iii)" d / (d t) bold(r)(t) times bold(s)(t) = bold(r)'(t) times bold(s)(t) + bold(r)(t) times bold(s)'(t)
$

=== Arc Length
$
  "Given the curve" C\
  #rt_func , a<= t <= b\
  s = integral^a_b sqrt(f'(t)^2 + g'(t)^2+ h'(t) ^ 2) d t
$

== Multi Variable Functions

Let $f(x, y)$ be the function we are studying, then
$
  f_x (x, y) = (diff f(x, y)) / (diff x)\
  f_y (x, y) = (diff f(x, y)) / (diff y)
$
and 2nd Order differentials
$
  (f_x (x, y))_x = f_(x x) (x, y)
  = (diff f_x (x, y)) / (diff x)
  = (diff (diff f(x, y)) / (diff x)) / (diff x)  \

  (f_x (x, y))_y = f_(x y) (x, y)
  = (diff f_x (x, y)) / (diff y)
  = (diff (diff f(x, y)) / (diff x)) / (diff y)  \

  (f_y (x, y))_x = f_(y x) (x, y)
  = (diff f_y (x, y)) / (diff x)
  = (diff (diff f(x, y)) / (diff y)) / (diff x)  \
$

=== 2nd Order differentials (Clairaut's Theorem)

$
  f_(x y) (x, y) = f_(y x) (x, y)
$

=== Equation of Tangent Plane

Given the surface with a function like $z = f(x, y)$ with point $P(a, b, c)$ at $c = f(a, b)$

The normal vector of the plane is given by,
$
  arrow(n) = vec(f_x (a, b), f_y (a, b), -1)
$

The equation of the plane is given by,
$
  arrow(n) dot vec(x, y, z) = arrow(n) dot vec(a, b, f(a, b) = c) \
  vec(f_x (a, b), f_y (a, b), -1) dot vec(x, y, z) = vec(f_x (a, b), f_y (a, b), -1) dot vec(a, b, f(a, b) = c)
$

== Parametric Multi-Variable Functions

=== Chain Rule

Given $z = f(x, y)$ and $x = g(t)$ and $y = h(t)$ then,
$
  (d z) / (d t) = (diff f) / (diff x) (d x) / (d t) + (diff f) / (diff y) (d y) / (d t) \
  (d z) / (d t) = f_x (d x) / (d t) + f_y (d y) / (d t)
$
