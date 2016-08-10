module Main exposing (..)

import Navigation exposing (programWithFlags)

import Main.Views exposing (view)
import Main.Models exposing (..)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)

import Routes.Matching exposing (routeFromResult, parser)

initWithRoute flags result =
  routeFromResult result
    |> Main.Models.init flags

urlUpdate result model =
  ({model | route = (routeFromResult result)}, Cmd.none)

main =
  programWithFlags parser
    { init = initWithRoute
    , view = view
    , update = update
    , subscriptions = subscriptions
    , urlUpdate = urlUpdate
    }
