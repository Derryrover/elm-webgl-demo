module Cube exposing (cube)

import Math.Vector3 exposing (vec3)
import CubeFace exposing (face)
import Color exposing (green, blue, yellow, red, purple, orange)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)

cube :  WebGL.Mesh Vertex
cube =
  let
    -- left, front, top
    ltf = vec3 -1  1  1
    rtf = vec3  1  1  1
    rdf = vec3  1 -1  1
    ldf = vec3 -1 -1  1
    ltb = vec3 -1  1 -1
    rtb = vec3  1  1 -1
    rdb = vec3  1 -1 -1
    ldb = vec3 -1 -1 -1
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
