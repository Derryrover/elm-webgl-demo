module MainState exposing (..)

import MainTypes exposing (Model, Msg(..))
import AnimationFrame
import Keyboard


init =
    ( { x = 0
      , y = 0
      , spin = False
      }
    , Cmd.none
    )



--(\model -> AnimationFrame.diffs Basics.identity) AnimMsg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs AnimMsg
        , Keyboard.downs KeyMsg
        ]


updateAnimMsg model dt =
    case model.spin of
        True ->
            ( { x = (model.x + (dt) / 5000), y = (model.y + (dt) / 10000), spin = model.spin }, Cmd.none )

        False ->
            ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimMsg dt ->
            updateAnimMsg model dt

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
