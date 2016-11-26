module Models exposing (..)

import Messages exposing (Msg)
import Router exposing (Route, routeDefs, parseUrlFragment)


type alias Flags =
    Bool


type Mode
    = Conventional
    | Real


type SwitchPosition
    = Left
    | Center
    | Right


type alias SubLink =
    ( String, String )


type Url
    = Internal String
    | External String


type alias Page =
    { label : String
    , url : Url
    , subLinks : List SubLink
    , conventionalContent : Maybe String
    , realContent : Maybe String
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



-- Helpers


getActivePage : List Page -> Route -> Page
getActivePage pages currentRoute =
    pages
        |> List.filter (\pg ->
              case pg.url of
                Internal str -> (parseUrlFragment routeDefs str) == currentRoute
                External str -> False
            )
        |> List.head
        |> Maybe.withDefault (Page "Dummy" (Internal "asdf") [] Nothing Nothing)
