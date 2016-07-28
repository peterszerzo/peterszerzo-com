module Notification.Models exposing (..)

import Data.Markdown exposing (notificationText)

type alias Model =
  { text : String
  , isVisible : Bool
  , isDismissed : Bool
  }

init =
  Model notificationText False False
