module Views.TextBox.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "textbox"


type CssClasses
    = Root
    | Hidden
    | DisplayPrimary
    | DisplaySecondary
    | Content
    | Contents
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
        , color darkGrey
        , width (pct 100)
        , height (pct 100)
        , position fixed
        , left (px 0)
        , Mixins.zIndex 14
        , Mixins.regularTransition
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
        , position absolute
        , top (px 0)
        , left (px 0)
        , padding2 (px 40) (px 0)
        , overflowY scroll
        , property "-webkit-overflow-scrolling" "touch"
        , margin auto
        , Mixins.regularTransition
        ]
    , class Switch
        [ position fixed
        , bottom (px 15)
        , left (px 15)
        , Mixins.zIndex 3
        ]
    , class SwitchHidden
        [ display none
        ]
    ]
        |> namespace cssNamespace
