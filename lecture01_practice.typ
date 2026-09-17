#import "template.typ": *

#show: doc.with(
  title: "MA201A — Lecture 01 Practice & Homework",
  subtitle: "Stewart 9e §12.5 & §12.6 · Fully Worked Solutions & Active-Recall Worksheet",
)

= 1 · Fully Worked Exam & Homework Problems

#grid(
  columns: (1.1fr, 0.9fr),
  gutter: 10pt,
  [
    #example(title: [P1 · Line through Two Points: $P_0(-1,-4,-4)$ and $P_1(2,0,-3)$])[
      *1. Direction Vector:*
      $ arrow(v) = arrow(P_0 P_1) = ⟨ 2-(-1), 0-(-4), -3-(-4) ⟩ = ⟨ 3,4,1 ⟩ $
      *2. Parametric Equations* (base $P_0$, $t∈RR$):
      $ x(t)=-1+3t, quad y(t)=-4+4t, quad z(t)=-4+t $
      *3. Symmetric Equations* (all direction numbers $a,b,c ≠ 0$):
      $ (x+1)/3 = (y+4)/4 = (z+4)/1 $
      *4. Segment Equation:*
      $ arrow(r)(t) = (1-t)arrow(r)_0 + t arrow(r)_1 = ⟨ -1+3t, -4+4t, -4+t ⟩, quad 0 ≤ t ≤ 1 $
      *Verification:* $t=0 ⇒ P_0(-1,-4,-4)$ ✓, $t=1 ⇒ P_1(2,0,-3)$ ✓.
    ]
  ],
  [
    #example(title: [P2 · Line with a Zero Direction Component])[
      Find equations of the line through $P_0(3,-2,5)$ with $arrow(v)=⟨4,0,-7⟩$.

      *Parametric:* $x=3+4t, quad y=-2, quad z=5-7t$ ($t∈RR$). \
      Since $b=0$, $y$ is strictly constant across the entire line.

      *Symmetric Form:* Division by zero is forbidden, so state the valid fractions and isolate $y$:
      $ (x-3)/4 = (z-5)/(-7), quad y=-2 $
      *Geometry:* The entire line is embedded in the plane $y=-2$.
    ]
    #v(2pt)
    #fig("figs/line_zero_dir.png", caption: [Trapped in plane $y=-2$.], w: 75%)
  ]
)

#v(6pt)

#grid(
  columns: (1.1fr, 0.9fr),
  gutter: 10pt,
  [
    #example(title: [P3 · Classifying a Shifted Quadric by Completing the Square])[
      Classify the surface $ x^2-y^2+4z^2-2x-4y+8z+1=0 $.

      *Step 1: Group and complete squares per variable:*
      $ x^2-2x = (x-1)^2-1 $
      $ -y^2-4y = -(y^2+4y) = -[(y+2)^2-4] = -(y+2)^2+4 $
      $ 4z^2+8z = 4(z^2+2z) = 4[(z+1)^2-1] = 4(z+1)^2-4 $

      *Step 2: Substitute and combine constants:*
      $ (x-1)^2 - 1 - (y+2)^2 + 4 + 4(z+1)^2 - 4 + 1 = 0 $
      $ (x-1)^2 - (y+2)^2 + 4(z+1)^2 = 0 $

      *Step 3: Isolate and classify:*
      $ (y+2)^2 = (x-1)^2 + 4(z+1)^2 $
      Right side degree 2, RHS $=0$ → *Elliptic Cone*. \
      *Vertex:* $(1, -2, -1)$. *Axis:* parallel to $y$-axis.
    ]
  ],
  [
    #fig("figs/cone_shifted.png", caption: [Shifted cone vertex $(1,-2,-1)$.], w: 85%)
    #refs([📖 Stewart 9e §12.5 #1–5, 13, 17, 23–39], [📖 Stewart 9e §12.6 #1–7, 23–30, 41, 55])
  ]
)

#pagebreak()

= 2 · Trace Analysis Master Problem

