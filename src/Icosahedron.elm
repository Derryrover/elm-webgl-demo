module Icosahedron exposing(..)

import Math.Vector3 exposing (vec3)
import TriangleFace exposing (face)
import Color exposing (green, blue, yellow, red, purple, orange, white, darkBlue)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)

-- x axis
x1 = vec3  0  2  1
x2 = vec3  0  2 -1
x3 = vec3  0 -2 -1
x4 = vec3  0 -2  1

-- y axis
y1 = vec3  1  0  2
y2 = vec3 -1  0  2
y3 = vec3 -1  0 -2
y4 = vec3  1  0 -2

-- z axis
z1 = vec3  2  1  0
z2 = vec3  2 -1  0
z3 = vec3 -2 -1  0
z4 = vec3 -2  1  0

whitesX1 = face blue (vec3  1  1  1) x1 x2 z1
whitesX2 = face red  (vec3  1  1  1) x1 x2 z4
whitesX3 = face blue (vec3  1  1  1) x3 x4 z2
whitesX4 = face red  (vec3  1  1  1) x3 x4 z3

whitesY1 = face green  (vec3  1  1  1) y1 y2 x1
whitesY2 = face orange (vec3  1  1  1) y1 y2 x4
whitesY3 = face green  (vec3  1  1  1) y3 y4 x2
whitesY4 = face orange (vec3  1  1  1) y3 y4 x3

whitesZ1 = face yellow  (vec3  1  1  1) z1 z2 y1
whitesZ2 = face purple  (vec3  1  1  1) z1 z2 y4
whitesZ3 = face yellow  (vec3  1  1  1) z3 z4 y2
whitesZ4 = face purple  (vec3  1  1  1) z3 z4 y3

icosahedron = WebGL.triangles
  [ whitesX1
  , whitesX2
  , whitesX3
  , whitesX4
  , whitesY1
  , whitesY2
  , whitesY3
  , whitesY4
  , whitesZ1
  , whitesZ2
  , whitesZ3
  , whitesZ4]
{-}
-- positive
p1 = vec3  2  1  0
p2 = vec3  0  2  1
p3 = vec3  1  0  2

--negative
n1 = vec3  -2  -1  0
n2 = vec3  -0  -2 -1
n3 = vec3  -1   0 -2

--2negative 1positive
np1 = vec3  -2   1  0
np2 = vec3   0  -2  1
np3 = vec3   1   0 -2

--1negative 2positive
pn1 = vec3   2  -1  0
pn2 = vec3   0   2 -1
p23 = vec3  -1   0  2
-}

{-}
top   = vec3  0  1  0
down  = vec3  0 -1  0
left  = vec3 -1  0  0
right = vec3  1  0  0
front = vec3  0  0  1
back  = vec3  0  0 -1

ltf = face red    (vec3 -1  1  1) left  top  front
rtf = face blue   (vec3  1  1  1) right top  front
rtb = face yellow (vec3  1  1 -1) right top  back
ltb = face green  (vec3 -1  1 -1) left  top  back
ldf = face purple (vec3 -1 -1  1) left  down front
rdf = face orange (vec3  1 -1  1) right down front
rdb = face white  (vec3  1 -1  1) right down back
ldb = face darkBlue (vec3 -1 -1  1) left down back

octaeder = WebGL.triangles [ltf,rtf,rtb,ltb,ldf,rdf,rdb,ldb]
-}
