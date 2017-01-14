module Models exposing (..)

import Messages exposing (Msg)
import Router exposing (Route(..))


type alias Flags =
    Bool


type Mode
    = Conventional
    | Real


type SwitchPosition
    = Left
    | Center
    | Right


type alias Project =
    { id : String
    , title : String
    , description : String
    , url : String
    , imageUrl : String
    , gifUrl : String
    }


type alias Model =
    { route : Route
    , mode : Mode
    , time : Float
    , isMobileNavActive : Bool
    , isNotificationDismissed : Bool
    }


init : Flags -> Route -> ( Model, Cmd Msg )
init isNotificationDismissed route =
    ( Model route Conventional 0 False isNotificationDismissed
    , Cmd.none
    )
