module Subscriptions exposing (..)

import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Today.Subscriptions
import Router


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every (1000 * millisecond) Tick
        , (case model.route of
            Router.Today today ->
                Today.Subscriptions.subscriptions today
                    |> Sub.map TodayMsg

            _ ->
                Sub.none
          )
        ]
