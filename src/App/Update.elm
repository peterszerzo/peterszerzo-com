module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Mode(..))
import Navigation exposing (..)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
