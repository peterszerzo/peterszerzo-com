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
                ( { model | mode = newMode }
                , Cmd.none
                )

        DismissNotification ->
            ( { model | isNotificationDismissed = True }
            , Ports.notificationDismissed ()
            )

        ChangePath newPath ->
            ( model
            , Navigation.newUrl ("/" ++ newPath)
            )

        ChangeRoute newRoute ->
            ( { model | route = newRoute }
            , Cmd.none
            )

        Resize window ->
            ( { model | window = window }
            , Cmd.none
            )

        Tick time ->
            ( { model
                | time = model.time + 1
              }
            , Cmd.none
            )
