module Views.Switch.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)


cssNamespace : String
cssNamespace =
    "switch"


type CssClasses
    = Root
    | Button
    | Left
    | Right


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


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
