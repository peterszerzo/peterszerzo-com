module Main.Messages exposing (..)

import Time exposing (Time)
import Notification.Messages
import Routes.Models exposing (Route)

type Msg =
  ToggleMode |
  Notification Notification.Messages.Msg |
  ChangeRoute Route |
  Tick Time
