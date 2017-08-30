module Main exposing (..)

import AnimationFrame
import Window
import Constants
import Time
import Navigation exposing (Location, programWithFlags)
import Messages exposing (Msg(..))
import Models.AppTime as AppTime
import Ports
import Views exposing (view)
import Models exposing (Model, Flags)
import Router exposing (Route, parse)


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    Models.init flags (parse location)


main : Program Flags Model Msg
main =
    programWithFlags
        (ChangeRoute << parse)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

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
                | time = AppTime.set time model.time
              }
            , Cmd.none
            )

        AnimationTick time ->
            ( { model
                | time = AppTime.set time model.time
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes Resize
        , case model.route of
            Router.Home ->
                AnimationFrame.times AnimationTick

            _ ->
                Time.every Constants.tick Tick
        ]
