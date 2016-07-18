module Main.Models exposing (..)

import Data.Markdown exposing (notificationText)
import Routes.Models exposing (Route(..))
import Notification.Models

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , notification : Notification.Models.Model
  , time : Float
  }

init =
  (Model Home Conventional (Notification.Models.init) 0, Cmd.none)

initWithRouteResult route =
  (Model route Conventional (Notification.Models.init) 0, Cmd.none)
