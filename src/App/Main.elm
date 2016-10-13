module Main exposing (..)

import Navigation exposing (programWithFlags)

import Messages exposing (Msg)
import Views exposing (view)
import Models exposing (Model, Flags)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Router exposing (Route)

initWithRoute : Flags -> Result String Route -> (Model, Cmd Msg)
initWithRoute flags result =
  Router.routeFromResult result
    |> Models.init flags

urlUpdate : Result String Route -> Model -> (Model, Cmd Msg)
urlUpdate result model =
  ( { model
        | route = (Router.routeFromResult result)
    }
  , Cmd.none)

main : Program Models.Flags
main =
  programWithFlags Router.parser
    { init = initWithRoute
    , view = view
    , update = update
    , subscriptions = subscriptions
    , urlUpdate = urlUpdate
    }
