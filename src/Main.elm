module Main exposing (..)

import WebGL exposing (Entity, entity)
import Time
import AnimationFrame
import Html.Attributes exposing (width, height)
import Html exposing (Html, beginnerProgram, fieldset, input, label, text)
import Html.Attributes exposing (width, height, style, type_)
import Html.Events exposing (onClick)
import Keyboard
import VertexShader exposing (vertexShader)
import FragmentShader exposing (fragmentShader)
import Uniforms exposing (uniforms)
import Cube exposing (cube)


type alias Model =
    { x : Float
    , y : Float
    , spin : Bool
    }


main : Program Never Model Msg



--Time.Time


main =
    Html.program
        { init =
            ( { x = 0
              , y = 0
              , spin = False
              }
            , Cmd.none
            )
        , view =
            (\model ->
                Html.div []
                    [ ((WebGL.toHtml [ width 400, height 400 ]) (scene model.x model.y))
                    , input [ type_ "checkbox", onClick Spin ] []
                    ]
            )
            --[ (scene >> WebGL.toHtml [width 400, height 400]) model.x model.y])
        , subscriptions =
            subscriptions
            --(\model -> AnimationFrame.diffs Basics.identity)
        , update =
            update
            --(\dt theta -> (theta + dt / 5000, Cmd.none))
        }



-- VIEW


twoViews : List Entity -> Html msg
twoViews renderable =
    Html.div []
        [ WebGL.toHtml [ width 400, height 400 ] renderable
        , WebGL.toHtml [ width 400, height 400 ] renderable
        ]


scene : Float -> Float -> List Entity
scene angleX angleY =
    [ entity vertexShader fragmentShader cube (uniforms angleX angleY) ]


type Msg
    = AnimMsg Time.Time
    | KeyMsg Keyboard.KeyCode
    | Spin


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs AnimMsg
          --(\model -> AnimationFrame.diffs Basics.identity) AnimMsg
        , Keyboard.downs KeyMsg
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimMsg dt ->
            case model.spin of
                True ->
                    ( { x = (model.x + (dt) / 5000), y = (model.y + (dt) / 10000), spin = model.spin }, Cmd.none )

                False ->
                    ( model, Cmd.none )

        KeyMsg code ->
            case code of
                37 ->
                    --left
                    ( { x = model.x - 0.01, y = model.y, spin = model.spin }, Cmd.none )

                39 ->
                    --right
                    ( { x = model.x + 0.01, y = model.y, spin = model.spin }, Cmd.none )

                38 ->
                    --Up
                    ( { x = model.x, y = model.y - 0.01, spin = model.spin }, Cmd.none )

                40 ->
                    --Down
                    ( { x = model.x, y = model.y + 0.01, spin = model.spin }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Spin ->
            ( { x = model.x, y = model.y, spin = not model.spin }, Cmd.none )
