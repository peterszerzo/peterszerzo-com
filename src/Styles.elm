module Styles exposing (..)

import Html.Styled exposing (Html)
import Css exposing (..)
import Css.Foreign as Foreign
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


globalStyles : Html msg
globalStyles =
    Foreign.global
        [ Foreign.everything
            [ boxSizing borderBox
            , property "font-family" Styles.Constants.sansSerif
            , property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        , Foreign.each [ Foreign.html, Foreign.body ]
            [ margin (px 0)
            , padding (px 0)
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        , Foreign.a
            [ textDecoration none
            , border (px 0)
            ]
        , Foreign.each [ Foreign.h1, Foreign.h2, Foreign.h3 ] [ fontWeight normal ]
        , Foreign.h2
            [ fontSize (Css.rem 2)
            , Mixins.desktop
                [ fontSize (Css.rem 3)
                , margin3 (Css.rem 1.4) (Css.rem 0) (Css.rem 3)
                ]
            ]
        , Foreign.h3
            [ fontSize (Css.rem 1.5)
            , margin2 (Css.rem 0.5) (Css.rem 0)
            , Mixins.desktop
                [ fontSize (Css.rem 2)
                ]
            ]
        , Foreign.selector ".Spinner"
            [ position absolute
            , top (pct 40)
            , left (pct 50)
            , transform (translate3d (pct -50) (pct -50) (px 0))
            , Foreign.descendants
                [ Foreign.svg
                    [ fill blue
                    , property "animation" "spin 1s ease-in-out infinite"
                    ]
                ]
            ]
        ]
