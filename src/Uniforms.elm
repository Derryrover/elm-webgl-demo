module Uniforms exposing (..)

import Math.Vector3 exposing (Vec3, vec3)
import Math.Matrix4 exposing (Mat4, mul, makeRotate, makePerspective, makeLookAt, transform)

uniforms : Float -> Float -> { rotation:Mat4, perspective:Mat4, camera:Mat4, shade:Float }
uniforms x y =
  { rotation = mul (makeRotate (3*x) (vec3 0 1 0)) (makeRotate (3*y) (vec3 1 0 0))
  , perspective = makePerspective 45 1 0.01 100
  , camera = makeLookAt (vec3 0 0 5) (vec3 0 0 0) (vec3 0 1 0)
  , shade = 1.0--0.8
  }
