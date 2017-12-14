module Views.Switch exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onClick)
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)


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
        , div [ localClass [ Fill ] ] []
        ]


cssNamespace : String
cssNamespace =
    "Switch"


type CssClasses
    = Root
    | Button
    | Left
    | Right
    | Fill


( localClass, localClassList ) =
    Html.CssHelpers.withNamespace cssNamespace
        |> (\c -> ( c.class, c.classList ))


styles : List Css.Snippet
styles =
    [ class Root
        [ display inlineBlock
        , width (px 28)
        , height (px 16)
        , borderRadius (px 8)
        , overflow hidden
        , opacity (num 1)
        , position relative
        , property "transition" "opacity .3s"
        , borderColor black
        , property "border-width" "1px"
        , borderStyle solid
        ]
    , each [ class Button, class Fill ]
        [ property "transition" "transform .3s"
        ]
    , class Button
        [ width (px 16)
        , height (px 16)
        , borderRadius (pct 50)
        , boxSizing borderBox
        , border3 (px 1) solid black
        , backgroundColor white
        , position absolute
        , top (px -1)
        , left (px -1)
        , transform (translate3d (px 0) (px 0) (px 0))
        , property "z-index" "1"
        ]
    , class Fill
        [ width (px 30)
        , height (px 16)
        , backgroundColor black
        , position absolute
        , top (px 0)
        , left (px -22)
        , property "z-index" "0"
        ]
    , class Left
        [ descendants
            [ each [ class Button, class Fill ] []
            ]
        ]
    , class Right
        [ descendants
            [ each [ class Button, class Fill ]
                [ transform (translate3d (px 12) (px 0) (px 0))
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
