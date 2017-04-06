module Views.Switch exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Models exposing (Model, SwitchPosition(..))


view : SwitchPosition -> msg -> Html msg
view model handleClick =
    let
        className =
            case model of
                Left ->
                    "Switch SwitchLeft"

                Center ->
                    "Switch"

                Right ->
                    "Switch SwitchRight"
    in
        div
            [ class className
            , onClick handleClick
            ]
            [ div [ class "SwitchButton" ] []
            ]
