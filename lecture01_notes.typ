#import "template.typ": *

#show: doc.with(
  title: "MA201A — Lecture 01 Notes & Lab Guide",
  subtitle: "§12.5 Lines in Space · §12.6 Cylinders & Quadric Surfaces — Stewart 9e · Fall 2026",
)

= 1 · Recap & Visual Intuition

== Cylinders & The Missing-Variable Rule

#split(
  ratio: 1.2fr,
  [
    #definition[
      A *cylinder* is a surface formed by all lines (*rulings*) parallel to a given
      line passing through a given plane curve. It is any 2D curve extruded infinitely through space.
    ]
    #keytip[
      *Missing-variable rule* — if an equation in $RR^3$ lacks one coordinate,
      graph the curve in the plane of the two present variables, then extrude it
      infinitely along the missing axis through all 8 octants.
    ]
    #grid(
      columns: (1fr, 1fr),
      gutter: 6pt,
      [#hl[Circular:] $x^2+y^2=r^2$ ($parallel z$)],
      [#hl[Parabolic:] $z=y^2$ (extruded along $x$)],
      [#hl[Elliptic:] $x^2/a^2+y^2/b^2=1$ ($a≠b$)],
      [#hl[Hyperbolic:] $x^2/a^2-y^2/b^2=1$ (rulings $parallel z$)],
    )
  ],
  fig("figs/parabolic_cylinder.png", caption: [$z=y^2$: parabola in $y z$-plane extruded along $x$.]),
)

#v(4pt)

== 2D Parameterization → 3D Trajectory

#split(
  ratio: 1fr,
  [
    Segment from $(0,1)$ to $(1,0)$ on line $y=1-x$. Setting $x(t)=t ⇒ y(t)=1-t$:
    $ arrow(r)(t) = ⟨ t, 1-t ⟩, quad t∈[0,1] $
    #v(2pt)
    #align(center)[
      #table(
        columns: 5,
        stroke: 0.6pt + grid-c,
        fill: (x, y) => if y == 0 { teal-l } else { white },
        inset: (x: 8pt, y: 4pt),
        align: center + horizon,
        [*$t$*], [*$(x,y)$*], [*$arrow(r)(t)$*], [*Travel*], [*Interpretation*],
        [$0$], [$(0,1)$], [$⟨0,1⟩$], [Start], [Base point $P_0$],
        [$1/2$], [$(1/2,1/2)$], [$⟨1/2,1/2⟩$], [Midpoint], [Constant speed],
        [$1$], [$(1,0)$], [$⟨1,0⟩$], [End], [Terminal point $P_1$],
      )
    ]
  ],
  keytip(title: "Parameterization fixes Order, Direction & Speed")[
    The *set* of points is merely a line segment — but parameterization specifies:
    1. *Start point* ($t=0$).
    2. *Direction of travel* (towards $P_1$).
    3. *Velocity* ($arrow(v)=⟨1,-1⟩$, speed $|arrow(v)|=sqrt(2)$).
    For the *infinite line*, let $t∈RR$.
  ],
)

== Lines in $RR^3$ (Vector, Parametric & Symmetric Forms)

#split(
  ratio: 1.3fr,
  [
    A line $L$ in space is determined by a base point $P_0(x_0,y_0,z_0)$ and direction vector $arrow(v)=⟨a,b,c⟩ parallel L$.
    #grid(
      columns: (1fr, 1fr),
      gutter: 6pt,
      definition(title: "Vector Form")[
        $ arrow(r)(t) = arrow(r)_0 + t arrow(v) $
        $ = ⟨ x_0+a t, y_0+b t, z_0+c t ⟩ $
      ],
      definition(title: "Parametric Form")[
        $ x = x_0 + a t $
        $ y = y_0 + b t, quad z = z_0 + c t $
      ],
      definition(title: "Symmetric Form ($a,b,c ≠ 0$)")[
        $ (x-x_0)/a = (y-y_0)/b = (z-z_0)/c $
      ],
      definition(title: "Segment $P_0 → P_1$")[
        $ arrow(r)(t) = (1-t)arrow(r)_0 + t arrow(r)_1 $
        $ 0 ≤ t ≤ 1 $
      ],
    )
  ],
  fig("figs/line_3d.png", caption: [Line through $P_0(-1,-4,-4)$ and $P_1(2,0,-3)$, $arrow(v)=⟨3,4,1⟩$.]),
)

#refs([📖 Stewart 9e §12.5 · §12.6], [📖 Paul's Online Notes — Lines / Quadric Surfaces], [▶ Prof. Leonard — Calc 3 §12.5])

= 2 · Classification Cheat-Sheet

#keytip[
  *General Second-Degree Equation:* $A x^2+B y^2+C z^2+D x y+E y z+F x z+G x+H y+I z+J=0$. \
  *Speed Decision Rule:* Count minus signs, check RHS ($=1$ vs $=0$), and check for an isolated linear variable.
]

