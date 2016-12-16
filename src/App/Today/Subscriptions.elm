module Today.Subscriptions exposing (..)

import AnimationFrame exposing (times)
import Today.Messages exposing (Msg(..))
import Today.Models exposing (Model)
import Today.Ports exposing (receiveDeeds)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ times Tick
        , receiveDeeds ReceiveDeeds
        ]
