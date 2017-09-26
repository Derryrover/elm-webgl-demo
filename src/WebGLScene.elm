module WebGLScene exposing (..)

import WebGL exposing (Entity, entity)
import VertexShader exposing (vertexShader)
import FragmentShader exposing (fragmentShader)
import Uniforms exposing (uniforms)
import Cube exposing (cube)
import Octaeder exposing (octaeder)
import Tetraeder exposing(tetraeder)

scene : Float -> Float -> List Entity
scene angleX angleY =
    let matrixCollection = uniforms angleX angleY
    in
    --[ entity vertexShader fragmentShader cube matrixCollection ]
    --[ entity vertexShader fragmentShader octaeder matrixCollection ]
    [ entity vertexShader fragmentShader tetraeder matrixCollection ]
