module Views.Banner exposing (..)

import Html exposing (Html, div, h1, p, header, node)
import Html.CssHelpers
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Content
import Views.Shapes as Shapes
import Messages exposing (Msg)
import Views.Nav


view : Html Msg
view =
    div
        [ localClass [ Root ]
        ]
        [ div [ localClass [ Content ] ]
            [ div
                [ localClass [ Logo ]
                ]
                [ Shapes.logo
                , div []
                    [ h1 [ localClass [ Title ] ] [ Html.text Content.title ]
                    , p [ localClass [ Subtitle ] ] [ Html.text Content.subtitle ]
                    ]
                ]
            , Views.Nav.view
            ]
        ]


cssNamespace : String
cssNamespace =
    "Banner"


type CssClasses
    = Root
    | Content
    | Logo
    | Subtitle
    | Title


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
    , class Title
        [ margin3 (px 20) auto (px 10)
        ]
    , class Content
        [ color white
        , textAlign center
        ]
    , class Logo
        [ width (px 240)
        , height (px 240)
        , position relative
        , displayFlex
        , alignItems center
        , justifyContent center
        , borderRadius (pct 50)
        , margin3 auto auto (px 0)
        , children
            [ Elements.svg
                [ property "stroke" "rgba(255, 255, 255, 0.08)"
                , position absolute
                , top (px 0)
                , left (px 0)
                ]
            ]
        ]
    , class Subtitle
        [ width (px 220)
        , marginTop (px 0)
        ]
    ]
        |> namespace cssNamespace
