module Main.Models exposing (..)

import Routes.Models exposing (Route(..))

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , notificationText : String
  , isNotificationVisible : Bool
  , time : Float
  }

notificationText = "Hey - bear with me while I'm being built :)"

init =
  (Model Home Conventional notificationText True 0, Cmd.none)

initWithRouteResult route =
  (Model route Conventional notificationText True 0, Cmd.none)
