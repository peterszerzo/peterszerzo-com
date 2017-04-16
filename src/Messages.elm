module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Window


type Msg
    = ToggleQuirky
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
    | DismissNotification
    | Resize Window.Size
