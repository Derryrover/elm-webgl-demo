module MainView exposing (..)

import MainTypes exposing (Model, Msg(..))
import WebGLScene
import WebGL exposing (Entity, entity)
import Html exposing (Html, input)
import Html.Attributes exposing (width, height, style, type_)
import Html.Events exposing (onClick)


view =
    (\model ->
        Html.div []
            [ ((WebGL.toHtml [ width 400, height 400 ]) (WebGLScene.scene model.x model.y))
            , input [ type_ "checkbox", onClick Spin ] []
            ]
    )
