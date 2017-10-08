module TextureExample exposing(..)

import Math.Vector2 exposing (Vec2)
import Math.Vector3 exposing (..)
import Math.Matrix4 exposing (..)
import Task
import Time exposing (Time)
--import WebGL exposing (..)
import WebGL exposing (..)
import WebGL.Texture exposing(load)
import Html exposing (Html)
import Html.Attributes exposing (id)
--import Html.App as Html
import AnimationFrame
import Html.Attributes exposing (width, height)


type alias Model =
  { texture : Maybe Texture
  , theta : Float
  , error: String
  }


type Action
  = TextureError WebGL.Texture.Error
  | TextureLoaded Texture
  | Animate Time


update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    TextureError err ->
      ({model | error = toString err}, Cmd.none)
    TextureLoaded texture ->
      ({model | texture = Just texture}, Cmd.none)
    Animate dt ->
      ({model | theta = model.theta + dt / 10000}, Cmd.none)


init : (Model, Cmd Action)
init =
  ( {texture = Nothing, theta = 0, error = ""}
  , --(load "Square2.png")
    --|> Task.perform TextureError TextureLoaded
    --Task.perform (load "Square2.png") (TextureError )
    --load "woodCrate.jpg"
    --load "Square2_512.png"
    load "Square2_1024.png"
                |> Task.attempt
                    (\result ->
                        case result of
                            Err err ->
                                TextureError err

                            Ok val ->
                                TextureLoaded val
                    )
  )


--main : Program Never
main : Program Never Model Action
main =
  Html.program
    { init = init
    , view = view
    , subscriptions = subscriptions--(\model -> AnimationFrame.diffs Animate)
    , update = update
    }

subscriptions = (\model -> AnimationFrame.diffs Animate)

-- MESHES

crate : Mesh { pos:Vec3, coord:Vec3 }
crate =
  triangles <|
  List.concatMap rotatedFace [ (0,0), (90,0), (180,0), (270,0), (0,90), (0,-90) ]


rotatedFace : (Float,Float) -> List ({ pos:Vec3, coord:Vec3 }, { pos:Vec3, coord:Vec3 }, { pos:Vec3, coord:Vec3 })
rotatedFace (angleX,angleY) =
  let
    x = makeRotate (degrees angleX) (vec3 1 0 0)
    y = makeRotate (degrees angleY) (vec3 0 1 0)
    --t = x `mul` y `mul` makeTranslate (vec3 0 0 1)
    t = mul (mul x y) (makeTranslate (vec3 0 0 1))
    each f (a,b,c) =
      (f a, f b, f c)
  in
    List.map (each (\x -> {x | pos = transform t x.pos })) face


face : List ({ pos:Vec3, coord:Vec3 }, { pos:Vec3, coord:Vec3 }, { pos:Vec3, coord:Vec3 })
face =
  let
    topLeft     = { pos = vec3 -1  1 0, coord = vec3 0 1 0 }
    topRight    = { pos = vec3  1  1 0, coord = vec3 1 1 0 }
    bottomLeft  = { pos = vec3 -1 -1 0, coord = vec3 0 0 0 }
    bottomRight = { pos = vec3  1 -1 0, coord = vec3 1 0 0 }
  in
    [ (topLeft,topRight,bottomLeft)
    , (bottomLeft,topRight,bottomRight)
    ]


-- VIEW

perspective : Float -> Mat4
perspective angle =
  List.foldr mul Math.Matrix4.identity
    [ perspectiveMatrix
    , camera
    , makeRotate (3*angle) (vec3 0 1 0)
    , makeRotate (2*angle) (vec3 1 0 0)
    ]


perspectiveMatrix : Mat4
perspectiveMatrix =
  makePerspective 45 1 0.01 100


camera : Mat4
camera =
  makeLookAt (vec3 0 0 5) (vec3 0 0 0) (vec3 0 1 0)


view : Model -> Html Action
view {texture, theta, error} =

  (case texture of
    Nothing ->
        []
    Just tex ->
        [entity vertexShader fragmentShader crate { crate = tex, perspective = perspective theta }]
  )
  |> (\toDraw -> Html.div [] [(WebGL.toHtml [width 400, height 400] toDraw), Html.div [id "testTexture"] [Html.text error]])

-- webGlScene : Model -> scene : Float -> Float -> List Entity

-- SHADERS

vertexShader : Shader { pos:Vec3, coord:Vec3 } { u | perspective:Mat4 } { vcoord:Vec2 }
vertexShader = [glsl|

attribute vec3 pos;
attribute vec3 coord;
uniform mat4 perspective;
varying vec2 vcoord;

void main () {
  gl_Position = perspective * vec4(pos, 1.0);
  vcoord = coord.xy;
}

|]


fragmentShader : Shader {} { u | crate:Texture } { vcoord:Vec2 }
fragmentShader = [glsl|

precision mediump float;
uniform sampler2D crate;
varying vec2 vcoord;

void main () {
  gl_FragColor = texture2D(crate, vcoord);
}

|]
