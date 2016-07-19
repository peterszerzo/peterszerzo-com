module Main.Models exposing (..)

import Data.Markdown exposing (notificationText)
import Routes.Models exposing (Route(..))
import Notification.Models
import MobileNav.Models

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , time : Float
  , mobileNav : MobileNav.Models.Model
  , notification : Notification.Models.Model
  }

init =
  (Model Home Conventional 0 (MobileNav.Models.init) (Notification.Models.init), Cmd.none)

initWithRouteResult route =
  (Model route Conventional 0 (MobileNav.Models.init) (Notification.Models.init), Cmd.none)
