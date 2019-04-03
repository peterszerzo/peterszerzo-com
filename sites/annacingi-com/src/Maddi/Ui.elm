module Maddi.Ui exposing
    ( black, bodyType, fadeIn, gray, heading1Type, heading2Type, lightGray, lighterGray, linkType, mobile, smallType, stickoutStyles, titleType, white, yellow
    , mobileNav, pageLayout, simplePageContent, static, tag
    )

{-| Ui

@docs black, bodyType, fadeIn, gray, heading1Type, heading2Type, lightGray, lighterGray, linkType, mobile, smallType, stickoutStyles, titleType, white, yellow

-}

import Css exposing (..)
import Css.Global as Global
import Css.Media as Media
import Html.Styled exposing (Html, a, br, div, footer, fromUnstyled, h1, h2, header, p, span, text)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onClick)
import Json.Decode as Decode
import Maddi.Content exposing (navLinks)
import Maddi.Ui.Icons as Icons
import Markdown
import Svg.Styled exposing (line, path, svg)
import Svg.Styled.Attributes exposing (d, stroke, strokeWidth, viewBox, x1, x2, y1, y2)


mobile : List Style -> Style
mobile =
    Media.withMedia
        [ Media.only Media.screen
            [ Media.maxWidth (px 600) ]
        ]


black : Color
black =
    hex "000000"


white : Color
white =
    hex "FFFFFF"


yellow : Color
yellow =
    hex "F7CE00"


gray : Color
gray =
    hex "898989"


lighterGray : Color
lighterGray =
    hex "BDBDBD"


lightGray : Color
lightGray =
    hex "CECECE"


smallType : Style
smallType =
    Css.batch
        [ fontSize (Css.rem 0.75)
        , lineHeight (num 1.6)
        , mobile
            [ fontSize (Css.rem 0.75)
            ]
        ]


bodyType : Style
bodyType =
    Css.batch
        [ fontSize (Css.rem 0.825)
        , lineHeight (num 1.6)
        , mobile
            [ fontSize (Css.rem 0.825)
            ]
        ]


heading1Type : Style
heading1Type =
    Css.batch
        [ fontSize (Css.rem 1.5)
        , textDecoration none
        , color inherit
        , mobile
            [ fontSize (Css.rem 1.375)
            ]
        ]


heading2Type : Style
heading2Type =
    Css.batch
        [ fontSize (Css.rem 1.25)
        , property "font-family" "Quicksand"
        ]


linkType : Style
linkType =
    Css.batch
        [ display inlineBlock
        , color inherit
        , bodyType
        , paddingLeft (px 1)
        , paddingRight (px 1)
        , borderRadius (px 2)
        , textDecoration underline
        , property "transition" "all 0.15s"
        , hover
            [ backgroundColor yellow
            ]
        , focus
            [ outline none
            , backgroundColor (rgb 250 250 250)
            ]
        ]


titleType : Style
titleType =
    Css.batch
        [ property "font-family" "Quicksand"
        , textTransform uppercase
        , fontSize (Css.rem 2)
        , lineHeight (num 1.15)
        , margin (px 0)
        , property "font-weight" "600"
        , mobile
            [ fontSize (Css.rem 1.75)
            ]
        ]


fadeIn : Style
fadeIn =
    property "animation" "fadein 0.15s ease-in-out forwards"


stickoutStyles : { hover : Bool } -> Style
stickoutStyles { hover } =
    let
        stickout =
            10

        common =
            Css.batch
                [ position absolute
                , property "content" "' '"
                , property "z-index" "9"
                , property "transition" "border-color 0.05s"
                , property "pointer-events" "none"
                , borderColor
                    (if hover then
                        lighterGray

                     else
                        lightGray
                    )
                ]
    in
    Css.batch
        [ before
            [ top (px -stickout)
            , bottom (px -stickout)
            , left (px 0)
            , right (px 0)
            , borderLeft2 (px 1) solid
            , borderRight2 (px 1) solid
            , common
            ]
        , after
            [ left (px -stickout)
            , right (px -stickout)
            , top (px 0)
            , bottom (px 0)
            , borderTop2 (px 1) solid
            , borderBottom2 (px 1) solid
            , common
            ]
        ]


