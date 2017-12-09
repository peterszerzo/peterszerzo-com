module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window
import Json.Decode as Decode


type Msg
    = NoOp
    | ToggleQuirky
    | ChangePath String
    | ChangeRoute Route
    | DismissNotification
    | Tick Time
    | AnimationTick Time
    | Resize Window.Size
    | PackLayoutResponse Decode.Value
