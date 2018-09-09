module Site.Styles exposing (globalStyles)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html)
import Site.Styles.Constants as Constants exposing (..)
import Site.Styles.Mixins as Mixins


globalStyles : Html msg
globalStyles =
    Global.global
        [ Global.everything
            [ boxSizing borderBox
            , property "font-family" Constants.sansSerif
            , property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        , Global.each [ Global.html, Global.body ]
            [ margin (px 0)
            , padding (px 0)
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        , Global.a
            [ textDecoration none
            , border (px 0)
            ]
        , Global.each [ Global.h1, Global.h2, Global.h3 ] [ fontWeight normal ]
        , Global.h2
            [ fontSize (Css.rem 2)
            , Mixins.desktop
                [ fontSize (Css.rem 3)
                , margin3 (Css.rem 1.4) (Css.rem 0) (Css.rem 3)
                ]
            ]
        , Global.h3
            [ fontSize (Css.rem 1.5)
            , margin2 (Css.rem 0.5) (Css.rem 0)
            , Mixins.desktop
                [ fontSize (Css.rem 2)
                ]
            ]
        , Global.selector ".Spinner"
            [ position absolute
            , top (pct 40)
            , left (pct 50)
            , transform (translate3d (pct -50) (pct -50) (px 0))
            , Global.descendants
                [ Global.svg
                    [ fill blue
                    , property "animation" "spin 1s ease-in-out infinite"
                    ]
                ]
            ]
        ]
