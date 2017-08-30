module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window


type Msg
    = NoOp
    | ToggleQuirky
    | ChangePath String
    | ChangeRoute Route
    | DismissNotification
    | Tick Time
    | AnimationTick Time
    | Resize Window.Size
