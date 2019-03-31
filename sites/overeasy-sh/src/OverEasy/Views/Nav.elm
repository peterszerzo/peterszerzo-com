module OverEasy.Views.Nav exposing (view)

import Css exposing (..)
import Html.Styled exposing (Html, a, div, text)
import Html.Styled.Attributes exposing (css, href)
import Json.Decode as Decode
import OverEasy.Constants exposing (..)
import OverEasy.Views.Icons as Icons


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
        ]
        [ Icons.smallLogo ]
