module Models exposing (..)

import Notification.Models
import MobileNav.Models
import Messages exposing (Msg)
import Router exposing (Route)

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
  let
    mobileNav = MobileNav.Models.init
    notification = Notification.Models.init isNotificationDismissed
  in
    ( Model route Conventional 0 mobileNav notification
    , Cmd.none
    )