#matrix(
  ([Algebraic Signature], [Surface], [Axis / Opening], [Horizontal Traces], [Vertical Traces]),
  [All $+$, $= 1$], [Ellipsoid], [Bounded (no opening axis)], [Ellipses], [Ellipses],
  [Exactly one $-$, $= 1$], [Hyperboloid, 1 sheet], [Along *negative* variable], [Ellipses], [Hyperbolas],
  [Exactly two $-$, $= 1$], [Hyperboloid, 2 sheets], [Along *positive* variable], [Ellipses ($|z|≥c$)], [Hyperbolas],
  [All degree 2, $= 0$], [Elliptic Cone], [Along *isolated* variable], [Ellipses], [Hyperbolas / lines],
  [One *linear*, two quad *same* sign], [Elliptic Paraboloid], [Opens along linear variable], [Ellipses], [Parabolas],
  [One *linear*, two quad *opposite* sign], [Hyperbolic Paraboloid], [Saddle at vertex], [Hyperbolas], [Parabolas],
  [One variable *missing*], [Cylinder], [Rulings $parallel$ missing axis], [2D base curve], [Parallel lines],
)

#v(6pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 6pt,
  qcard("Ellipsoid", $ x^2/a^2+y^2/b^2+z^2/c^2=1 $, "figs/ellipsoid.png",
    [Bounded. All traces ellipses. $a=b=c ⇒$ sphere.]),
  qcard("Elliptic Paraboloid", $ z/c=x^2/a^2+y^2/b^2 $, "figs/elliptic_paraboloid.png",
    [Bowl shape. Up if $c>0$, down if $c<0$.]),
  qcard("Hyperbolic Paraboloid", $ z/c=x^2/a^2-y^2/b^2 $, "figs/hyp_paraboloid.png",
    [Saddle. Min along one axis, max along other.]),
  qcard("Elliptic Cone", $ z^2/c^2=x^2/a^2+y^2/b^2 $, "figs/cone.png",
    [Two lobes apex-to-apex. RHS $=0$ giveaway.]),
  qcard("Hyperboloid — 1 Sheet", $ x^2/a^2+y^2/b^2-z^2/c^2=1 $, "figs/hyperboloid_1sheet.png",
    [Connected hourglass. #hl(color:teal)[One] minus.]),
  qcard("Hyperboloid — 2 Sheets", $ -x^2/a^2-y^2/b^2+z^2/c^2=1 $, "figs/hyperboloid_2sheet.png",
    [Two separate lobes. #hl(color:coral)[Two] minuses.]),
)

== Trace Synthesis: Building $z = x^2-y^2$

#split(
  ratio: 1.1fr,
  [
    #example(title: "Anatomy of a Saddle")[
      - *Slice $x=k$* (planes $parallel y z$): $z=k^2-y^2$ (downward parabolas, crest at $k^2$).
      - *Slice $y=k$* (planes $parallel x z$): $z=x^2-k^2$ (upward parabolas, trough at $-k^2$).
      - *Slice $z=k$* (horizontal planes): $k=x^2-y^2$ (hyperbolas; degenerate crossing lines at $k=0$).
      Opposite curvatures at origin create a *saddle point* (neither local max nor local min).
    ]
  ],
  fig("figs/saddle_traces.png", caption: [Slicing $z=x^2-y^2$: upward along $x$, downward along $y$.]),
)

= 3 · Assessment Traps & Lab Reference

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  quizalert(title: "iClicker Trap: Dimension Ambiguity")[
    $x^2+y^2=1$ is a *circle* in $RR^2$, but a *circular cylinder* in $RR^3$. \
    $y=x^2$ is a parabola in $RR^2$, but a *parabolic cylinder* in $RR^3$. \
    Always check the ambient space before answering!
  ],
  quizalert(title: "Exam Trap: Zero Direction Component")[
    If $arrow(v)=⟨a,0,c⟩$, the symmetric fraction $(y-y_0)/0$ is *illegal*. \
    Correct form: $(x-x_0)/a = (z-z_0)/c, quad y=y_0$. \
    Geometrically: the line lies entirely inside the plane $y=y_0$.
  ],
  quizalert(title: "RHS Sign Governs Everything")[
    $x^2+y^2-z^2 = k$:
    - $k=0$ → *Cone* (apex at origin).
    - $k=1$ → *Hyperboloid of 1 sheet* (connected).
    - $k=-1$ → *Hyperboloid of 2 sheets* (disconnected).
  ],
  assignalert(title: "Assignment 1 Rubric Checklist (Wed Sept 23)")[
    - Write $arrow(v)=arrow(P_0 P_1)$ explicitly before equations.
    - Always declare parameter domain ($t∈RR$ vs $0≤t≤1$).
    - Show complete-the-square steps; centre/vertex earns own mark.
    - Verify endpoints $t=0$ and $t=1$.
  ],
)

#mapletip(title: "Maple Lab 1 Reference — Thurs Sept 24 (LH3068)")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    [
      *Essential 3D Plot Commands:*
      #code("with(plots):
# 1. 3D Spacecurve (parametric line segment):
spacecurve([-1+3*t, -4+4*t, -4+t], t=0..1, thickness=3, color=red);

# 2. Implicit Quadric Surface:
implicitplot3d(x^2/4 + y^2/9 + z^2 = 1, x=-3..3, y=-4..4, z=-2..2);

# 3. Explicit Surface:
plot3d(x^2 - y^2, x=-2..2, y=-2..2, style=patchcontour);")
    ],
    [
      *Intersection Curves & Constrained Scaling:*
      #code("# Curve of intersection: z = x^2+y^2 and z = 4
spacecurve([2*cos(t), 2*sin(t), 4], t=0..2*Pi, thickness=3);

# Display multiple objects together:
display([surface, curve], scaling=constrained);")
      *Golden Lab Habit:* Always append `scaling=constrained` so equal distances along $x,y,z$ appear equal on screen (prevents spheres from looking like footballs).
    ]
  )
]
