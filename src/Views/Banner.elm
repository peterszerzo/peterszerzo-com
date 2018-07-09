module Views.Banner exposing (..)

import Html.Styled exposing (Html, div, h1, p, header, node, text, fromUnstyled)
import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Css.Foreign as Foreign
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Content
import Views.Shapes as Shapes
import Messages exposing (Msg)
import Views.Nav


view : Html Msg
view =
    div
        [ css
            [ displayFlex
            , alignItems center
            , justifyContent center
            , position relative
            , width (pct 100)
            , height (pct 100)
            , Mixins.zIndex 10
            ]
        ]
        [ div
            [ css
                [ color white
                , textAlign center
                ]
            ]
            [ div
                [ css
                    [ width (px 240)
                    , height (px 240)
                    , position relative
                    , displayFlex
                    , alignItems center
                    , justifyContent center
                    , borderRadius (pct 50)
                    , margin3 auto auto (px 0)
                    , Foreign.children
                        [ Foreign.svg
                            [ property "stroke" "rgba(255, 255, 255, 0.08)"
                            , position absolute
                            , top (px 0)
                            , left (px 0)
                            ]
                        ]
                    ]
                ]
                [ Shapes.logo |> fromUnstyled
                , div []
                    [ h1
                        [ css
                            [ margin3 (px 20) auto (px 10)
                            ]
                        ]
                        [ text Content.title ]
                    , p
                        [ css
                            [ width (px 220)
                            , marginTop (px 0)
                            ]
                        ]
                        [ text Content.subtitle ]
                    ]
                ]
            , Views.Nav.view
            ]
        ]
