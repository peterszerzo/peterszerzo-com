module Subscriptions exposing (..)

import Window
import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Constants
import AnimationFrame


floatRem : Float -> Float -> Float
floatRem a b =
    (a / b) - (a / b |> floor |> toFloat)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every Constants.tick Tick
        , Window.resizes Resize
        , if (floatRem (model.time - Constants.transitionStartingAt) Constants.transitionEvery) < 0.2 then
            AnimationFrame.times AnimationTick
          else
            Sub.none
        ]
