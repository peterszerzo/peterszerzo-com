module Site.Ui.Nav exposing (view)

import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, nav, node, p, text)
import Html.Styled.Attributes exposing (css, href)
import Site.Content as Content
import Site.Messages exposing (Msg(..))
import Site.Styles.Constants exposing (..)
import Site.Styles.Mixins as Mixins
import Site.Ui.Link as Link


viewMainLink : ( String, String ) -> Html Msg
viewMainLink ( label, url ) =
    Link.link
        { css =
            [ color black
            , display inlineBlock
            , cursor pointer
            , position relative
            , padding2 (px 4) (px 12)
            , borderRadius (px 3)
            , opacity (num 0.9)
            , fontSize (Css.rem 1)
            , letterSpacing (Css.rem 0.05)
            , property "font-kerning" "normal"
            , backgroundColor (rgba 255 255 255 0.8)
            , margin (px 6)
            , property "transition" "all .2s"
            , hover
                [ backgroundColor (rgba 255 255 255 1)
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
