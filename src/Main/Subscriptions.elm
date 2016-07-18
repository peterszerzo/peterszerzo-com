module Main.Subscriptions exposing (..)

import Time exposing (..)
import Main.Messages exposing (..)

subscriptions model =
  every (1000 * millisecond) Tick
