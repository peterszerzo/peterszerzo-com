module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)


type Msg
    = ToggleMode
    | ToggleMobileNav
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
    | DismissNotification
