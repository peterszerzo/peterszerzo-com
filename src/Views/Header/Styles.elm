module Views.Header.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "header"


type CssClasses
    = Root
    | Discrete
    | Icon
    | Falafel
    | Logo
    | DesktopLinks
    | DesktopLink
    | DesktopLinkActive


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ width (pct 100)
        , height (px 60)
        , displayFlex
        , position absolute
        , top (px 0)
        , left (px 0)
        , color blue
        , Mixins.zIndex 16
        ]
    , class Discrete
        [ property "border" "none"
        , property "background" "transparent"
        , property "transition" "none"
        , color white
        ]
    , mediaQuery desktop
        [ class Root
            ([ property "background" "rgba(255, 255, 255, .6)" ]
                ++ Mixins.standardShadow
            )
        , class Discrete
            [ color black
            , top auto
            , bottom (px 24)
            , property "background" "none"
            , property "border" "none"
            , property "box-shadow" "none"
            ]
        ]
    , class Icon
        [ cursor pointer
        , width (px 60)
        , height (px 60)
        , padding (px 18)
        , position absolute
        , top (px 0)
        , fill currentColor
        , property "stroke" "currentColor"
        , Mixins.regularTransition
        , opacity (num 0.7)
        , hover
            [ opacity (num 1)
            ]
        ]
    , class Falafel
        [ right (px 0)
        ]
    , mediaQuery desktop
        [ class Falafel
            [ display none
            ]
        ]
    , class Logo
        [ left (px 0)
        ]
    , class Discrete
        [ descendants
            [ class Logo
                [ display none
                ]
            ]
        ]
    , class DesktopLinks
        [ width (pct 100)
        , display none
        , paddingTop (px 17)
        , textAlign center
        ]
    , mediaQuery desktop
        [ class DesktopLinks
            [ display block
            ]
        ]
    , class DesktopLink
        [ color currentColor
        , display inlineBlock
        , cursor pointer
        , position relative
        , padding2 (px 4) (px 12)
        , borderRadius (px 3)
        , opacity (num 0.6)
        , fontSize (Css.rem 1)
        , letterSpacing (Css.rem 0.05)
        , property "font-kerning" "normal"
        , margin2 (px 0) (px 10)
        , property "transition" "all .3s"
        , hover
            [ opacity (num 1)
            ]
        ]
    , class DesktopLinkActive
        [ opacity (num 1)
        ]
    , class Discrete
        [ descendants
            [ class DesktopLink
                [ color white
                , property "background-color" "rgba(255, 255, 255, .1)"
                , hover
                    [ color blue
                    , property "background-color" "rgba(255, 255, 255, 1)"
                    ]
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
