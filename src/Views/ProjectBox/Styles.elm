module Views.ProjectBox.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "projectBox"


type CssClasses
    = Root
    | Content


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
        ]
    , class Content
        [ width (pct 100)
        , height (pct 100)
        , overflowY scroll
        , property "-webkit-overflow-scrolling" "touch"
        , padding3 (px 100) (px 40) (px 60)
        ]
    ]
        |> namespace cssNamespace
