module Views.Menu.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "menu"


type CssClasses
    = Root
    | Links
    | Link


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ position fixed
        , width (pct 100)
        , height (pct 100)
        , top (px 0)
        , left (px 0)
        , property "background-color" "rgba(255, 255, 255, .95)"
        , transform (translate3d (px 0) (px 0) (px 0))
        , property "transition" "transform .3s"
        , Mixins.zIndex 15
        ]
    , class Links
        [ display block
        , position absolute
        , top (pct 50)
        , left (pct 50)
        , transform (translate3d (pct -50) (pct -50) (px 0))
        , height auto
        , textAlign center
        ]
    , class Link
        [ cursor pointer
        , display block
        , color blue
        , padding2 (px 10) (px 0)
        , property "text-decoration" "none"
        , property "font-weight" "300"
        , letterSpacing (Css.rem 0.1)
        , fontSize (Css.rem 1.5)
        ]
    ]
        |> namespace cssNamespace
