module PentagonFace exposing (face)

import Math.Vector3 exposing (Vec3, vec3)
import Vertex exposing (Vertex)
import Color exposing (Color, toRgb)

-- square as in
{-
a-b
| |
d_c
-}
face : Color -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> List ( Vertex, Vertex, Vertex )
face rawColor normal a b c d e =
  let
    rgb = toRgb rawColor
    color = vec3
            (toFloat rgb.red / 255)
            (toFloat rgb.green / 255)
            (toFloat rgb.blue / 255)
    vertex position = Vertex color position normal
  in
      [ ( vertex a, vertex b, vertex c )
      , ( vertex a, vertex c, vertex d )
      , ( vertex a, vertex d, vertex e )
      ]
