#import "template.typ": *

#show: doc.with(
  title: "MA201A — Ch. 12 Study Guide · Lecture 1",
  subtitle: "§12.5 Lines in Space · §12.6 Cylinders & Quadric Surfaces — Stewart 9e · Fall 2026",
)

= 1 · Recap & Visual Intuition

== Cylinders: the missing-variable rule

#split(
  [
    #definition[
      A *cylinder* is a surface made of all lines (*rulings*) parallel to a given
      line, passing through a given plane curve. It does *not* have to be circular —
      it is any 2D curve extruded through space.
    ]
    #keytip[
      *Missing-variable rule* — if an equation in $RR^3$ lacks one coordinate,
      graph the curve in the plane of the two variables present, then extrude it
      infinitely along the missing axis, through all 8 octants.
    ]
    #hl[Circular:] $x^2+y^2=r^2$ → circle in $x y$-plane, rulings $parallel z$ #linebreak()
    #hl[Elliptic:] $x^2/a^2+y^2/b^2=1$, #hl(color: coral)[$a≠b$] → ellipse, not a circle #linebreak()
    #hl[Parabolic:] $z=y^2$ → parabola in $y z$-plane, extruded along $x$
  ],
  fig("figs/parabolic_cylinder.png", caption: [$z=y^2$: a parabola in the $y z$-plane dragged straight out along $x$. Nothing constrains $x$, so it runs forever.]),
)

== 2D → 3D: parameterization carries order, direction, and speed

Segment from $(0,1)$ to $(1,0)$ lies on $y=1-x$. Let $x(t)=t space⇒ space y(t)=1-t$:
$ arrow(r)(t) = ⟨ t, 1-t ⟩, quad t∈[0,1] $

#split(
  [
    #align(center)[
      #table(
        columns: 4,
        stroke: 0.6pt + grid-c,
        fill: (x, y) => if y == 0 { teal-l } else { white },
        inset: (x: 7pt, y: 5pt),
        align: center + horizon,
        [*$t$*], [*$(x,y)$*], [*$arrow(r)(t)$*], [*travel*],
        [$0$], [$(0,1)$], [$⟨0,1⟩$], [start],
        [$1/4$], [$(1/4,3/4)$], [$⟨1/4,3/4⟩$], [↓],
        [$1/2$], [$(1/2,1/2)$], [$⟨1/2,1/2⟩$], [↓],
        [$3/4$], [$(3/4,1/4)$], [$⟨3/4,1/4⟩$], [↓],
        [$1$], [$(1,0)$], [$⟨1,0⟩$], [end],
      )
    ]
  ],
  keytip(title: "Why the table matters")[
    The *set* of points is just the segment — but the parameterization also fixes
    *which end you start at*, *which way you travel*, and *how fast*. Equal steps in
    $t$ give equal steps in space here, so the speed is constant.
    #v(3pt)
    Direction vector $arrow(v)=⟨1,-1⟩$; base point $(0,1)$.
    For the *full infinite line*, let $t∈RR$ instead of $[0,1]$.
  ],
)

== Lines in $RR^3$

A line $L$ needs exactly two things: a *base point* $P_0(x_0,y_0,z_0)$ and a
*nonzero direction vector* $arrow(v)=⟨a,b,c⟩ parallel L$. The components $a,b,c$ are the
*direction numbers*.

#split(
  [
    #definition(title: "Vector equation")[
      $ arrow(r)(t)=arrow(r)_0+t arrow(v) = ⟨ x_0+a t, y_0+b t, z_0+c t ⟩ $
    ]
    #definition(title: "Parametric equations")[
      $ x=x_0+a t, quad y=y_0+b t, quad z=z_0+c t $
    ]
    #definition(title: "Symmetric equations")[
      (eliminate $t$ — requires $a,b,c≠0$)
      $ (x-x_0)/a=(y-y_0)/b=(z-z_0)/c $
    ]
    #definition(title: "Segment " + $P_0 → P_1$)[
      $ arrow(r)(t)=(1-t) arrow(r)_0+t arrow(r)_1, quad 0≤t≤1 $
    ]
  ],
  fig("figs/line_3d.png", caption: [Line through $P_0(-1,-4,-4)$ and $P_1(2,0,-3)$, direction $arrow(v)=⟨3,4,1⟩$ — worked in full in §4.]),
)

