module Main.Models exposing (..)

import Routes.Models exposing (Route(..))

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  }

init =
  (Model Home Conventional, Cmd.none)

initWithRouteResult route =
  (Model route Conventional, Cmd.none)
