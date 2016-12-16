module Subscriptions exposing (..)

import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Today.Subscriptions
import Map.Subscriptions
import Router


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every (1000 * millisecond) Tick
        , (case model.route of
            Router.Today today ->
                Today.Subscriptions.subscriptions today
                    |> Sub.map TodayMsg

            Router.Map map ->
                Map.Subscriptions.subscriptions map
                    |> Sub.map MapMsg

            _ ->
                Sub.none
          )
        ]
