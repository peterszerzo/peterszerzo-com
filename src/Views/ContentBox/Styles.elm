module Views.ContentBox.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (h2)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "contentbox"


type CssClasses
    = Root
    | Hidden
    | DisplayPrimary
    | DisplaySecondary
    | Content
    | Contents
    | BackLink
    | Switch
    | SwitchHidden


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ backgroundColor white
        , textAlign center
        , color darkGrey
        , width (pct 100)
        , height (pct 100)
        , position fixed
        , left (px 0)
        , Mixins.zIndex 14
        , Mixins.regularTransition
        , descendants
            [ h2
                [ textAlign center
                ]
            ]
        ]
    , class Hidden
        [ opacity (num 0)
        , Mixins.pointerEventsNone
        ]
    , class DisplayPrimary
        [ descendants
            [ class Content
                [ nthOfType "2"
                    [ opacity (num 0)
                    , Mixins.pointerEventsNone
                    ]
                ]
            ]
        ]
    , class DisplaySecondary
        [ descendants
            [ class Content
                [ nthOfType "1"
                    [ opacity (num 0)
                    , Mixins.pointerEventsNone
                    ]
                ]
            ]
        ]
    , class Contents
        [ height (pct 100)
        ]
    , class Content
        [ width (pct 100)
        , height (pct 100)
        , padding2 (px 40) (px 20)
        , position absolute
        , top (px 0)
        , left (px 0)
        , overflowY scroll
        , property "-webkit-overflow-scrolling" "touch"
        , margin auto
        , Mixins.regularTransition
        ]
    , mediaQuery desktop
        [ class Content
            [ padding2 (px 80) (px 20)
            ]
        ]
    , each [ class Switch, class BackLink ]
        [ width (px 60)
        , height (px 60)
        , padding (px 15)
        , left (px 0)
        , Mixins.zIndex 3
        , opacity (num 0.6)
        , property "transition" "opacity 0.3s"
        , position fixed
        , cursor pointer
        , hover
            [ opacity (num 1)
            ]
        ]
    , class Switch
        [ bottom (px 0)
        , children
            [ everything
                [ top (pct 50)
                , transform (translate3d (px 0) (pct -50) (px 0))
                ]
            ]
        ]
    , class BackLink
        [ property "stroke" "#15487F"
        ]
    , class SwitchHidden
        [ display none
        ]
    ]
        |> namespace cssNamespace
