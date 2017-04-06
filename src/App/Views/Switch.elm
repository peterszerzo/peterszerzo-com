module Views.Switch exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)


view : Bool -> msg -> Html msg
view isRight handleClick =
    div
        [ classList [ ( "Switch", True ), ( "SwitchRight", isRight ) ]
        , onClick handleClick
        ]
        [ div [ class "SwitchButton" ] []
        ]
