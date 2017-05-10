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


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ display block
        , margin2 (px 40) auto
        , padding (px 20)
        , maxWidth (px 640)
        , width (pct 100)
        , textDecoration none
        , textAlign left
        , color currentColor
        , Mixins.regularTransition
        , border3 (px 1) solid transparent
        , firstOfType
            [ marginTop (px 0)
            ]
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
        , hover [ border3 (px 1) solid lightGrey ]
        ]
    , mediaQuery desktop
        [ class Root
            [ margin2 (px 80) auto
            , padding (px 40)
            ]
        ]
    , class Image
        [ width (pct 100)
        , marginBottom (Css.rem 1)
        , paddingTop (pct 62.5)
        , property "border" "1px solid rgba(0, 0, 0, .2)"
        , backgroundSize cover
        , backgroundRepeat noRepeat
        , property "background-position" "50% 50%"
        ]
    ]
        |> namespace cssNamespace
