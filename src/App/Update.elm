module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Mode(..))
import Navigation exposing (..)
import Ports
import Router
import Today.Update
import Map.Update
import Today.Messages
import Map.Messages


updateMap_ : Map.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateMap_ msg model =
    case model.route of
        Router.Map today ->
            Map.Update.update msg today
                |> (\( md, cmd ) -> ( { model | route = Router.Map md }, Cmd.map MapMsg cmd ))

        _ ->
            ( model, Cmd.none )


updateMap : Map.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateMap msg model =
    Map.Messages.navigate msg
        |> Maybe.map (\str -> model ! [ Navigation.newUrl str ])
        |> Maybe.withDefault (updateMap_ msg model)


updateToday_ : Today.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateToday_ msg model =
    case model.route of
        Router.Today today ->
            Today.Update.update msg today
                |> (\( md, cmd ) -> ( { model | route = Router.Today md }, Cmd.map TodayMsg cmd ))

        _ ->
            ( model, Cmd.none )


updateToday : Today.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateToday msg model =
    Today.Messages.navigate msg
        |> Maybe.map (\str -> model ! [ Navigation.newUrl str ])
        |> Maybe.withDefault (updateToday_ msg model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodayMsg msg ->
            updateToday msg model

        MapMsg msg ->
            updateMap msg model

        ToggleMode ->
            let
                newMode =
                    if model.mode == Conventional then
                        Real
                    else
                        Conventional
            in
                { model | mode = newMode } ! []

        DismissNotification ->
            { model | isNotificationDismissed = True } ! [ Ports.notificationDismissed () ]

        ToggleMobileNav ->
            { model | isMobileNavActive = not model.isMobileNavActive } ! []

        ChangePath newPath ->
            ( model
            , Navigation.newUrl ("/" ++ newPath)
            )

        ChangeRoute newRoute ->
            { model | route = newRoute } ! []

        Tick time ->
            { model
                | time = model.time + 1
            }
                ! []