#example(title: [P4 · Complete Trace Analysis & Surface Identification — $z/2 = y^2/4 - x^2/9$])[
  #matrix(
    ([Slice Plane], [Trace Equation], [Geometric Curve], [Physical Behavior at Origin]),
    [$x=0$ (in $y z$)], [$z = y^2/2$], [Upward parabola ($V$ at origin)], [Along $y$-axis, origin is a *local minimum*],
    [$y=0$ (in $x z$)], [$z = -2x^2/9$], [Downward parabola ($V$ at origin)], [Along $x$-axis, origin is a *local maximum*],
    [$z=2$ (above origin)], [$y^2/4 - x^2/9 = 1$], [Hyperbola opening along $y$], [Cross-sections open north/south],
    [$z=-2$ (below origin)], [$x^2/9 - y^2/4 = 1$], [Hyperbola opening along $x$], [Cross-sections flip to east/west],
    [$z=0$ (in $x y$ plane)], [$y = ±(2/3)x$], [Two intersecting lines through origin], [Asymptotic boundary between level curves],
  )
  #v(4pt)
  #split(
    ratio: 1.2fr,
    [
      *Classification:* Because upward curvature along $y$ meets downward curvature along $x$, the origin $(0,0,0)$ is a *saddle point*. The surface is a *hyperbolic paraboloid* opening along $z$.
    ],
    fig("figs/traces_hp.png", caption: [Trace planes flipping axes across $z=0$.], w: 80%)
  )
]

#pagebreak()

= 3 · Test Yourself (Active Recall Worksheet)

#text(size: 9pt, style: "italic", fill: ink.lighten(30%))[
  Designed for iPad Noteful handwriting with Apple Pencil. Complete before checking the Answer Key.
]
#v(4pt)

#question(1)[
  A line passes through $A(2,-1,6)$ and $B(2,5,-3)$.
  #v(2pt)
  *(a)* Find the direction vector $arrow(v)$ and write the parametric equations. #h(1fr)
  *(b)* Write the symmetric equations (identify any zero direction components). \
  *(c)* Write the vector equation of the line segment from $A$ to $B$ and verify both endpoints.
  #worklines(5)
]

#question(2)[
  Classify each surface and state its axis of symmetry or opening direction:
  #v(2pt)
  *(a)* $9x^2 - y^2 + 4z^2 = 1$ #h(1fr)
  *(b)* $x = 2y^2 + 3z^2$ \
  *(c)* $4x^2 + y^2 - z^2 = 0$ #h(1fr)
  *(d)* $z = x^2 - 4y^2$
  #worklines(4)
]

#question(3)[
  Consider the equation $x^2 + 4y^2 - 6x + 8y - z + 9 = 0$.
  #v(2pt)
  *(a)* Complete the square and express the equation in standard form. \
  *(b)* Identify the surface type and state the coordinates of its vertex. \
  *(c)* Write the Maple command to plot this surface centered around its vertex.
  #worklines(6)
]

#pagebreak()

#block(width: 100%, fill: emerald-l, stroke: (left: 4pt + emerald), radius: 3pt, inset: 10pt)[
  #text(font: head-font, size: 16pt, fill: emerald.darken(15%))[🔑 Solutions & Answer Key]
  #v(1pt)
  #text(size: 8.8pt, style: "italic", fill: ink.lighten(25%))[Check answers only after attempting. Use for self-grading in Noteful.]
]

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #answer(1)[
      *(a)* $arrow(v) = arrow(A B) = ⟨2-2, 5-(-1), -3-6⟩ = ⟨0, 6, -9⟩$. \
      Parametric: $x=2, quad y=-1+6t, quad z=6-9t, quad t∈RR$. \
      *(b)* $a=0$, so division by zero is illegal:
      $ (y+1)/6 = (z-6)/(-9), quad x=2 $
      The line lives in the vertical plane $x=2$. \
      *(c)* $arrow(r)(t) = ⟨2, -1+6t, 6-9t⟩, quad 0 ≤ t ≤ 1$. \
      Check: $t=0 ⇒ (2,-1,6)=A$ ✓; $t=1 ⇒ (2,5,-3)=B$ ✓.
    ]
    #answer(2)[
      *(a)* One minus sign, RHS $=1$ → *Hyperboloid of one sheet*, axis $= y$. \
      *(b)* $x$ is linear, two quad terms same sign → *Elliptic Paraboloid*, opens along $+x$. \
      *(c)* All degree 2, RHS $=0$ → *Elliptic Cone*, axis $= z$. \
      *(d)* $z$ linear, opposite quadratic signs → *Hyperbolic Paraboloid* (saddle).
    ]
  ],
  [
    #answer(3)[
      *(a)* Group terms and complete squares:
      $ x^2-6x = (x-3)^2-9 $
      $ 4y^2+8y = 4(y^2+2y) = 4[(y+1)^2-1] = 4(y+1)^2-4 $
      $ (x-3)^2-9 + 4(y+1)^2-4 - z + 9 = 0 $
      $ z+4 = (x-3)^2 + 4(y+1)^2 $
      *(b)* *Elliptic Paraboloid*, opening along $+z$, vertex $(3, -1, -4)$. \
      *(c)* Maple command:
      #code("with(plots):
plot3d((x-3)^2 + 4*(y+1)^2 - 4,
       x=0..6, y=-4..2,
       style=patchcontour, axes=boxed);")
    ]
  ]
)