#refs([📖 Stewart 9e §12.5 · §12.6], [📖 Paul's Online Notes — Lines / Quadric Surfaces], [▶ Prof. Leonard — Calc 3, 12.5–12.6])

= 2 · Classification Cheat-Sheet

#keytip[
  General second-degree form:
  $A x^2+B y^2+C z^2+D x y+E y z+F x z+G x+H y+I z+J=0$.
  Fast ID on a timed question: *count the minus signs*, check the *right-hand side*
  ($=1$ vs $=0$), and look for an *isolated linear variable*.
]

#matrix(
  ([Algebraic signature], [Surface], [Axis / opening], [Horizontal traces], [Vertical traces]),
  [All $+$, $= 1$], [Ellipsoid], [bounded — no axis], [ellipses], [ellipses],
  [Exactly one $-$, $= 1$], [Hyperboloid, 1 sheet], [the *negative* variable], [ellipses], [hyperbolas],
  [Exactly two $-$, $= 1$], [Hyperboloid, 2 sheets], [the *positive* variable], [ellipses ($|z|≥c$)], [hyperbolas],
  [All degree 2, $= 0$], [Elliptic cone], [the *isolated* variable], [ellipses], [hyperbolas / lines],
  [One *linear* var, other two *same* sign], [Elliptic paraboloid], [opens along linear var], [ellipses], [parabolas],
  [One *linear* var, other two *opposite* sign], [Hyperbolic paraboloid], [saddle at origin], [hyperbolas], [parabolas],
  [A variable is *missing*], [Cylinder], [rulings $parallel$ missing axis], [the 2D curve], [lines],
)

#v(4pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 8pt,
  qcard("Ellipsoid", $ x^2/a^2+y^2/b^2+z^2/c^2=1 $, "figs/ellipsoid.png",
    [Closed, bounded. Every trace an ellipse. $a=b=c ⇒$ *sphere*.]),
  qcard("Elliptic Cone", $ z^2/c^2=x^2/a^2+y^2/b^2 $, "figs/cone.png",
    [Two lobes, apex-to-apex. RHS $=0$ is the giveaway.]),
  qcard("Elliptic Paraboloid", $ z/c=x^2/a^2+y^2/b^2 $, "figs/elliptic_paraboloid.png",
    [Bowl — up if $c>0$, down if $c<0$.]),
  qcard("Hyperbolic Paraboloid", $ z/c=x^2/a^2-y^2/b^2 $, "figs/hyp_paraboloid.png",
    [Saddle. Min one way, max the other.]),
  qcard("Hyperboloid — 1 Sheet", $ x^2/a^2+y^2/b^2-z^2/c^2=1 $, "figs/hyperboloid_1sheet.png",
    [Connected hourglass. #hl(color:teal)[One] minus.]),
  qcard("Hyperboloid — 2 Sheets", $ -x^2/a^2-y^2/b^2+z^2/c^2=1 $, "figs/hyperboloid_2sheet.png",
    [Two lobes apart. #hl(color:coral)[Two] minuses.]),
)

== Building a saddle from its traces: $z = x^2-y^2$

#fig("figs/saddle_traces.png", caption: [Slicing by constant $x$ (downward parabolas), constant $y$ (upward parabolas), constant $z$ (hyperbolas, crossing lines at $k=0$).])

#example(title: "Synthesis")[
  $x=k ⇒ z=k^2-y^2$ (down) · $y=k ⇒ z=x^2-k^2$ (up) · $z=k ⇒ k=x^2-y^2$ (hyperbolas).
  Upward curvature along $x$ + downward curvature along $y$ = the saddle.
]

= 3 · Assessment Traps & Lab Hints

#quizalert(title: "iClicker Alert — dimension ambiguity")[
  $x^2+y^2=1$ is a *circle* in $RR^2$ but a *circular cylinder* in $RR^3$.
  Always check which space the question is posed in before answering. Same trap:
  $y=x^2$ is a parabola in $RR^2$, a parabolic cylinder in $RR^3$.
]

#quizalert(title: "iClicker Alert — zero direction number")[
  Symmetric form breaks when a direction number is $0$ — you cannot divide by zero.
  If $c=0$, drop that fraction and state the constant coordinate on its own:
  $ (x-x_0)/a=(y-y_0)/b, quad z=z_0 $
  Geometrically the line lies in the plane $z=z_0$. Worked in full at *P2* below.
]

