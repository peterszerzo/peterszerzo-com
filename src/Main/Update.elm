module Main.Update exposing (..)

import Main.Messages exposing (..)
import Main.Models exposing (..)

update msg model =
  case msg of
    ToggleMode -> ({model | mode = if model.mode == Conventional then Real else Conventional}, Cmd.none)
