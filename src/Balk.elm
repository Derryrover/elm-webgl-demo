module Balk exposing (balk)

import Math.Vector3 exposing (vec3)
--import CubeFace exposing (face)
import SquareFace exposing (face)
import Color exposing (green, blue, yellow, red, purple, orange)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)

balk :  WebGL.Mesh Vertex
balk =
  let
    -- left, front, top
    ltf = vec3 -1  0.5  0.5
    rtf = vec3  1  0.5  0.5
    rdf = vec3  1 -0.5  0.5
    ldf = vec3 -1 -0.5  0.5
    ltb = vec3 -1  0.5 -0.5
    rtb = vec3  1  0.5 -0.5
    rdb = vec3  1 -0.5 -0.5
    ldb = vec3 -1 -0.5 -0.5
  in
    --WebGL.Triangle
    WebGL.triangles
    (List.concat
        [ -- left
          face purple ltb ltf ldf ldb (vec3 -1  0  0)
          -- right
        , face green  rtb rtf rdf rdb (vec3  1  0  0)
          -- top
        , face blue   ltf rtf rtb ltb (vec3  0  1  0)
          -- down
        , face orange ldf rdf rdb ldb (vec3  0 -1  0)
          -- front
        , face yellow ltf rtf rdf ldf (vec3  0  0  1)
          -- back
        , face red    ltb rtb rdb ldb (vec3  0  0 -1)
        ])
