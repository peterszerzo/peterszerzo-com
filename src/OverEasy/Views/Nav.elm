module OverEasy.Views.Nav exposing (..)

import Json.Decode as Decode
import Css exposing (..)
import Css.Media as Media
import Html.Styled exposing (Html, text, div, a)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onWithOptions)


--

import OverEasy.Views.Icons as Icons
import OverEasy.Constants exposing (..)


view : { onClick : msg, css : List Style } -> Html msg
view config =
    a
        [ css
            [ width (px 48)
            , height (px 48)
            , borderRadius (pct 50)
            , position absolute
            , boxSizing borderBox
            , top (px 6)
            , left (px 6)
            , padding (px 12)
            , property "z-index" "102"
            , backgroundColor black
            , color white
            , property "transition" "all 0.3s"
            , hover
                [ backgroundColor yellow
                , color (hex "000")
                ]
            , desktop
                [ width (px 60)
                , height (px 60)
                , top (px 15)
                , left (px 15)
                ]
            , Css.batch config.css
            ]
        , href "/"
        , onWithOptions "click"
            { preventDefault = True
            , stopPropagation = False
            }
            (Decode.succeed config.onClick)
        ]
        [ Icons.smallLogo ]
