module Main exposing (..)

import Main.Views exposing (view)
import Main.Models exposing (..)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
-- import Html.App exposing (program)
import Navigation exposing (program)

import Routes.Matching exposing (routeFromResult, parser)

initWithRoute result =
  routeFromResult result
    |> Main.Models.initWithRouteResult

urlUpdate result model =
  ({model | route = (routeFromResult result)}, Cmd.none)

main =
  program parser
    { init = initWithRoute
    , view = view
    , update = update
    , subscriptions = subscriptions
    , urlUpdate = urlUpdate
    }
