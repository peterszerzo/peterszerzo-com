module Main.Messages exposing (..)

import Routes.Models exposing (Route)

type Msg =
  ToggleMode |
  ToggleNotification |
  ChangeRoute Route
