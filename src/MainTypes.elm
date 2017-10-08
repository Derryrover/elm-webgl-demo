module MainTypes exposing (..)

import Keyboard
import Time
import TextureExample

type alias Model =
    { x : Float
    , y : Float
    , spin : Bool
    , textureExample : TextureExample.Model
    }

type Msg
    = AnimMsg Time.Time
    | KeyMsg Keyboard.KeyCode
    | Spin
    | MsgTextureExample TextureExample.Action
