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
        ]


cssNamespace : String
cssNamespace =
    "switch"


type CssClasses
    = Root
    | Button
    | Left
    | Right


( localClass, localClassList ) =
    Html.CssHelpers.withNamespace cssNamespace
        |> (\c -> ( c.class, c.classList ))


styles : List Css.Snippet
styles =
    [ class Root
        [ display inlineBlock
        , width (px 26)
        , height (px 12)
        , borderRadius (px 6)
        , opacity (num 1)
        , position relative
        , property "transition" "opacity .3s"
        , borderColor blue
        , property "border-width" "1px"
        , borderStyle solid
        ]
    , class Button
        [ width (px 12)
        , height (px 12)
        , borderRadius (px 6)
        , backgroundColor blue
        , position absolute
        , top (px -1)
        , left (px -1)
        , transform (translate3d (px 0) (px 0) (px 0))
        , property "transition" "transform .3s"
        ]
    , class Left
        [ descendants
            [ class Button []
            ]
        ]
    , class Right
        [ descendants
            [ class Button
                [ transform (translate3d (px 14) (px 0) (px 0))
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
