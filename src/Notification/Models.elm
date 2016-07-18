module Notification.Models exposing (..)

import Data.Markdown exposing (notificationText)

type alias Model =
  { text : String
  , isVisible : Bool
  , timeSinceVisible : Float
  }

init =
  Model notificationText True 0
