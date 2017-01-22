module Subscriptions exposing (..)

import Window
import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)
import AnimationFrame exposing (times)
import Router


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every (1000 * millisecond) Tick
        , Window.resizes Resize
        , if (model.route == Router.Home) then
            (times AnimationTick)
          else
            Sub.none
        ]
