module MainView exposing (..)

import MainTypes exposing (Model, Msg(..))
import WebGLScene
import WebGL
import Html exposing (Html, input)
import Html.Attributes exposing (width, height, type_)
import Html.Events exposing (onClick)
import TextureExample

{-}
view =
    (\model ->
        Html.div []
            [ ((WebGL.toHtml [ width 400, height 400 ]) (WebGLScene.scene model.x model.y))
            , input [ type_ "checkbox", onClick Spin ] []
            ]
    )
-}


view =

    (\model ->
        Html.div []
        [Html.map MsgTextureExample (TextureExample.view model.textureExample)]
    )
