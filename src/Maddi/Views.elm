module Maddi.Views exposing
    ( homeLink
    , iconContainer
    , intro
    , mobileNav
    , pageLayout
    , simplePageContent
    , siteHeader
    , static
    )

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, br, div, fromUnstyled, h2, header, p, text)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onClick)
import Json.Decode as Decode
import Maddi.Content exposing (navLinks)
import Maddi.Views.Icons as Icons
import Maddi.Views.Mixins as Mixins exposing (..)
import Markdown
import Svg.Styled exposing (line, path, svg)
import Svg.Styled.Attributes exposing (d, stroke, strokeWidth, viewBox, x1, x2, y1, y2)


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


homeLink : msg -> Html msg
homeLink navigate =
    a
        [ css
            [ width (px 40)
            , height (px 40)
            , backgroundColor (hex "000")
            , color (hex "FFF")
            , marginRight (px 10)
            , borderRadius (px 3)
            , display inlineBlock
            , position relative
            , property "transition" "all 0.1s"
            , mobile
                [ width (px 30)
                , height (px 30)
                ]
            , hover
                [ backgroundColor yellow
                , color (hex "000")
                , Global.children
                    [ Global.everything
                        [ firstChild
                            [ color (hex "000")
                            ]
                        ]
                    ]
                ]
            ]
        , href "/"
        ]
        [ Icons.largeLogo
        ]


intro : (String -> msg) -> Html msg
intro navigate =
    div
        [ css
            [ bodyType
            ]
        ]
        [ p [ css [ marginTop (px -4) ] ]
            [ text "My name is Anna. I design sets for theatre pieces like "
            , a [ href "/projects/karmafulminien" ] [ text "Karmafulminien" ]
            , text " and "
            , a [ href "/projects/story-of-qu" ] [ text "Story of Qu" ]
            , text ", and I also work in opera."
            ]
        , p []
            [ text "I studied at Accademia di Brera, trained at Teatro alla Scala, currently based in Reggio Emilia and Milan, traveling across Italy with brief escapades to New York, Sydney, and wherever next."
            ]
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


siteHeader : { activateMobileNav : msg } -> Html msg
siteHeader { activateMobileNav } =
    header
        [ css
            [ position absolute
            , top (px 0)
            , padding2 (px 20) (px 20)
            , left (px 0)
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
                            [ fontSize (Css.rem 1.25)
                            , lineHeight (num 1.15)
                            , margin (px 0)
                            , property "font-weight" "700"
                            ]
                        ]
                        [ text "Anna Cingi" ]
                    , p
                        [ css
                            [ fontSize (Css.rem 1.25)
                            , lineHeight (num 1.15)
                            , margin (px 0)
                            , property "font-weight" "300"
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
                                , fontSize (Css.rem 1.25)
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
            , Mixins.fadeIn
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
                                , margin (px 0)
                                , lineHeight (num 1)
                                , padding2 (px 10) (px 0)
                                , headingType
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
    [ div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , padding2 (px 60) (px 20)
            , displayFlex
            , alignItems center
            , justifyContent center
            , mobile
                [ overflow auto
                ]
            ]
        ]
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
            , Global.selector "#App"
                [ width (pct 100)
                , height (pct 100)
                , mobile
                    [ height auto
                    ]
                ]
            , Global.a
                [ textDecoration none
                , border (px 0)
                ]
            ]
        , siteHeader
            { activateMobileNav = toggleMobileNav True
            }
        , div
            [ css
                [ maxWidth (px 1000)
                , width (pct 100)
                , margin auto
                , position relative
                ]
            ]
            children
        , if isMobileNavActive then
            mobileNav { close = toggleMobileNav False }

          else
            text ""
        ]
    ]


simplePageContent : List (Html msg) -> Html msg
simplePageContent children =
    let
        stickout =
            10
    in
    div
        [ css
            [ padding (px 20)
            , position relative
            , width (pct 100)
            , height (px 400)
            , property "animation" "fadein 0.5s ease-in-out forwards"
            , mobile
                [ height auto
                , margin3 (px 60) auto (px 0)
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
                    , borderLeft3 (px 1) solid borderColor_
                    ]
                ]
                []
            , div
                [ css
                    [ position absolute
                    , bottom (px -stickout)
                    , left (pct 50)
                    , height (px (2 * stickout))
                    , borderLeft3 (px 1) solid borderColor_
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
            children
        ]
