module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)


type Msg
    = ToggleMode
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
    | DismissNotification
