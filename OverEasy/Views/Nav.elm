module Views.Nav exposing (..)

import Json.Decode as Decode
import Css exposing (..)
import Css.Media as Media
import Html.Styled exposing (Html, text, div, a)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onWithOptions)
import Views.Icons as Icons


view : msg -> Html msg
view onClick =
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
            , backgroundColor (hex "000000")
            , color (hex "FFFFFF")
            , property "transition" "all 0.3s"
            , hover
                [ backgroundColor (hex "ffc235")
                , color (hex "000")
                ]
            , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
                [ width (px 60)
                , height (px 60)
                , top (px 15)
                , left (px 15)
                ]
            ]
        , href "/"
        , onWithOptions "click"
            { preventDefault = True
            , stopPropagation = False
            }
            (Decode.succeed onClick)
        ]
        [ Icons.smallLogo ]
