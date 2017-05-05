module Views.Notification.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (p, a, div, svg)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "notification"


type CssClasses
    = Root
    | Visible
    | Body
    | Close


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        ([ position fixed
         , backgroundColor mustard
         , bottom (px 40)
         , property "width" (Mixins.calcPctMinusPx 100 80)
         , height auto
         , right (px 40)
         , borderRadius (px 3)
         , Mixins.zIndex 20
         , opacity (num 0)
         , property "transition" "all 1s"
         , Mixins.pointerEventsNone
         ]
            ++ Mixins.standardShadow
        )
    , mediaQuery desktop
        [ class Root
            [ width (px 280) ]
        ]
    , class Body
        [ padding4 (px 20) (px 60) (px 20) (px 20)
        , textAlign left
        , margin auto
        , color white
        , fontSize (Css.rem 1)
        , letterSpacing (Css.rem 0.04)
        , descendants
            [ p
                [ fontSize inherit
                , margin (px 0)
                , padding (px 0)
                , Mixins.lineHeight 1.35
                ]
            , a
                [ fontSize inherit
                , color inherit
                , borderBottom3 (px 1) solid white
                ]
            ]
        ]
    , class Close
        [ width (px 48)
        , height (px 48)
        , padding (px 16)
        , display inlineBlock
        , position absolute
        , top (px 0)
        , right (px 0)
        , margin (px 0)
        , Mixins.regularTransition
        , descendants
            [ svg
                [ width (pct 100)
                , height (pct 100)
                ]
            , selector "g"
                [ property "stroke" "white"
                ]
            ]
        , hover
            [ transform (scale 1.15)
            ]
        ]
    , class Visible
        [ opacity (num 1)
        , Mixins.pointerEventsAll
        ]
    ]
        |> namespace cssNamespace
