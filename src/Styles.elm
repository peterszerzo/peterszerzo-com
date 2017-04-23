module Styles exposing (..)

import Css exposing (..)
import Css.Elements exposing (a, p, h1, h2, h3, svg, img, li, ul, div, html, body, blockquote)
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


calcPctMinusPx : Float -> Float -> String
calcPctMinusPx percent pixels =
    "calc(" ++ (percent |> toString) ++ "% - " ++ (pixels |> toString) ++ "px)"


zIndex : Int -> Mixin
zIndex i =
    property "z-index" (i |> toString)


lineHeight : Float -> Mixin
lineHeight lh =
    property "line-height" (lh |> toString)


pointerEventsNone : Mixin
pointerEventsNone =
    property "pointer-events" "none"


pointerEventsAll : Mixin
pointerEventsAll =
    property "pointer-events" "all"


regularTransition : Mixin
regularTransition =
    property "transition" "all .3s"


opacity : Float -> Mixin
opacity op =
    property "opacity" (op |> toString)


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


grey : Color
grey =
    hex "777777"


lightGrey : Color
lightGrey =
    hex "BBBBBB"


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
            , property "font-family" sansSerif
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
            , border (px 0)
            ]
        , each [ h1, h2, h3 ] [ fontWeight normal ]
        , h2
            [ fontSize (Css.rem 2)
            ]
        , h3
            [ fontSize (Css.rem 1.5)
            , margin2 (Css.rem 0.5) (Css.rem 0)
            ]
        , mediaQuery desktop
            [ h2
                [ fontSize (Css.rem 3)
                , margin2 (Css.rem 1.4) (Css.rem 0)
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
            , zIndex 1
            , descendants
                [ selector "polygon"
                    [ fill white
                    , opacity 0.05
                    ]
                ]
            ]
        , class Main
            [ width (pct 100)
            , height (pct 100)
            , backgroundColor blue
            , displayFlex
            , alignItems center
            , justifyContent center
            , property "animation" "fade-in ease-out .5s"
            , position relative
            ]
        , class MainContent
            [ position relative
            , zIndex 10
            ]
        , class Notification
            ([ position fixed
             , backgroundColor mustard
             , bottom (px 40)
             , property "width" (calcPctMinusPx 100 80)
             , height auto
             , right (px 40)
             , borderRadius (px 3)
             , zIndex 20
             , opacity 0
             , property "transition" "all 1s"
             , pointerEventsNone
             ]
                ++ standardShadow
            )
        , mediaQuery desktop
            [ class Notification
                [ width (px 280) ]
            ]
        , class NotificationBody
            [ padding4 (px 20) (px 60) (px 20) (px 20)
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
                    , lineHeight 1.35
                    ]
                , a
                    [ fontSize inherit
                    , color inherit
                    , borderBottom3 (px 1) solid white
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
            , regularTransition
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
                [ transform (scale 1.15)
                ]
            ]
        , class NotificationVisible
            [ opacity 1
            , pointerEventsAll
            ]
        , class Banner
            [ color white
            , textAlign center
            , maxWidth (px 300)
            , zIndex 10
            ]
        , class BannerLogo
            [ width (px 180)
            , height (px 180)
            , position relative
            , margin3 auto auto (px 15)
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
                    , opacity 0
                    , regularTransition
                    ]
                ]
            , hover
                [ children
                    [ div
                        [ opacity 1
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
            , transform (translate3d (px 0) (px 0) (px 0))
            , property "transition" "transform .3s"
            , zIndex 15
            ]
        , class MenuLinks
            [ display block
            , position absolute
            , top (pct 50)
            , left (pct 50)
            , transform (translate3d (pct -50) (pct -50) (px 0))
            , height auto
            , textAlign center
            ]
        , class MenuLink
            [ cursor pointer
            , display block
            , color blue
            , padding2 (px 10) (px 0)
            , property "text-decoration" "none"
            , property "font-weight" "300"
            , letterSpacing (Css.rem 0.1)
            , fontSize (Css.rem 1.5)
            ]
        , class Header
            [ width (pct 100)
            , height (px 60)
            , displayFlex
            , position absolute
            , top (px 0)
            , left (px 0)
            , color blue
            , zIndex 16
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
            , regularTransition
            , opacity 0.7
            , hover
                [ opacity 1
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
            , padding2 (px 4) (px 12)
            , borderRadius (px 3)
            , opacity 0.6
            , fontSize (Css.rem 1)
            , letterSpacing (Css.rem 0.05)
            , property "font-kerning" "normal"
            , margin2 (px 0) (px 10)
            , property "transition" "all .3s"
            , hover
                [ opacity 1
                ]
            ]
        , class DesktopLinkActive
            [ opacity 1
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
            [ padding3 (px 40) (px 20) (px 20)
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
                    [ margin2 (Css.rem 1.5) (Css.rem 0)
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
                    , lineHeight 1.68
                    ]
                , each [ p, li, ul ]
                    [ fontFamily inherit
                    ]
                , ul
                    [ margin (px 0)
                    , listStylePosition inside
                    , padding (px 0)
                    ]
                , li
                    [ margin2 (px 10) (px 0)
                    ]
                , a
                    [ fontFamily inherit
                    , color blue
                    , opacity 0.8
                    , hover
                        [ opacity 1
                        , borderBottom3 (px 1) solid currentColor
                        ]
                    ]
                , blockquote
                    [ property "font-family" serif
                    , margin3 (px 40) (px 0) (px 20)
                    , color grey
                    , fontStyle italic
                    , paddingLeft (px 16)
                    , borderLeft3 (px 3) solid grey
                    ]
                ]
            ]
        , mediaQuery desktop
            [ class Static
                [ padding2 (px 60) (px 20)
                , descendants
                    [ h2
                        [ marginBottom (Css.rem 3)
                        , marginTop (Css.rem 3)
                        ]
                    , p
                        [ margin2 (Css.rem 2.05) (px 0)
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
            , transform (translate3d (pct -50) (pct -50) (px 0))
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
            , opacity 0.6
            , position relative
            , property "transition" "opacity .3s"
            , borderColor blue
            , property "border-width" "1px"
            , borderStyle solid
            , hover
                [ opacity 1
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
            , transform (translate3d (px 0) (px 0) (px 0))
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
                    [ transform (translate3d (px 14) (px 0) (px 0))
                    ]
                ]
            ]
        , class Project
            [ display block
            , margin2 (px 40) auto
            , padding (px 20)
            , maxWidth (px 640)
            , width (pct 100)
            , textDecoration none
            , textAlign left
            , color currentColor
            , regularTransition
            , border3 (px 1) solid transparent
            , firstOfType
                [ marginTop (px 0)
                ]
            , lastOfType
                [ marginBottom (px 0)
                ]
            , descendants
                [ h3
                    [ margin3 (Css.rem 1) (Css.rem 0) (Css.rem 0)
                    ]
                , p
                    [ marginTop (px 0)
                    ]
                ]
            , hover [ border3 (px 1) solid lightGrey ]
            ]
        , mediaQuery desktop
            [ class Project
                [ margin2 (px 80) auto
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
            , zIndex 14
            ]
        , class ProjectBoxContent
            [ width (pct 100)
            , height (pct 100)
            , overflowY scroll
            , property "-webkit-overflow-scrolling" "touch"
            , padding3 (px 100) (px 40) (px 60)
            ]
        , class TextBox
            [ backgroundColor white
            , width (pct 100)
            , height (pct 100)
            , position fixed
            , regularTransition
            ]
        , class TextBoxHidden
            [ opacity 0
            , pointerEventsNone
            ]
        , class TextBoxDisplayPrimary
            [ descendants
                [ class TextBoxContent
                    [ nthOfType "2"
                        [ opacity 0
                        , pointerEventsNone
                        ]
                    ]
                ]
            ]
        , class TextBoxDisplaySecondary
            [ descendants
                [ class TextBoxContent
                    [ nthOfType "1"
                        [ opacity 0
                        , pointerEventsNone
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
            , padding2 (px 40) (px 0)
            , overflowY scroll
            , property "-webkit-overflow-scrolling" "touch"
            , margin auto
            , regularTransition
            ]
        , class TextBoxSwitch
            [ position fixed
            , bottom (px 15)
            , left (px 15)
            , zIndex 3
            ]
        , class TextBoxSwitchHidden
            [ display none
            ]
        ]


primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
