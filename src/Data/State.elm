module Data.State exposing (..)

import Data.AppTime as AppTime
import Data.PackBubble as PackBubble
import Window
import Router exposing (Route)


type alias State =
    { route : Route
    , isQuirky : Bool
    , time : AppTime.AppTime
    , isNotificationDismissed : Bool
    , isDev : Bool
    , window : Window.Size
    , projectPackBubbles : List PackBubble.PackBubble
    , activeProject : Maybe String
    }
