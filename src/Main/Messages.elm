module Main.Messages exposing (..)

import Time exposing (Time)
import Routes.Models exposing (Route)

type Msg =
  ToggleMode |
  ToggleNotification |
  ChangeRoute Route |
  Tick Time