tag : Bool -> String -> Html msg
tag isLarge tagText =
    span
        [ css
            [ if isLarge then
                bodyType

              else
                smallType
            , padding2 (px 2) (px 6)
            , borderRadius (px 3)
            , backgroundColor (hex "F1F1F1")
            , display inlineBlock
            , marginRight (px 6)
            , marginBottom (px 6)
            ]
        ]
        [ text tagText ]


pageFooter : Html msg
pageFooter =
    footer
        [ css
            [ padding2 (px 20) (px 20)
            ]
        ]
        [ p
            [ css
                [ smallType
                , color gray
                , textAlign center
                ]
            ]
            [ text "Website co-designed and built by "
            , a
                [ css
                    [ textDecoration none
                    , color inherit
                    , borderBottom3 (px 1) solid currentColor
                    ]
                , href "http://peterszerzo.com"
                ]
                [ text "Peter Sz" ]
            ]
        ]


static : String -> Html msg
static markdownContent =
    div
        [ css
            [ overflow auto
            , Global.descendants
                [ Global.each [ Global.p, Global.li ]
                    [ bodyType
                    ]
                , Global.each [ Global.a ]
                    [ linkType
                    ]
                , Global.h2
                    [ heading2Type
                    ]
                , Global.blockquote
                    [ margin4 (px 16) (px 0) (px 16) (px 0)
                    , paddingLeft (px 20)
                    , color gray
                    ]
                ]
            , Global.children
                [ Global.everything
                    [ Global.children
                        [ Global.everything
                            [ firstChild
                                [ marginTop (px -4)
                                ]
                            , lastChild
                                [ marginBottom (px 0)
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
        [ Markdown.toHtml [] markdownContent |> fromUnstyled
        ]


iconContainer : { handleClick : msg, css : Style } -> List (Html msg) -> Html msg
iconContainer config children =
    div
        [ css
            [ cursor pointer
            , width (px 35)
            , height (px 35)
            , padding (px 2)
            , display inlineBlock
            , Global.descendants
                [ Global.svg
                    [ width (pct 100)
                    , height (pct 100)
                    ]
                ]
            , borderRadius (px 2)
            , hover
                [ backgroundColor (rgba 0 0 0 0.05)
                ]
            , config.css
            ]
        , onClick config.handleClick
        ]
        children


pageHeader : { activateMobileNav : msg } -> Html msg
pageHeader { activateMobileNav } =
    header
        [ css
            [ padding2 (px 20) (px 20)
            , width (pct 100)
            , alignItems start
            , marginBottom (px 20)
            ]
        ]
        [ div
            [ css
                [ maxWidth (px 1000)
                , margin auto
                , displayFlex
                , alignItems flexEnd
                , justifyContent spaceBetween
                ]
            ]
            [ a
                [ css
                    [ width (px 220)
                    , displayFlex
                    , textDecoration none
                    , color inherit
                    ]
                , href "/"
                ]
                [ div
                    [ css
                        [ width (px 44)
                        , height (px 44)
                        , borderRadius (px 3)
                        , backgroundColor black
                        , marginRight (px 8)
                        , color white
                        , property "transition" "all 0.2s"
                        ]
                    ]
                    [ Icons.largeLogo
                    ]
                , div [ css [ marginTop (px 0) ] ]
                    [ p
                        [ css
                            [ heading2Type
                            , lineHeight (num 1.15)
                            , margin (px 0)
                            , property "font-weight" "700"
                            ]
                        ]
                        [ text "Anna Cingi" ]
                    , p
                        [ css
                            [ heading2Type
                            , lineHeight (num 1.15)
                            , margin (px 0)
                            ]
                        ]
                        [ text "set designer" ]
                    ]
                ]
            , div
                [ css
                    [ display block
                    , mobile [ display none ]
                    ]
                ]
                (List.map
                    (\( url, label ) ->
                        a
                            [ href url
                            , css
                                [ textDecoration none
                                , color inherit
                                , heading2Type
                                , marginLeft (px 20)
                                , borderBottom2 (px 1) solid
                                , borderBottomColor transparent
                                , hover
                                    [ borderBottomColor (hex "000")
                                    ]
                                ]
                            ]
                            [ text label ]
                    )
                    (List.tail navLinks |> Maybe.withDefault [])
                )
            , iconContainer
                { handleClick = activateMobileNav
                , css =
                    Css.batch
                        [ display none
                        , mobile [ display block ]
                        ]
                }
                [ Icons.menu
                ]
            ]
        ]


mobileNav : { close : msg } -> Html msg
mobileNav { close } =
    div
        [ css
            [ position fixed
            , property "z-index" "10000"
            , top (px 0)
            , fadeIn
            , left (px 0)
            , width (vw 100)
            , height (vh 100)
            , padding2 (px 35) (px 20)
            , textAlign center
            , backgroundColor (rgba 255 255 255 1)
            , display none
            , alignItems center
            , justifyContent center
            , mobile [ displayFlex ]
            ]
        ]
        [ div []
            [ iconContainer
                { handleClick = close
                , css = Css.batch [ marginBottom (px 20) ]
                }
                [ Icons.close
                ]
            , div
                []
              <|
                List.map
                    (\( url, label ) ->
                        a
                            [ href url
                            , css
                                [ display block
                                , heading2Type
                                , margin (px 0)
                                , lineHeight (num 1)
                                , padding2 (px 10) (px 0)
                                , textDecoration none
                                , color currentColor
                                ]
                            ]
                            [ text label ]
                    )
                    navLinks
            , div [ css [ marginTop (px 40) ] ] [ Icons.largeLogo ]
            ]
        ]


pageLayout : Bool -> (Bool -> msg) -> List (Html msg) -> List (Html msg)
pageLayout isMobileNavActive toggleMobileNav children =
    [ Global.global
        [ Global.everything
            [ boxSizing borderBox
            , property "-webkit-font-smoothing" "antialiased"
            , property "font-family" "Lato, sans-serif"
            ]
        , Global.selector """
                @keyframes fadein {
                  0% {
                    opacity: 0;
                  }

                  100% {
                    opacity: 100%;
                  }
                }

                .noselector
                """ [ display block ]
        , Global.each [ Global.html, Global.body ]
            [ margin (px 0)
            , height (pct 100)
            ]
        , Global.body
            [ mobile
                [ overflow auto
                , height auto
                ]
            ]
        , Global.a
            [ textDecoration none
            , border (px 0)
            ]
        ]
    , pageHeader
        { activateMobileNav = toggleMobileNav True
        }
    , div
        [ css
            [ maxWidth (px 1040)
            , width (pct 100)
            , padding (px 20)
            , margin auto
            , position relative
            ]
        ]
        children
    , if isMobileNavActive then
        mobileNav { close = toggleMobileNav False }

      else
        text ""
    , pageFooter
    ]


simplePageContent : { title : String, left : Html msg, right : Html msg } -> Html msg
simplePageContent config =
    let
        stickout =
            10
    in
    div
        [ css
            [ fadeIn
            ]
        ]
        [ h1
            [ css
                [ titleType
                , textTransform none
                , marginTop (px 0)
                , marginLeft (px 20)
                , marginBottom (px 10)
                ]
            ]
            [ text config.title ]
        , div
            [ css
                [ padding (px 20)
                , position relative
                , width (pct 100)
                , height (px 420)
                , mobile
                    [ height auto
                    ]
                , stickoutStyles { hover = False }
                ]
            ]
            [ div
                [ css
                    [ mobile
                        [ display none
                        ]
                    ]
                ]
                [ div
                    [ css
                        [ position absolute
                        , top (px -stickout)
                        , left (pct 50)
                        , height (px (2 * stickout))
                        , borderLeft3 (px 1) solid lightGray
                        ]
                    ]
                    []
                , div
                    [ css
                        [ position absolute
                        , bottom (px -stickout)
                        , left (pct 50)
                        , height (px (2 * stickout))
                        , borderLeft3 (px 1) solid lightGray
                        ]
                    ]
                    []
                ]
            , div
                [ css
                    [ position absolute
                    , flex (num 0)
                    , width (px 1)
                    , top (px -stickout)
                    , bottom (px -stickout)
                    , right (pct 50)
                    , mobile
                        [ display none
                        ]
                    ]
                ]
                []
            , div
                [ css
                    [ displayFlex
                    , position relative
                    , alignItems flexStart
                    , justifyContent spaceBetween
                    , mobile
                        [ display block
                        ]
                    , Global.children
                        [ Global.everything
                            [ property "width" "calc(50% - 20px)"
                            , position relative
                            , overflow visible
                            , mobile
                                [ width (pct 100)
                                ]
                            , firstChild
                                [ marginBottom (px 40)
                                ]
                            ]
                        ]
                    ]
                ]
                [ config.left
                , config.right
                ]
            ]
        ]
