module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (a, p, h1, h2, h3, svg, img, li, ul, div, html, body)
import Css.Namespace exposing (namespace)


type CssClasses
    = Background
    | Banner
    | BannerLogo
    | Main
    | MainContent
    | Notification
    | NotificationVisible
    | NotificationBody
    | NotificationClose
    | Menu
    | MenuLinks
    | MenuLink
    | Header
    | HeaderDiscrete
    | HeaderLogo
    | HeaderIcon
    | HeaderFalafel
    | DesktopLinks
    | DesktopLink
    | DesktopLinkActive
    | Static
    | Spinner
    | Switch
    | SwitchButton
    | SwitchLeft
    | SwitchRight
    | Project
    | ProjectImage
    | ProjectBox
    | ProjectBoxContent
    | TextBox
    | TextBoxHidden
    | TextBoxContents
    | TextBoxContent
    | TextBoxDisplayPrimary
    | TextBoxDisplaySecondary
    | TextBoxSwitch
    | TextBoxSwitchHidden


type CssIds
    = App


sansSerif : String
sansSerif =
    "'PT Sans', sans-serif"


serif : String
serif =
    "'PT Serif', serif"


blue : Color
blue =
    hex "15487F"


mustard : Color
mustard =
    hex "DBA700"


black : Color
black =
    hex "000000"


darkGrey : Color
darkGrey =
    hex "333333"


white : Color
white =
    hex "FFFFFF"


desktop : String
desktop =
    "screen and (min-width: 700px)"


standardShadow : List Mixin
standardShadow =
    [ property "box-shadow" "0 0 12px rgba(20, 20, 20, .3)" ]


