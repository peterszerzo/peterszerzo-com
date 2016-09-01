module Main.Subscriptions exposing (..)

import Time exposing (Time, every, millisecond)
import Main.Messages exposing (Msg(..))
import Main.Models exposing (Model)

subscriptions : Model -> Sub Msg
subscriptions model =
  every (1000 * millisecond) Tick
