module Main exposing (..)

import Navigation exposing (programWithFlags)

import Messages
import Views exposing (view)
import Models
import Subscriptions exposing (subscriptions)
import Update exposing (update)

import Routes.Matching exposing (routeFromResult, parser)
import Routes.Models

initWithRoute : Models.Flags -> Result a Routes.Models.Route -> (Models.Model, Cmd Messages.Msg)
initWithRoute flags result =
  routeFromResult result
    |> Models.init flags

urlUpdate : Result a Routes.Models.Route -> Models.Model -> (Models.Model, Cmd Messages.Msg)
urlUpdate result model =
  ({model | route = (routeFromResult result)}, Cmd.none)

main : Program Models.Flags
main =
  programWithFlags parser
    { init = initWithRoute
    , view = view
    , update = update
    , subscriptions = subscriptions
    , urlUpdate = urlUpdate
    }
