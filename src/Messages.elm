module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window


type Msg
    = ToggleQuirky
    | ChangePath String
    | ChangeRoute Route
    | DismissNotification
    | Tick Time
    | AnimationTick Time
    | Resize Window.Size
