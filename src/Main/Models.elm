module Main.Models exposing (..)

import Routes.Models exposing (Route(..))

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , notificationText : String
  , isNotificationVisible : Bool
  }

notificationText = "Hey - bear with me while I'm being built :)"

init =
  (Model Home Conventional notificationText True, Cmd.none)

initWithRouteResult route =
  (Model route Conventional notificationText True, Cmd.none)
