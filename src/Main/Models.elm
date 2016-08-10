module Main.Models exposing (..)

import Routes.Models exposing (Route(..))
import Notification.Models
import MobileNav.Models
import Main.Messages exposing (Msg)

type alias IsNotificationDismissed = Bool
type alias Flags = IsNotificationDismissed

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , time : Float
  , mobileNav : MobileNav.Models.Model
  , notification : Notification.Models.Model
  }

init : Flags -> Route -> (Model, Cmd Msg)
init isNotificationDismissed route =
  (Model route Conventional 0 (MobileNav.Models.init) (Notification.Models.init isNotificationDismissed), Cmd.none)
