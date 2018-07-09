module Views.Static exposing (..)

import Markdown exposing (toHtml)
import Html.Styled exposing (Html, div, fromUnstyled)
import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Css.Foreign as Foreign
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


view : String -> Html msg
view mdContent =
    div
        [ css
            [ width (pct 100)
            , maxWidth (px 680)
            , padding2 (px 20) (px 20)
            , margin auto
            , textAlign left
            , color black
            , Foreign.descendants
                [ Foreign.everything
                    [ property "font-family" Styles.Constants.serif
                    ]
                , Foreign.h2
                    [ textAlign center
                    ]
                , Foreign.h1
                    [ property "font-family" Styles.Constants.serif
                    , margin (px 0)
                    , fontSize (Css.rem 3)
                    ]
                , Foreign.selector "iframe"
                    [ margin2 (px 10) (px 0)
                    ]
                , Foreign.p
                    [ margin2 (Css.rem 1.5) (Css.rem 0)
                    , firstChild
                        [ paddingTop (px 0)
                        , marginTop (px 0)
                        ]
                    , lastChild
                        [ paddingBottom (px 0)
                        , marginBottom (px 0)
                        ]
                    , Mixins.desktop
                        [ margin2 (Css.rem 1.875) (px 0)
                        ]
                    ]
                , Foreign.each [ Foreign.p, Foreign.li, Foreign.code ]
                    Mixins.bodyType
                , Foreign.each [ Foreign.p, Foreign.li, Foreign.ul, Foreign.strong ]
                    [ fontFamily inherit
                    ]
                , Foreign.strong
                    [ fontWeight bolder
                    ]
                , Foreign.ul
                    [ margin (px 0)
                    , listStylePosition inside
                    , padding (px 0)
                    ]
                , Foreign.code
                    [ property "font-family" "monospace"
                    , backgroundColor faintMustard
                    , padding2 (px 2) (px 4)
                    , borderRadius (px 2)
                    ]
                , Foreign.em
                    [ Foreign.descendants
                        [ Foreign.code
                            [ backgroundColor faintBlue
                            , fontStyle normal
                            ]
                        ]
                    ]
                , Foreign.each
                    [ Foreign.p
                    , Foreign.li
                    , Foreign.code
                    ]
                    [ Mixins.desktop [ fontSize (Css.rem 1.25) ]
                    ]
                , Foreign.li
                    [ margin2 (px 10) (px 0)
                    ]
                , Foreign.a
                    [ fontFamily inherit
                    , color currentColor
                    , borderBottom3 (px 1) solid currentColor
                    ]
                , Foreign.blockquote
                    [ property "font-family" Styles.Constants.serif
                    , margin3 (px 20) (px 0) (px 20)
                    , paddingLeft (px 16)
                    , padding2 (px 8) (px 16)
                    , backgroundColor (rgba 0 0 0 0.03)
                    , borderLeft3 (px 3) solid currentColor
                    ]
                ]
            ]
        ]
        [ toHtml [] mdContent |> fromUnstyled ]
