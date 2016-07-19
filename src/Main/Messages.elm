module Main.Messages exposing (..)

import Time exposing (Time)
import Notification.Messages
import Routes.Models exposing (Route)

type Msg =
  ToggleMode |
  NotificationMsg Notification.Messages.Msg |
  ToggleMobileNav |
  ChangeRoute Route |
  Tick Time
