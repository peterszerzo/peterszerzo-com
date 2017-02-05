module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window


type Msg
    = ToggleMode
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
    | DismissNotification
    | Resize Window.Size
