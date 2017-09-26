module Tetraeder exposing(..)

import Math.Vector3 exposing (vec3)
import TriangleFace exposing (face)
import Color exposing (green, blue, yellow, red)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)

a = 1


top   = vec3   1   1   1
left  = vec3  -1  -1   1
right = vec3  -1   1  -1
back  = vec3   1  -1  -1

tlr = face green  (vec3 -1  1  1) top   left   right
tlb = face blue   (vec3  1 -1  1) top   left   back
trb = face yellow (vec3  1  1 -1) top   right  back
brl = face red    (vec3 -1 -1 -1) back  left   right

tetraeder = WebGL.triangles [tlr,tlb,trb,brl]

{-
 t
/|\
lbr
-}
