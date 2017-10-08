module MainState exposing (..)

import MainTypes exposing (Model, Msg(..))
import AnimationFrame
import Keyboard
import TextureExample

init =
  let (textureModel, textureCmd) = TextureExample.init
  in
    ( { x = 0
      , y = 0
      , spin = False
      , textureExample =  textureModel}
    , --Cmd.none )
      Cmd.map MsgTextureExample textureCmd)

--(\model -> AnimationFrame.diffs Basics.identity) AnimMsg
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs AnimMsg
        , Keyboard.downs KeyMsg
        --, Cmd.map MsgTextureExample (TextureExample.subscriptions)
        --, TextureExample.subscriptions
        , Sub.map MsgTextureExample (TextureExample.subscriptions model.textureExample)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimMsg dt ->
            ( updateAnimMsg model dt, Cmd.none )
        KeyMsg code ->
            ( updateKeyMsg model code, Cmd.none )
        Spin ->
            ( { model | spin = not model.spin }, Cmd.none )
        MsgTextureExample msg ->
            --( model , Cmd.none )
            let (textureExampleModel, textureExampleMessage) = TextureExample.update msg model.textureExample
            in
            ( {model | textureExample = textureExampleModel} , Cmd.none )


updateAnimMsg model dt =
    case model.spin of
        True ->
            { model
                | x = (model.x + (dt) / 5000)
                , y = (model.y + (dt) / 10000) }
        False ->
          model


updateKeyMsg model code =
    case code of
        37 ->  --left
            { model | x = model.x - 0.01 }
        39 -> --right
            { model | x = model.x + 0.01 }
        38 -> --Up
            { model | y = model.y - 0.01 }
        40 -> --Down
            { model | y = model.y + 0.01 }
        _ ->
            model
