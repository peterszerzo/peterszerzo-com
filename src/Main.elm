module Main exposing (..)

import Task
import AnimationFrame
import Window
import Constants
import Time
import Navigation exposing (Location, programWithFlags)
import Messages exposing (Msg(..))
import Data.AppTime as AppTime
import Data.State exposing (State)
import Ports
import Views exposing (view)
import Data.Flags exposing (Flags)
import Router exposing (Route, parse)
import Window


init : Flags -> Location -> ( State, Cmd Msg )
init { isNotificationRecentlyDismissed, isDev } location =
    ( State
        (parse location)
        False
        AppTime.init
        isNotificationRecentlyDismissed
        isDev
        (Window.Size 0 0)
    , Task.perform Resize Window.size
    )


main : Program Flags State Msg
main =
    programWithFlags
        (ChangeRoute << parse)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> State -> ( State, Cmd Msg )
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


subscriptions : State -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes Resize
        , case model.route of
            Router.Home ->
                AnimationFrame.times AnimationTick

            _ ->
                Time.every Constants.tick Tick
        ]