css : Stylesheet
css =
    (stylesheet << namespace "")
        [ everything
            [ boxSizing borderBox
            , property "font-family" "'PT Sans', sans-serif"
            , property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        , each [ html, body ]
            [ margin (px 0)
            , padding (px 0)
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        , a
            [ textDecoration none
            , property "border" "0"
            ]
        , each [ h1, h2, h3 ] [ fontWeight normal ]
        , h2
            [ fontSize (Css.rem 2)
            ]
        , h3
            [ fontSize (Css.rem 1.5)
            , property "margin" ".5rem 0"
            ]
        , mediaQuery desktop
            [ h2
                [ fontSize (Css.rem 3)
                , property "margin" "1.4rem 0"
                ]
            , h3
                [ fontSize (Css.rem 2)
                ]
            ]
        , id App
            [ width (pct 100)
            , height (pct 100)
            ]
        , class Background
            [ position absolute
            , top (px 0)
            , left (px 0)
            , property "z-index" "1"
            , descendants
                [ selector "polygon"
                    [ fill white
                    , property "opacity" ".05"
                    ]
                ]
            ]
        , class Main
            [ width (pct 100)
            , height (pct 100)
            , backgroundColor blue
            , property "display" "flex"
            , property "align-items" "center"
            , property "justify-content" "center"
            , property "animation" "fade-in ease-out .5s"
            , position relative
            ]
        , class MainContent
            [ position relative
            , property "z-index" "10"
            ]
        , class Notification
            ([ position fixed
             , backgroundColor mustard
             , bottom (px 40)
             , property "width" "calc(100% - 80px)"
             , height auto
             , right (px 40)
             , borderRadius (px 3)
             , property "z-index" "20"
             , property "opacity" "0"
             , property "transition" "all 1s"
             , property "pointer-events" "none"
             ]
                ++ standardShadow
            )
        , mediaQuery desktop
            [ class Notification
                [ width (px 280) ]
            ]
        , class NotificationBody
            [ property "padding" "20px 60px 20px 20px"
            , textAlign left
            , margin auto
            , color white
            , fontSize (Css.rem 1)
            , letterSpacing (Css.rem 0.04)
            , descendants
                [ p
                    [ fontSize inherit
                    , margin (px 0)
                    , padding (px 0)
                    , property "line-height" "1.35"
                    ]
                , a
                    [ fontSize inherit
                    , color inherit
                    , property "border-bottom" "1px solid white"
                    ]
                ]
            ]
        , class NotificationClose
            [ width (px 48)
            , height (px 48)
            , padding (px 16)
            , display inlineBlock
            , position absolute
            , top (px 0)
            , right (px 0)
            , margin (px 0)
            , property "transition" "transform .3s"
            , descendants
                [ svg
                    [ width (pct 100)
                    , height (pct 100)
                    ]
                , selector "g"
                    [ property "stroke" "white"
                    ]
                ]
            , hover
                [ property "transform" "scale(1.15)"
                ]
            ]
        , class NotificationVisible
            [ property "opacity" "1", property "pointer-events" "all" ]
        , class Banner
            [ color white
            , textAlign center
            , maxWidth (px 300)
            , property "z-index" "10"
            ]
        , class BannerLogo
            [ width (px 180)
            , height (px 180)
            , position relative
            , property "margin" "auto auto 15px"
            , children
                [ svg
                    [ property "stroke" "white"
                    ]
                , div
                    [ property "background-image" "url(/imgs/portrait-360.jpg)"
                    , property "background-size" "cover"
                    , property "background-position" "50% 50%"
                    , position absolute
                    , top (px 0)
                    , left (px 0)
                    , width (pct 100)
                    , height (pct 100)
                    , borderRadius (pct 50)
                    , property "opacity" "0"
                    , property "transition" "all .5s"
                    ]
                ]
            , hover
                [ children
                    [ div
                        [ property "opacity" "1"
                        ]
                    ]
                ]
            ]
        , class Menu
            [ position fixed
            , width (pct 100)
            , height (pct 100)
            , top (px 0)
            , left (px 0)
            , property "background-color" "rgba(255, 255, 255, .95)"
            , property "transform" "translate3d(0, 0, 0)"
            , property "transition" "transform .3s"
            , property "z-index" "50"
            ]
        , class MenuLinks
            [ display block
            , position absolute
            , top (pct 50)
            , left (pct 50)
            , property "transform" "translate3d(-50%, -50%, 0)"
            , height auto
            , property "text-align" "center"
            ]
        , class MenuLink
            [ cursor pointer
            , display block
            , color blue
            , property "padding" "10px 0"
            , property "text-decoration" "none"
            , property "font-weight" "300"
            , letterSpacing (Css.rem 0.1)
            , fontSize (Css.rem 1.5)
            ]
        , class Header
            [ width (pct 100)
            , height (px 60)
            , property "display" "flex"
            , position absolute
            , property "transition" "all .3s"
            , top (px 0)
            , left (px 0)
            , color blue
            , property "z-index" "15"
            ]
        , class HeaderDiscrete
            [ property "border" "none"
            , property "background" "transparent"
            , property "transition" "none"
            , color white
            ]
        , mediaQuery desktop
            [ class Header
                ([ property "background" "rgba(255, 255, 255, .6)" ]
                    ++ standardShadow
                )
            , class HeaderDiscrete
                [ color black
                , top auto
                , bottom (px 24)
                , property "background" "none"
                , property "border" "none"
                , property "box-shadow" "none"
                ]
            ]
        , class HeaderIcon
            [ cursor pointer
            , width (px 60)
            , height (px 60)
            , padding (px 18)
            , position absolute
            , top (px 0)
            , fill currentColor
            , property "stroke" "currentColor"
            , property "transition" "opacity .3s"
            , property "opacity" ".7"
            , hover
                [ property "opacity" "1"
                ]
            ]
        , class HeaderFalafel
            [ right (px 0)
            ]
        , mediaQuery desktop
            [ class HeaderFalafel
                [ display none
                ]
            ]
        , class HeaderLogo
            [ left (px 0)
            ]
        , class HeaderDiscrete
            [ descendants
                [ class HeaderLogo
                    [ display none
                    ]
                ]
            ]
        , class DesktopLinks
            [ width (pct 100)
            , display none
            , paddingTop (px 17)
            , textAlign center
            ]
        , mediaQuery desktop
            [ class DesktopLinks
                [ display block
                ]
            ]
        , class DesktopLink
            [ color currentColor
            , display inlineBlock
            , cursor pointer
            , position relative
            , property "padding" "4px 12px"
            , borderRadius (px 3)
            , property "opacity" "0.6"
            , fontSize (Css.rem 1)
            , letterSpacing (Css.rem 0.05)
            , property "font-kerning" "normal"
            , property "margin" "0 10px"
            , property "transition" "all .3s"
            , hover
                [ property "opacity" "1"
                ]
            ]
        , class DesktopLinkActive
            [ property "opacity" "1"
            ]
        , class HeaderDiscrete
            [ descendants
                [ class DesktopLink
                    [ color white
                    , property "background-color" "rgba(255, 255, 255, .1)"
                    , hover
                        [ color blue
                        , property "background-color" "rgba(255, 255, 255, 1)"
                        ]
                    ]
                ]
            ]
        , class Static
            [ property "padding" "40px 20px 20px"
            , width (pct 100)
            , maxWidth (px 680)
            , margin auto
            , color black
            , property "font-family" serif
            , descendants
                [ h2
                    [ textAlign center
                    ]
                , p
                    [ property "margin" "1.5rem 0"
                    , firstOfType
                        [ paddingTop (px 0)
                        , marginTop (px 0)
                        ]
                    , lastOfType
                        [ paddingBottom (px 0)
                        , marginBottom (px 0)
                        ]
                    ]
                , each [ p, li ]
                    [ fontSize (Css.rem 1)
                    , property "line-height" "1.68"
                    ]
                , each [ p, li, ul ]
                    [ fontFamily inherit
                    ]
                , ul
                    [ margin (px 0)
                    , property "list-style-position" "inside"
                    , padding (px 0)
                    ]
                , li
                    [ property "margin" "10px 0"
                    ]
                , a
                    [ fontFamily inherit
                    , color blue
                    , property "opacity" ".8"
                    , hover
                        [ property "opacity" "1"
                        , property "border-bottom" "1px solid currentColor"
                        ]
                    ]
                ]
            ]
        , mediaQuery desktop
            [ class Static
                [ property "padding" "60px 20px"
                , descendants
                    [ h2
                        [ marginBottom (Css.rem 3)
                        , marginTop (Css.rem 3)
                        ]
                    , p
                        [ property "margin" "2.05rem 0"
                        ]
                    , each [ p, li ]
                        [ fontSize (Css.rem 1.375)
                        ]
                    ]
                ]
            ]
        , class Spinner
            [ position absolute
            , top (pct 40)
            , left (pct 50)
            , property "transform" "translate3d(-50%, -50%, 0)"
            , descendants
                [ svg
                    [ fill blue
                    , property "animation" "spin 1s ease-in-out infinite"
                    ]
                ]
            ]
        , class Switch
            [ cursor pointer
            , display inlineBlock
            , width (px 26)
            , height (px 12)
            , borderRadius (px 6)
            , property "opacity" ".6"
            , position relative
            , property "transition" "opacity .3s"
            , borderColor blue
            , property "border-width" "1px"
            , property "border-style" "solid"
            , hover
                [ property "opacity" "1"
                ]
            ]
        , class SwitchButton
            [ width (px 12)
            , height (px 12)
            , borderRadius (px 6)
            , backgroundColor blue
            , position absolute
            , top (px -1)
            , left (px -1)
            , property "transform" "translate3d(0, 0, 0)"
            , property "transition" "transform .3s"
            ]
        , class SwitchLeft
            [ descendants
                [ class SwitchButton []
                ]
            ]
        , class SwitchRight
            [ descendants
                [ class SwitchButton
                    [ property "transform" "translate3d(14px, 0, 0)"
                    ]
                ]
            ]
        , class Project
            [ display block
            , property "margin" "40px auto"
            , padding (px 20)
            , maxWidth (px 640)
            , width (pct 100)
            , textDecoration none
            , textAlign left
            , color currentColor
            , property "border" "1px solid transparent"
            , property "transition" "all .6s"
            , firstOfType
                [ marginTop (px 0)
                ]
            , lastOfType
                [ marginBottom (px 0)
                ]
            , descendants
                [ h3
                    [ property "margin" "1rem 0 0"
                    ]
                , p
                    [ marginTop (px 0)
                    ]
                ]
            , hover standardShadow
            ]
        , mediaQuery desktop
            [ class Project
                [ property "margin" "80px auto"
                , padding (px 40)
                ]
            ]
        , class ProjectImage
            [ width (pct 100)
            , marginBottom (Css.rem 1)
            , paddingTop (pct 62.5)
            , property "border" "1px solid rgba(0, 0, 0, .2)"
            , backgroundSize cover
            , backgroundRepeat noRepeat
            , property "background-position" "50% 50%"
            ]
        , each [ class ProjectBox, class TextBox ]
            [ backgroundColor white
            , color darkGrey
            , width (pct 100)
            , height (pct 100)
            , position fixed
            , left (px 0)
            , property "z-index" "15"
            ]
        , class ProjectBoxContent
            [ width (pct 100)
            , height (pct 100)
            , overflowY scroll
            , property "-webkit-overflow-scrolling" "touch"
            , property "padding" "100px 40px 60px"
            ]
        , class TextBox
            [ backgroundColor white
            , width (pct 100)
            , height (pct 100)
            , position fixed
            , property "transition" "opacity .3s"
            ]
        , class TextBoxHidden
            [ opacity (int 0)
            , property "pointer-events" "none"
            ]
        , class TextBoxDisplayPrimary
            [ descendants
                [ class TextBoxContent
                    [ nthOfType "2"
                        [ opacity (int 0)
                        , property "pointer-events" "none"
                        ]
                    ]
                ]
            ]
        , class TextBoxDisplaySecondary
            [ descendants
                [ class TextBoxContent
                    [ nthOfType "1"
                        [ opacity (int 0)
                        , property "pointer-events" "none"
                        ]
                    ]
                ]
            ]
        , class TextBoxContents
            [ height (pct 100)
            ]
        , class TextBoxContent
            [ width (pct 100)
            , height (pct 100)
            , position absolute
            , top (px 0)
            , left (px 0)
            , property "padding" "40px 0"
            , overflowY scroll
            , property "-webkit-overflow-scrolling" "touch"
            , margin auto
            , property "transition" "all .3s"
            ]
        , class TextBoxSwitch
            [ position fixed
            , bottom (px 15)
            , left (px 15)
            , property "z-index" "3"
            ]
        , class TextBoxSwitchHidden
            [ display none
            ]
        ]


primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