#quizalert(title: "iClicker Alert — cone vs. hyperboloid")[
  $x^2+y^2-z^2 = #h(2pt) underline(#h(10pt))$ — the right-hand side decides everything:
  $=0$ → *cone*; $=1$ → *hyperboloid of one sheet*; $=-1$ → *hyperboloid of two sheets*.
  Identical left sides, three different surfaces.
]

#assignalert(title: "Assignment 1 — Wed Sept 23, N1044")[
  Multi-step vector work is marked on *shown work*, not just the final line:
  - Compute $arrow(v) = arrow(P_0 P_1)$ *explicitly* before writing any equation.
  - State the parameter domain every time — $t∈RR$ for a line, $0≤t≤1$ for a segment.
  - For shifted quadrics, show each *completing-the-square* step; the centre/vertex is
    usually worth its own mark.
  - Verify a segment formula by checking $t=0$ gives $P_0$ and $t=1$ gives $P_1$.
]

#mapletip(title: "Maple Lab — Thurs Sept 24, LH3068")[
  Load the plotting package once per worksheet, then:
  #code("with(plots):
# a line segment (parametric, restricted domain)
spacecurve([-1+3*t, -4+4*t, -4+t], t=0..1, thickness=3, color=red);
# an implicit quadric
implicitplot3d(x^2/4 + y^2/9 + z^2 = 1, x=-3..3, y=-4..4, z=-2..2);
# an explicit surface z = f(x,y)
plot3d(x^2 - y^2, x=-2..2, y=-2..2, style=patchcontour);")
  *Curve of intersection* — solve for the shared constraint, then parameterize it.
  E.g. $z=x^2+y^2$ meets $z=4$ on the circle $x^2+y^2=4$, so $x=2cos t$, $y=2 sin t$, $z=4$:
  #code("spacecurve([2*cos(t), 2*sin(t), 4], t=0..2*Pi, thickness=3);
display([surface, curve], scaling=constrained);")
  Two habits that save marks: pick ranges that actually *contain* the interesting
  region, and add `scaling=constrained` so a sphere doesn't render as an ellipsoid.
]

= 4 · Fully Worked Problems

#example(title: [P1 · Line through two points — $P_0(-1,-4,-4)$, $P_1(2,0,-3)$])[
  *1. Direction vector.*
  $ arrow(v) = arrow(P_0 P_1) = ⟨ 2-(-1), 0-(-4), -3-(-4) ⟩ = ⟨ 3,4,1 ⟩ $
  *2. Parametric equations* (base $P_0$, $t∈RR$):
  $ x(t)=-1+3t, quad y(t)=-4+4t, quad z(t)=-4+t $
  *3. Symmetric equations* (all direction numbers nonzero, so all three fractions survive):
  $ (x+1)/3=(y+4)/4=(z+4)/1 $
  *4. Segment form* via $arrow(r)(t)=(1-t)arrow(r)_0+t arrow(r)_1$, $0≤t≤1$:
  $ x=(1-t)(-1)+t(2)=-1+3t, quad y=(1-t)(-4)+t(0)=-4+4t, quad z=(1-t)(-4)+t(-3)=-4+t $
  $ arrow(r)(t)=⟨ -1+3t, -4+4t, -4+t ⟩ $
  Same components as the infinite line — only the *domain* differs. Check: $t=0→P_0$, $t=1→P_1$. ✓
]

