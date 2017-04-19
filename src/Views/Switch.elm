module Views.Switch exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onClick)
import Html.CssHelpers
import Styles


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""


view : Bool -> msg -> Html msg
view isRight handleClick =
    div
        [ classList
            [ ( Styles.Switch, True )
            , ( Styles.SwitchRight, isRight )
            ]
        , onClick handleClick
        ]
        [ div [ class [ Styles.SwitchButton ] ] []
        ]
