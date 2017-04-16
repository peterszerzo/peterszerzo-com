module Main exposing (..)

import Navigation exposing (Location, programWithFlags)
import Messages exposing (Msg(..))
import Views.Main exposing (view)
import Models exposing (Model, Flags)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
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
