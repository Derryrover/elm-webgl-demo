module CubeFace exposing (face)

import Math.Vector3 exposing (Vec3, vec3)
import Vertex exposing (Vertex)
import Color exposing (Color, toRgb)

-- Obsolete moved to SquareFace ??!! -> probably

-- square as in
{-
a-b
| |
d_c
-}
face : Color -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> List ( Vertex, Vertex, Vertex )
face rawColor a b c d normal =
  let
    rgb = toRgb rawColor
    color = vec3
            (toFloat rgb.red / 255)
            (toFloat rgb.green / 255)
            (toFloat rgb.blue / 255)
    vertex position = Vertex color position normal
  in
      [ ( vertex a, vertex b, vertex c )
      , ( vertex c, vertex d, vertex a )
      ]
-- Obsolete moved to SquareFace ??!! -> probably
