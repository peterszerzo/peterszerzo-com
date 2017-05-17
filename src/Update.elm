module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation exposing (..)
import Ports
import Constants


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleQuirky ->
            ( { model | isQuirky = not model.isQuirky }
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
                | time = model.time + Constants.tick
              }
            , Cmd.none
            )

        AnimationTick time ->
            let
                direction =
                    (model.time - Constants.transitionStartingAt)
                        / Constants.transitionEvery
                        |> floor
                        |> (\i ->
                                if rem i 2 == 0 then
                                    1
                                else
                                    -1
                           )
            in
                ( { model
                    | transitionFactor =
                        clamp 0 1 (model.transitionFactor + direction * 0.008)
                  }
                , Cmd.none
                )
