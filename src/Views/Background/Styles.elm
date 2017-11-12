module Views.Background.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "background"


type CssClasses
    = Root


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


styles : List Css.Snippet
styles =
    [ class Root
        [ position absolute
        , top (px 0)
        , left (px 0)
        , Mixins.zIndex 1
        , descendants
            [ selector "polygon"
                [ fill white
                , opacity (num 0.05)
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
