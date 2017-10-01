module TruncatedIcosahedron exposing(..)

import Icosahedron exposing(..)
import Math.Vector3 exposing (vec3, normalize, add, scale)
import PentagonFace exposing(face)
import Color exposing (green, blue, yellow, red, purple, orange, white, darkBlue, darkGrey)
import WebGL exposing (Entity)
import Vertex exposing(Vertex)
import List

createNormal a b c d e =
  (normalize(add(add(add(add a b) c) d) e))

createFace colorP a b c d e =
   face colorP (createNormal a b c d e) a b c d e



-- https://paulscottinfo.ipage.com/polyhedra/semiregular/trunc-icosah.html#anchordefncheck
createPentagonVertex v1 v2 = add (scale (2/3) v1) (scale (1/3) v2)
p1_1 = createPentagonVertex x1 x2
p1_2 = createPentagonVertex x1 z1
p1_3 = createPentagonVertex x1 y1
p1_4 = createPentagonVertex x1 y2
p1_5 = createPentagonVertex x1 z4

p2_1 = createPentagonVertex x2 x1
p2_2 = createPentagonVertex x2 z1
p2_3 = createPentagonVertex x2 y4
p2_4 = createPentagonVertex x2 y3
p2_5 = createPentagonVertex x2 z4

p3_1 = createPentagonVertex x3 x4
p3_2 = createPentagonVertex x3 z2
p3_3 = createPentagonVertex x3 y4
p3_4 = createPentagonVertex x3 y3
p3_5 = createPentagonVertex x3 z3

p4_1 = createPentagonVertex x4 x3
p4_2 = createPentagonVertex x4 z2
p4_3 = createPentagonVertex x4 y1
p4_4 = createPentagonVertex x4 y2
p4_5 = createPentagonVertex x4 z3

p5_1 = createPentagonVertex y1 y2
p5_2 = createPentagonVertex y1 x1
p5_3 = createPentagonVertex y1 z1
p5_4 = createPentagonVertex y1 z2
p5_5 = createPentagonVertex y1 x4

p6_1 = createPentagonVertex y2 y1
p6_2 = createPentagonVertex y2 x1
p6_3 = createPentagonVertex y2 z4
p6_4 = createPentagonVertex y2 z3
p6_5 = createPentagonVertex y2 x4

p7_1 = createPentagonVertex y3 y4
p7_2 = createPentagonVertex y3 x2
p7_3 = createPentagonVertex y3 z4
p7_4 = createPentagonVertex y3 z3
p7_5 = createPentagonVertex y3 x3

p8_1 = createPentagonVertex y4 y3
p8_2 = createPentagonVertex y4 x2
p8_3 = createPentagonVertex y4 z1
p8_4 = createPentagonVertex y4 z2
p8_5 = createPentagonVertex y4 x3

p9_1 = createPentagonVertex z1 z2
p9_2 = createPentagonVertex z1 y1
p9_3 = createPentagonVertex z1 x1
p9_4 = createPentagonVertex z1 x2
p9_5 = createPentagonVertex z1 y4

p10_1 = createPentagonVertex z2 z1
p10_2 = createPentagonVertex z2 y1
p10_3 = createPentagonVertex z2 x4
p10_4 = createPentagonVertex z2 x3
p10_5 = createPentagonVertex z2 y4

p11_1 = createPentagonVertex z3 z4
p11_2 = createPentagonVertex z3 y2
p11_3 = createPentagonVertex z3 x4
p11_4 = createPentagonVertex z3 x3
p11_5 = createPentagonVertex z3 y3

p12_1 = createPentagonVertex z4 z3
p12_2 = createPentagonVertex z4 y2
p12_3 = createPentagonVertex z4 x1
p12_4 = createPentagonVertex z4 x2
p12_5 = createPentagonVertex z4 y3

pentFace1  = createFace red p1_1  p1_2  p1_3  p1_4  p1_5
pentFace2  = createFace red p2_1  p2_2  p2_3  p2_4  p2_5
pentFace3  = createFace red p3_1  p3_2  p3_3  p3_4  p3_5
pentFace4  = createFace red p4_1  p4_2  p4_3  p4_4  p4_5
pentFace5  = createFace red p5_1  p5_2  p5_3  p5_4  p5_5
pentFace6  = createFace red p6_1  p6_2  p6_3  p6_4  p6_5
pentFace7  = createFace red p7_1  p7_2  p7_3  p7_4  p7_5
pentFace8  = createFace red p8_1  p8_2  p8_3  p8_4  p8_5
pentFace9  = createFace red p9_1  p9_2  p9_3  p9_4  p9_5
pentFace10 = createFace red p10_1 p10_2 p10_3 p10_4 p10_5
pentFace11 = createFace red p11_1 p11_2 p11_3 p11_4 p11_5
pentFace12 = createFace red p12_1 p12_2 p12_3 p12_4 p12_5

pentagon = WebGL.triangles (List.concat [pentFace1])
truncatedIcosahedron = WebGL.triangles (List.concat [pentFace1, pentFace2, pentFace3, pentFace4, pentFace5, pentFace6, pentFace7, pentFace8, pentFace9, pentFace10, pentFace11, pentFace12])
