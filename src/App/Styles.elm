module Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)


type CssClasses
    = Banner
    | Main
    | MainContent


type CssIds
    = Page


blue : Color
blue =
    hex "15487F"


white : Color
white =
    hex "FFFFFF"


css : Stylesheet
css =
    (stylesheet << namespace "")
        [ class Main
            [ width (pct 100)
            , height (pct 100)
            , backgroundColor blue
            , property "display" "flex"
            , property "align-items" "center"
            , property "justify-content" "center"
            , property "animation" "fade-in ease-out .5s"
            , position relative
            ]
        , class MainContent
            []
        ]


primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
