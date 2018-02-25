module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window
import Json.Decode as Decode


type Msg
    = NoOp
    | ToggleQuirky
    | Navigate String
    | ChangeRoute Route
    | AnimationTick Time
    | Resize Window.Size
    | PackLayoutResponse Decode.Value
