module Messages exposing (..)

import Time exposing (Time)
import Notification.Messages
import Router exposing (Route)


type Msg
    = ToggleMode
    | NotificationMsg Notification.Messages.Msg
    | ToggleMobileNav
    | ChangePath String
    | Tick Time
    | ChangeRoute Route
