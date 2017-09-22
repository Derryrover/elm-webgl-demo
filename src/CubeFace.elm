module CubeFace exposing (face)--,toFace3Vertex)

import Math.Vector3 exposing (Vec3, vec3)
import Vertex exposing (Vertex)
import Color exposing (Color, toRgb)

import List

face : Color -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> List ( Vertex, Vertex, Vertex )
face rawColor a b c d normal =
    let
        color =
            let
                c =
                    toRgb rawColor
            in
                vec3
                    (toFloat c.red / 255)
                    (toFloat c.green / 255)
                    (toFloat c.blue / 255)

        vertex position =
            Vertex color position normal
    in
        [ ( vertex a, vertex b, vertex c )
        , ( vertex c, vertex d, vertex a )
        ]