#split(
  [
    #example(title: [P2 · Zero direction number])[
      $L$ through $P_0(3,-2,5)$ with $arrow(v)=⟨4,0,-7⟩$.

      *Parametric:*
      $ x=3+4t, quad y=-2, quad z=5-7t $
      $y$ is *constant* — the middle direction number is $0$, so $y$ never changes.

      *Symmetric:* $b=0$, so the $y$-fraction is illegal. Use the two valid fractions and
      state $y$ separately:
      $ (x-3)/4=(z-5)/(-7), quad y=-2 $
      The line lives entirely in the plane $y=-2$.

      *Segment to $P_1(7,-2,-2)$:* check $P_1=P_0+1 dot arrow(v)$ ✓, so
      $ arrow(r)(t)=⟨ 3+4t, -2, 5-7t ⟩, quad 0≤t≤1 $
    ]
  ],
  fig("figs/line_zero_dir.png", caption: [Because $b=0$, the whole line is trapped in the plane $y=-2$ (shaded).]),
)

#split(
  [
    #example(title: [P3 · Completing the square])[
      Classify $ x^2-y^2+4z^2-2x-4y+8z+1=0 $

      *Group and complete each square:*
      $ x^2-2x = (x-1)^2-1 $
      $ -y^2-4y = -(y^2+4y) = -[(y+2)^2-4] = -(y+2)^2+4 $
      $ 4z^2+8z = 4(z^2+2z) = 4[(z+1)^2-1] = 4(z+1)^2-4 $

      *Substitute back:*
      $ (x-1)^2-1-(y+2)^2+4+4(z+1)^2-4+1=0 $
      Constants: $-1+4-4+1=0$, so they cancel exactly:
      $ (x-1)^2-(y+2)^2+4(z+1)^2=0 $

      *Identify.* Right-hand side is $0$ with all terms degree 2 → *elliptic cone*.
      Isolating the negative variable makes the axis obvious:
      $ (y+2)^2=(x-1)^2+4(z+1)^2 $
      Axis $parallel$ the $y$-axis; *vertex* at $(1,-2,-1)$.
    ]
  ],
  fig("figs/cone_shifted.png", caption: [The shifted cone. Translation moves the vertex off the origin but never changes the *type*.]),
)

#example(title: [P4 · Full trace analysis — $z/2 = y^2/4 - x^2/9$])[
  #matrix(
    ([Slice], [Trace equation], [Curve], [Reading]),
    [$x=0$ (in $y z$)], [$z=y^2/2$], [upward parabola], [along $y$, origin is a *minimum*],
    [$y=0$ (in $x z$)], [$z=-2x^2/9$], [downward parabola], [along $x$, origin is a *maximum*],
    [$z=2$ (∥ $x y$)], [$y^2/4-x^2/9=1$], [hyperbola, opens along $y$], [above the saddle],
    [$z=-2$ (∥ $x y$)], [$x^2/9-y^2/4=1$], [hyperbola, opens along $x$], [below — axis flips],
    [$z=0$ (in $x y$)], [$y=±(2/3)x$], [two crossing lines], [the degenerate level],
  )
  #v(4pt)
  #fig("figs/traces_hp.png", caption: [Min along $y$, max along $x$, and the level curves flipping axis as $z$ crosses $0$.])
  #v(7pt)
  *Behaviour at the origin:* a *saddle point* — a minimum in one direction and a maximum
  in the perpendicular one, so it is neither a local max nor a local min. The surface is a
  *hyperbolic paraboloid* opening along $z$.
]

#refs([📖 Stewart 9e §12.5 #1–5, 13, 17, 23–39, 45, 51–57], [📖 Stewart 9e §12.6 #1–7, 23–30, 41, 43, 55])

