module Main.Models exposing (..)

import Data.Markdown exposing (notificationText)
import Routes.Models exposing (Route(..))
import Notification.Models

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , time : Float
  , isMobileNavDisplayed : Bool
  , notification : Notification.Models.Model
  }

init =
  (Model Home Conventional 0 False (Notification.Models.init), Cmd.none)

initWithRouteResult route =
  (Model route Conventional 0 False (Notification.Models.init), Cmd.none)
