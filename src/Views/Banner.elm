module Views.Banner exposing (..)

import Html exposing (Html, div, h1, p, header, node)
import Html.CssHelpers
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Content
import Views.Shapes exposing (logo)
import Views.Nav
import Messages exposing (Msg)


view : Html Msg
view =
    div
        [ localClass [ Root ]
        ]
        [ div [ localClass [ Content ] ]
            [ div
                [ localClass [ Logo ]
                ]
                [ logo
                , div []
                    []
                ]
            , h1 [] [ Html.text Content.title ]
            , p [ localClass [ Subtitle ] ] [ Html.text Content.subtitle ]
            ]
        , Views.Nav.view
        ]


cssNamespace : String
cssNamespace =
    "Banner"


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
            [ Elements.svg
                [ property "stroke" "white"
                ]
            , Elements.div
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
                [ Elements.div
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