= 5 · Test Yourself

#question(1)[
  A line passes through $A(2,-1,6)$ and $B(2,5,-3)$.
  #v(2pt)
  *(a)* Find $arrow(v)$ and the parametric equations. #h(1fr)
  *(b)* Write the symmetric equations — watch for a zero. #linebreak()
  *(c)* Give the vector equation of segment $A→B$ and verify both endpoints.
  #worklines(5)
]

#question(2)[
  Identify each surface and state its axis (or opening direction):
  #v(2pt)
  *(a)* $9x^2-y^2+4z^2=1$ #h(1fr)
  *(b)* $x=2y^2+3z^2$ #h(1fr)
  *(c)* $4x^2+y^2-z^2=0$ #h(1fr)
  *(d)* $z=x^2-4y^2$
  #worklines(4)
]

#question(3)[
  Consider $x^2+4y^2-6x+8y-z+9=0$.
  #v(2pt)
  *(a)* Complete the square and write it in standard form. #linebreak()
  *(b)* Name the surface and give its vertex. #linebreak()
  *(c)* Write the Maple command that would plot it over a sensible window.
  #worklines(6)
]

#pagebreak()

#block(width: 100%, fill: emerald-l, stroke: (left: 3pt + emerald), radius: 3pt, inset: 10pt)[
  #text(font: head-font, size: 15pt, fill: emerald.darken(15%))[🔑 Answer Key]
  #v(1pt)
  #text(size: 8.6pt, style: "italic", fill: ink.lighten(25%))[Attempt all three before reading. Skip printing this page for a clean practice copy.]
]

#answer(1)[
  *(a)* $arrow(v)=arrow(A B)=⟨0,6,-9⟩$. Parametric: $x=2$, $y=-1+6t$, $z=6-9t$, $t∈RR$.
  #linebreak()
  *(b)* $a=0$, so the $x$-fraction is illegal:
  $ (y+1)/6=(z-6)/(-9), quad x=2 $
  The line lies in the plane $x=2$. (Simplifying by $3$: $(y+1)/2=(z-6)/(-3)$ is equally valid.)
  #linebreak()
  *(c)* $arrow(r)(t)=(1-t)⟨2,-1,6⟩+t⟨2,5,-3⟩=⟨2, -1+6t, 6-9t⟩$, $0≤t≤1$.
  Check $t=0→(2,-1,6)=A$ ✓, $t=1→(2,5,-3)=B$ ✓.
]

#answer(2)[
  *(a)* One minus sign, RHS $=1$ → *hyperboloid of one sheet*, axis $= y$ (the negative variable).
  #linebreak()
  *(b)* $x$ is the isolated *linear* variable, other two coefficients share a sign →
  *elliptic paraboloid*, opening along $+x$.
  #linebreak()
  *(c)* All degree 2, RHS $=0$ → *elliptic cone*, axis $= z$ (the isolated negative variable).
  #linebreak()
  *(d)* $z$ linear, $x^2$ and $y^2$ *opposite* signs → *hyperbolic paraboloid* (saddle), opening along $z$.
]

#answer(3)[
  *(a)* Only $x$ and $y$ are quadratic; $z$ stays linear.
  $ x^2-6x=(x-3)^2-9, quad 4y^2+8y=4(y+1)^2-4 $
  $ (x-3)^2-9+4(y+1)^2-4-z+9=0 space⇒space (x-3)^2+4(y+1)^2-4=z $
  $ z+4=(x-3)^2+4(y+1)^2 $
  #linebreak()
  *(b)* *Elliptic paraboloid*, opening along $+z$, with vertex $(3,-1,-4)$.
  #linebreak()
  *(c)* Solve for $z$ and centre the window on the vertex:
  #code("with(plots):
plot3d((x-3)^2 + 4*(y+1)^2 - 4, x=0..6, y=-4..2, style=patchcontour, axes=boxed);")
]
