module Views.Project.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (h3, p)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "project"


type CssClasses
    = Root
    | Image
    | Title
    | Body


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
        , padding (px 20)
        , maxWidth (px 520)
        , width (pct 100)
        , textDecoration none
        , textAlign left
        , color currentColor
        , Mixins.regularTransition
        , border3 (px 1) solid transparent
        , lastOfType
            [ marginBottom (px 0)
            ]
        , descendants
            [ h3
                [ margin3 (Css.rem 1) (Css.rem 0) (Css.rem 0)
                ]
            , p
                [ marginTop (px 0)
                ]
            ]
        , hover [ property "background-color" "#f4f4f5" ]
        ]
    , mediaQuery desktop
        [ class Root
            [ padding (px 40)
            ]
        ]
    , each [ class Title, class Body ]
        [ display inlineBlock
        , margin (px 0)
        , lineHeight (num 1)
        ]
    , class Title Mixins.highlightedBodyType
    , class Body Mixins.bodyType
    , class Image
        [ width (pct 100)
        , paddingTop (pct 62.5)
        , property "border" "1px solid rgba(0, 0, 0, .2)"
        , backgroundSize cover
        , backgroundRepeat noRepeat
        , property "background-position" "50% 50%"
        ]
    ]
        |> namespace cssNamespace
