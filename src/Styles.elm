module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (a, p, h1, h2, h3, svg, img, li, ul, div, html, body, blockquote)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Views.Banner
import Views.ContentBox
import Views.Notification
import Views.Switch
import Views.Static
import Views.Nav
import Views.Projects
import Views.Background.Styles
import Views.Styles


type CssClasses
    = Spinner


type CssIds
    = App


css : Stylesheet
css =
    (stylesheet << namespace "") <|
        [ everything
            [ boxSizing borderBox
            , property "font-family" Styles.Constants.sansSerif
            , property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        , each [ html, body ]
            [ margin (px 0)
            , padding (px 0)
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        , a
            [ textDecoration none
            , border (px 0)
            ]
        , each [ h1, h2, h3 ] [ fontWeight normal ]
        , h2
            [ fontSize (Css.rem 2)
            ]
        , h3
            [ fontSize (Css.rem 1.5)
            , margin2 (Css.rem 0.5) (Css.rem 0)
            ]
        , mediaQuery desktop
            [ h2
                [ fontSize (Css.rem 3)
                , margin2 (Css.rem 1.4) (Css.rem 0)
                ]
            , h3
                [ fontSize (Css.rem 2)
                ]
            ]
        , id App
            [ width (pct 100)
            , height (pct 100)
            ]
        , class Spinner
            [ position absolute
            , top (pct 40)
            , left (pct 50)
            , transform (translate3d (pct -50) (pct -50) (px 0))
            , descendants
                [ svg
                    [ fill blue
                    , property "animation" "spin 1s ease-in-out infinite"
                    ]
                ]
            ]
        ]
            ++ Views.Styles.styles
            ++ Views.Background.Styles.styles
            ++ Views.Banner.styles
            ++ Views.ContentBox.styles
            ++ Views.Notification.styles
            ++ Views.Switch.styles
            ++ Views.Projects.styles
            ++ Views.Static.styles
            ++ Views.Nav.styles
