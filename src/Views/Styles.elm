module Views.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "main"


type CssClasses
    = Root
    | Container
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
        [ width (pct 100)
        , height (pct 100)
        ]
    , class Container
        [ width (pct 100)
        , height (pct 100)
        , backgroundColor blue
        , displayFlex
        , alignItems center
        , justifyContent center
        , property "animation" "fade-in ease-out .5s"
        , position relative
        ]
    , class Content
        [ position relative
        , Mixins.zIndex 10
        ]
    ]
        |> namespace cssNamespace
