module Main exposing (..)

import Main.Views exposing (view)
import Main.Models exposing (init)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Html.App exposing (program)

main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
