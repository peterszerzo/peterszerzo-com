module Models exposing (..)

import Task
import Time
import Messages exposing (Msg(..))
import Router exposing (Route(..))
import Window


type alias Model =
    { route : Route
    , isQuirky : Bool
    , time : Time.Time
    , isNotificationDismissed : Bool
    , isDev : Bool
    , window : Window.Size
    , transitionFactor : Float
    }


init : Flags -> Route -> ( Model, Cmd Msg )
init { isNotificationRecentlyDismissed, isDev } route =
    ( Model route False 0 isNotificationRecentlyDismissed isDev (Window.Size 0 0) 0
    , Task.perform Resize Window.size
    )


type alias Project =
    { id : String
    , title : String
    , description : String
    , category : ProjectCategory
    , roles : List String
    , technologies : List String
    , url : String
    , imageUrl : String
    , gifUrl : String
    }


type ProjectCategory
    = Featured
    | Side
    | Archive


type alias Flags =
    { isNotificationRecentlyDismissed : Bool
    , isDev : Bool
    }


type SwitchPosition
    = Left
    | Center
    | Right
