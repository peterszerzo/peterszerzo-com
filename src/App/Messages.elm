module Messages exposing (..)

import Time exposing (Time)
import Router exposing (Route)
import Today.Messages
import Map.Messages

type Msg
    = ToggleMode
    | ToggleMobileNav
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
    | TodayMsg Today.Messages.Msg
    | MapMsg Map.Messages.Msg
    | DismissNotification
