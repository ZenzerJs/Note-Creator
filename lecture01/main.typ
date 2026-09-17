#import "../template.typ": conf, definition, keytip, problem

#show: doc => conf(
  title: "MA201: Multivariable Calculus",
  subtitle: "3D Coordinate Systems & Vectors",
  lecture: "Lecture 01",
  doc
)

= 1. Three-Dimensional Coordinate Systems

To locate a point in space, we choose a fixed point $O$ (the origin) and three mutually perpendicular directed lines through $O$ called the coordinate axes: $x$-axis, $y$-axis, and $z$-axis.

#definition(title: "Distance Formula in 3D Space")[
  The distance $|P_1 P_2|$ between points $P_1(x_1, y_1, z_1)$ and $P_2(x_2, y_2, z_2)$ is given by:
  $ |P_1 P_2| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2) $
]

#definition(title: "Equation of a Sphere")[
  An equation of a sphere with center $C(h, k, l)$ and radius $r$ is:
  $ (x - h)^2 + (y - k)^2 + (z - l)^2 = r^2 $
]

#keytip(title: "Right-Hand Rule")[
  Curl the fingers of your right hand in the direction of a $90 degree$ rotation from the positive $x$-axis to the positive $y$-axis; your thumb points along the positive $z$-axis.
]

= 2. Vectors in Three Dimensions

A three-dimensional vector is an ordered triple:
$ bold(v) = chevron.l v_1, v_2, v_3 chevron.r = v_1 bold(i) + v_2 bold(j) + v_3 bold(k) $

Its magnitude is:
$ |bold(v)| = sqrt(v_1^2 + v_2^2 + v_3^2) $

#problem(title: "Stewart 12.1 Example")[
  Show that $x^2 + y^2 + z^2 + 4x - 6y + 2z + 6 = 0$ is the equation of a sphere, and find its center and radius.

  *Solution:*
  Complete the square for $x$, $y$, and $z$:
  $ (x^2 + 4x + 4) + (y^2 - 6y + 9) + (z^2 + 2z + 1) = -6 + 4 + 9 + 1 $
  $ (x + 2)^2 + (y - 3)^2 + (z + 1)^2 = 8 $
  Sphere has center $(-2, 3, -1)$ and radius $r = sqrt(8) = 2 sqrt(2)$.
]
