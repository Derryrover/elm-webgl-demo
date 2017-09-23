module WebGLScene exposing (..)

import WebGL exposing (Entity, entity)
import VertexShader exposing (vertexShader)
import FragmentShader exposing (fragmentShader)
import Uniforms exposing (uniforms)
import Cube exposing (cube)

scene : Float -> Float -> List Entity
scene angleX angleY =
    [ entity vertexShader fragmentShader cube (uniforms angleX angleY) ]
