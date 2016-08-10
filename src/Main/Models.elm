module Main.Models exposing (..)

import Routes.Models exposing (Route(..))
import Notification.Models
import MobileNav.Models
import Main.Messages exposing (Msg)

type alias DisplayNotification = Bool
type alias Flags = DisplayNotification

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  , time : Float
  , mobileNav : MobileNav.Models.Model
  , notification : Notification.Models.Model
  }

init : Flags -> Route -> (Model, Cmd Msg)
init flags route =
  (Model route Conventional 0 (MobileNav.Models.init) (Notification.Models.init), Cmd.none)
