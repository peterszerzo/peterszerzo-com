module Subscriptions exposing (..)

import Window
import Router
import Time exposing (Time, every, millisecond)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Constants
import AnimationFrame


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes Resize
        , case model.route of
            Router.Home ->
                AnimationFrame.times AnimationTick

            _ ->
                every Constants.tick Tick
        ]
