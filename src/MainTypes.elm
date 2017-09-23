module MainTypes exposing (..)

import Keyboard
import Time

type alias Model =
    { x : Float
    , y : Float
    , spin : Bool
    }

type Msg
    = AnimMsg Time.Time
    | KeyMsg Keyboard.KeyCode
    | Spin
