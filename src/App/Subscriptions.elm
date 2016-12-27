module Subscriptions exposing (..)

import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every (1000 * millisecond) Tick
        ]
