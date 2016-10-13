module Main exposing (..)

import Navigation exposing (programWithFlags)

import Messages
import Views exposing (view)
import Models
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Router

initWithRoute : Models.Flags -> Result a Router.Route -> (Models.Model, Cmd Messages.Msg)
initWithRoute flags result =
  Router.routeFromResult result
    |> Models.init flags

urlUpdate : Result a Router.Route -> Models.Model -> (Models.Model, Cmd Messages.Msg)
urlUpdate result model =
  ({model | route = (Router.routeFromResult result)}, Cmd.none)

main : Program Models.Flags
main =
  programWithFlags Router.parser
    { init = initWithRoute
    , view = view
    , update = update
    , subscriptions = subscriptions
    , urlUpdate = urlUpdate
    }
