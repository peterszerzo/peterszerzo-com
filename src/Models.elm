module Models exposing (..)

import Task
import Messages exposing (Msg(..))
import Router exposing (Route(..))
import Window
import Models.AppTime as AppTime


type alias Model =
    { route : Route
    , isQuirky : Bool
    , time : AppTime.AppTime
    , isNotificationDismissed : Bool
    , isDev : Bool
    , window : Window.Size
    }


init : Flags -> Route -> ( Model, Cmd Msg )
init { isNotificationRecentlyDismissed, isDev } route =
    ( Model route False AppTime.init isNotificationRecentlyDismissed isDev (Window.Size 0 0)
    , Task.perform Resize Window.size
    )


type alias Project =
    { id : String
    , title : String
    , description : String
    , roles : List String
    , technologies : List String
    , url : String
    , imageUrl : String
    , gifUrl : String
    }


type alias Flags =
    { isNotificationRecentlyDismissed : Bool
    , isDev : Bool
    }
