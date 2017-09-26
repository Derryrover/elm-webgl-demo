module TriangleFace exposing(..)

import Math.Vector3 exposing (Vec3, vec3)
import Vertex exposing (Vertex)
import Color exposing (Color, toRgb)

face : Color -> Vec3 -> Vec3 -> Vec3 -> Vec3 -> ( Vertex, Vertex, Vertex )
face rawColor normal a b c =
  let
    rgb = toRgb rawColor
    color = vec3
            (toFloat rgb.red   / 255)
            (toFloat rgb.green / 255)
            (toFloat rgb.blue  / 255)
    vertexA = Vertex color a normal
    vertexB = Vertex color b normal
    vertexC = Vertex color c normal
  in
    ( vertexA, vertexB, vertexC )
