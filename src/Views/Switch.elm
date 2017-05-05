module Views.Switch exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onClick)
import Views.Switch.Styles exposing (CssClasses(..), localClass, localClassList)


view : Bool -> msg -> Html msg
view isRight handleClick =
    div
        [ localClassList
            [ ( Root, True )
            , ( Right, isRight )
            ]
        , onClick handleClick
        ]
        [ div [ localClass [ Button ] ] []
        ]
