module Models exposing (..)

import Messages exposing (Msg)
import Router exposing (Route(..))
import Content
import Today.Models


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


type StandardPage
    = SublinkPage (List ( String, String ))
    | StaticPage String (Maybe String)


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
    , getCmdOnRouteChange route
    )


getCmdOnRouteChange : Route -> Cmd Msg
getCmdOnRouteChange rt =
    case rt of
        Today today ->
            Today.Models.init
                |> Tuple.second
                |> Cmd.map Messages.TodayMsg

        _ ->
            Cmd.none



-- Helpers


standardPage : Model -> Maybe StandardPage
standardPage model =
    case model.route of
        Home ->
            Nothing

        Projects ->
            SublinkPage Content.projectLinks |> Just

        Talks ->
            SublinkPage Content.talkLinks |> Just

        Now ->
            StaticPage Content.now Nothing |> Just

        About ->
            StaticPage Content.aboutConventional (Just Content.aboutReal) |> Just

        Archive ->
            SublinkPage Content.archiveLinks |> Just

        _ ->
            Nothing
