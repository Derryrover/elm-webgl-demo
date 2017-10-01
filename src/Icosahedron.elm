module Icosahedron exposing(..)

import Math.Vector3 exposing (vec3, normalize, add)
import TriangleFace exposing (face)
import Color exposing (green, blue, yellow, red, purple, orange, white, darkBlue, darkGrey)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)
import List
import GoldenRatio exposing(goldenRatio)

createNormal a b c =
  (normalize(add(add a b) c))

createFace colorP a b c =
   face colorP (createNormal a b c) a b c

-- https://en.wikipedia.org/wiki/Icosahedron
-- The coordinates of the 12 vertices can be defined by:
-- the vectors defined by all the possible cyclic permutations and sign-flips of
-- coordinates of the form (2, 1, 0).

-- create 3 rectangles along the tree axis
-- as seen in icosahedron_construction.png

-- for convenience
z = goldenRatio

-- x axis
x1 = normalize (vec3  0  z  1)
x2 = normalize (vec3  0  z -1)
x3 = normalize (vec3  0 -z -1)
x4 = normalize (vec3  0 -z  1)

-- y axis
y1 = normalize (vec3  1  0  z)
y2 = normalize (vec3 -1  0  z)
y3 = normalize (vec3 -1  0 -z)
y4 = normalize (vec3  1  0 -z)

-- z axis
z1 = normalize (vec3  z  1  0)
z2 = normalize (vec3  z -1  0)
z3 = normalize (vec3 -z -1  0)
z4 = normalize (vec3 -z  1  0)

-- create the 12 faces by combining 2 adjacent edges of one rectangles with a third edge of another rectangle.
-- these two adjacent edges should either be both 2 or both -1
-- the third edge should be from another rectangle that has:
-- 1 where the two adjacent edges have 2 OR
-- -1 where the two adjacent edges are -1
-- for example (0  2  1) (0  2 -1) & ( 2  1  0)
-- or          (0  2  1) (0  2 -1) & (-2  1  0)

whitesX1 = createFace blue x1 x2 z1
whitesX2 = createFace red  x1 x2 z4
whitesX3 = createFace blue x3 x4 z2
whitesX4 = createFace red  x3 x4 z3

whitesY1 = createFace blue  y1 y2 x1
whitesY2 = createFace red   y1 y2 x4
whitesY3 = createFace blue  y3 y4 x2
whitesY4 = createFace red   y3 y4 x3

whitesZ1 = createFace blue  z1 z2 y1
whitesZ2 = createFace red   z1 z2 y4
whitesZ3 = createFace blue  z3 z4 y2
whitesZ4 = createFace red   z3 z4 y3


-- create 8 faces by taking one from each axis
-- for each axis per over all vertixes: they shall not differ in arity
-- for example ( 0  2 -1) ( 1  0 -2) ( 2  1 0)
-- if one axis is minus for one vertex it should me minus (or zero) for all
black1 = createFace darkGrey  x1 y1 z1
black2 = createFace darkGrey  x1 y2 z4
black3 = createFace darkGrey  x2 y3 z4
black4 = createFace darkGrey  x2 y4 z1
black5 = createFace darkGrey  x3 y4 z2
black6 = createFace darkGrey  x3 y3 z3
black7 = createFace darkGrey  x4 y2 z3
black8 = createFace darkGrey  x4 y1 z2

facesWhite = [ whitesX1, whitesX2, whitesX3, whitesX4
             , whitesY1, whitesY2, whitesY3, whitesY4
             , whitesZ1, whitesZ2, whitesZ3, whitesZ4 ]

facesBlack = [ black1, black2, black3, black4
             , black5, black6, black7, black8 ]

icosahedron = WebGL.triangles (List.concat [facesWhite, facesBlack])
