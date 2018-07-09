module Views.Nav exposing (..)

import Html.Styled exposing (Html, div, h1, p, nav, node, a, text)
import Html.Styled.Attributes exposing (href, css)
import Css exposing (..)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Messages exposing (Msg(..))
import Views.Link as Link
import Content


viewMainLink : ( String, String ) -> Html Msg
viewMainLink ( label, url ) =
    Link.link
        { css =
            [ color white
            , display inlineBlock
            , cursor pointer
            , position relative
            , padding2 (px 4) (px 12)
            , borderRadius (px 3)
            , opacity (num 0.9)
            , fontSize (Css.rem 1)
            , letterSpacing (Css.rem 0.05)
            , property "font-kerning" "normal"
            , property "background-color" "rgba(255, 255, 255, .23)"
            , margin (px 8)
            , property "transition" "all .2s"
            , hover
                [ color blue
                , opacity (num 1)
                , property "background-color" "rgba(255, 255, 255, 1)"
                ]
            , focus
                [ outline none
                , property "box-shadow" "0 0 0 3px rgba(255, 255, 255, 0.5)"
                ]
            ]
        , children = [ text label ]
        , url = url
        }


view : Html Msg
view =
    nav
        [ css
            [ width (pct 100)
            , padding2 (px 0) (px 20)
            , maxWidth (px 420)
            , marginTop (px -55)
            , Mixins.zIndex 9
            , color white
            ]
        ]
        [ div
            [ css
                [ width (pct 100)
                , textAlign center
                ]
            ]
            (List.map viewMainLink Content.mainLinks)
        ]
