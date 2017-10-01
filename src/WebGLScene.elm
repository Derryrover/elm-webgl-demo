module WebGLScene exposing (..)

import WebGL exposing (Entity, entity)
import VertexShader exposing (vertexShader)
import FragmentShader exposing (fragmentShader)
import Uniforms exposing (uniforms)
import Cube exposing (cube)
import Octaeder exposing (octaeder)
import Tetraeder exposing(tetraeder)
import Balk exposing (balk)
import Icosahedron exposing(icosahedron)
import TruncatedIcosahedron exposing(pentagon, truncatedIcosahedron)

scene : Float -> Float -> List Entity
scene angleX angleY =
    let matrixCollection = uniforms angleX angleY
    in
    --[ entity vertexShader fragmentShader cube matrixCollection ]
    --[ entity vertexShader fragmentShader octaeder matrixCollection ]
    --[ entity vertexShader fragmentShader tetraeder matrixCollection ]
    --[ entity vertexShader fragmentShader balk matrixCollection ]
    --[ entity vertexShader fragmentShader icosahedron matrixCollection ]
    --[ entity vertexShader fragmentShader pentagon matrixCollection ]
    [ entity vertexShader fragmentShader truncatedIcosahedron matrixCollection ]
