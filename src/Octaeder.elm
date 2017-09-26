module Octaeder exposing(..)

import Math.Vector3 exposing (vec3)
import TriangleFace exposing (face)
import Color exposing (green, blue, yellow, red, purple, orange, white, darkBlue)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)

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

{-

  1
  |
  3
 / \
2   4
 \ /
  5
  |
  6

-}
