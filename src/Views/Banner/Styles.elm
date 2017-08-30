module Views.Banner.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (div, svg)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "banner"


type CssClasses
    = Root
    | Content
    | Logo
    | Subtitle


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


styles : List Css.Snippet
styles =
    [ class Root
        [ displayFlex
        , alignItems center
        , justifyContent center
        , position relative
        , width (pct 100)
        , height (pct 100)
        , Mixins.zIndex 10
        ]
    , class Content
        [ color white
        , textAlign center
        , maxWidth (px 300)
        , transform (translate3d (px 0) (px -50) (px 0))
        ]
    , class Logo
        [ width (px 150)
        , height (px 150)
        , position relative
        , margin3 auto auto (px 15)
        , children
            [ svg
                [ property "stroke" "white"
                ]
            , div
                [ property "background-image" "url(/imgs/portrait-360.jpg)"
                , property "background-size" "cover"
                , property "background-position" "50% 50%"
                , position absolute
                , top (px 0)
                , left (px 0)
                , width (pct 100)
                , height (pct 100)
                , borderRadius (pct 50)
                , opacity (num 0)
                , Mixins.regularTransition
                ]
            ]
        , hover
            [ children
                [ div
                    [ opacity (num 1)
                    ]
                ]
            ]
        ]
    , class Subtitle
        [ width (px 220)
        ]
    , mediaQuery desktop
        [ class Logo
            [ width (px 180)
            , height (px 180)
            ]
        , class Content
            [ transform (translate3d (px 0) (px 0) (px 0))
            ]
        ]
    ]
        |> namespace cssNamespace
