module Main.Messages exposing (..)

import Routes.Models exposing (Route)

type Msg =
  ToggleMode |
  ChangeRoute Route
