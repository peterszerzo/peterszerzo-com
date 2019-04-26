module Site.Ui exposing
    ( sansSerif, serif
    , black, white, dark
    , desktop
    , globalStyles
    , banner, layout, mainNav, static, switch
    )

{-| Ui kit

@docs sansSerif, serif

@docs black, white, dark

@docs desktop

@docs globalStyles

-}

import Css exposing (..)
import Css.Global as Global
import Css.Media as Media
import Html.Styled exposing (Html, a, div, fromUnstyled, h1, header, nav, p, span, text)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onClick)
import Markdown exposing (toHtml)
import Site.Content as Content
import Site.Ui.Icons as Icons



-- Fonts


sansSerif : String
sansSerif =
    "'PT Sans', sans-serif"


serif : String
serif =
    "'PT Serif', serif"



-- Colors


lavender : Color
lavender =
    rgb 182 199 238


faintLavender : Color
faintLavender =
    rgba 182 199 238 0.2


mint : Color
mint =
    rgb 50 201 143


blue : Color
blue =
    rgb 45 81 135


lightBlue : Color
lightBlue =
    rgb 64 96 145


faintBlue : Color
faintBlue =
    rgba 21 72 127 0.08


mustard : Color
mustard =
    hex "EEB902"


faintMustard : Color
faintMustard =
    rgba 238 185 2 0.2


black : Color
black =
    hex "000000"


dark : Color
dark =
    hex "232323"


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


desktop =
    Media.withMediaQuery [ "screen and (min-width: 600px)" ]


zIndex : Int -> Style
zIndex i =
    property "z-index" (i |> String.fromInt)


lineHeight : Float -> Style
lineHeight =
    String.fromFloat
        >> property "line-height"


pointerEventsNone : Style
pointerEventsNone =
    property "pointer-events" "none"


regularTransition : Style
regularTransition =
    property "transition" "all .3s"


titleType : Style
titleType =
    Css.batch
        [ fontSize (Css.rem 1.75)
        , lineHeight 1.68
        , property "font-family" serif
        ]


bodyType : Style
bodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , lineHeight 1.68
        ]


highlightedBodyType : Style
highlightedBodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , property "font-weight" "600"
        ]



-- Global styles


globalStyles : Html msg
globalStyles =
    Global.global
        [ Global.everything
            [ boxSizing borderBox
            , property "font-family" sansSerif
            , property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        , Global.each [ Global.html, Global.body ]
            [ margin (px 0)
            , padding (px 0)
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        , Global.a
            [ textDecoration none
            , border (px 0)
            ]
        , Global.each [ Global.h1, Global.h2, Global.h3 ] [ fontWeight normal ]
        , Global.h2
            [ fontSize (Css.rem 2)
            , desktop
                [ fontSize (Css.rem 3)
                , margin3 (Css.rem 1.4) (Css.rem 0) (Css.rem 3)
                ]
            ]
        , Global.h3
            [ fontSize (Css.rem 1.5)
            , margin2 (Css.rem 0.5) (Css.rem 0)
            , desktop
                [ fontSize (Css.rem 2)
                ]
            ]
        , Global.selector ".Spinner"
            [ position absolute
            , top (pct 40)
            , left (pct 50)
            , transform (translate3d (pct -50) (pct -50) (px 0))
            , Global.descendants
                [ Global.svg
                    [ fill blue
                    , property "animation" "spin 1s ease-in-out infinite"
                    ]
                ]
            ]
        ]



--Elements


banner : Html msg
banner =
    div
        [ css
            [ displayFlex
            , alignItems center
            , justifyContent center
            , position relative
            , width (pct 100)
            , height (pct 100)
            , zIndex 10
            ]
        ]
        [ div
            [ css
                [ maxWidth (px 360)
                , textAlign center
                , color black
                , position relative
                ]
            ]
            [ h1
                [ css
                    [ margin3 (px 5) auto (px 0)
                    , titleType
                    ]
                ]
                [ text Content.title
                ]
            , p
                [ css
                    [ margin4 (px 0) (px 0) (px 30) (px 0)
                    , fontSize (rem 1)
                    , letterSpacing (rem 0.02)
                    ]
                ]
                [ text Content.subtitle ]
            , mainNav
            ]
        ]


layout :
    { content : List (Html msg)
    , breadcrumbs : List { url : Maybe String, label : String }
    , quirkyContent : Maybe (List (Html msg))
    , isQuirky : Bool
    , onQuirkyChange : Bool -> msg
    }
    -> Html msg
layout config =
    let
        c1 =
            config.content

        c2 =
            config.quirkyContent

        isQuirky =
            config.isQuirky

        displayPrimary =
            not isQuirky || c2 == Nothing

        buttonStyles =
            Css.batch
                [ width (px 60)
                , height (px 60)
                , padding (px 14)
                , zIndex 3
                , cursor pointer
                , opacity (num 0.8)
                , property "transition" "all 0.3s"
                , hover
                    [ opacity (num 1)
                    ]
                ]

        contentStyles isActive =
            Css.batch
                [ width (pct 100)
                , height (pct 100)
                , paddingTop (px 60)
                , position absolute
                , top (px 0)
                , left (px 0)
                , overflowY auto
                , property "-webkit-overflow-scrolling" "touch"
                , margin auto
                , regularTransition
                , desktop
                    [ paddingTop (px 60)
                    ]
                , Css.batch <|
                    if isActive then
                        []

                    else
                        [ opacity (num 0)
                        , pointerEventsNone
                        ]
                ]
    in
    div
        [ css
            [ backgroundColor white
            , textAlign center
            , color darkGrey
            , width (pct 100)
            , height (pct 100)
            , position fixed
            , left (px 0)
            , top (px 0)
            , zIndex 14
            , regularTransition
            , Global.descendants
                [ Global.h2
                    [ textAlign center
                    ]
                ]
            ]
        ]
        [ header
            [ css
                [ position absolute
                , top (px 0)
                , left (px 0)
                , width (pct 100)
                , height (px 60)
                , zIndex 15
                , backgroundColor (rgba 255 255 255 0.95)
                , displayFlex
                , after
                    [ property "content" "' '"
                    , bottom (px 0)
                    , left (px 0)
                    , right (px 0)
                    , height (px 4)
                    , position absolute
                    , linearGradient2 toRight
                        (stop lavender)
                        (stop lavender)
                        [ stop faintLavender
                        , stop lavender
                        ]
                        |> backgroundImage
                    ]
                , padding (px 0)
                , alignItems center
                , justifyContent spaceBetween
                , Global.descendants
                    [ Global.h1
                        [ fontSize (Css.rem 1)
                        , desktop
                            [ fontSize (Css.rem 1.25)
                            ]
                        ]
                    ]
                ]
            ]
            [ a
                [ href "/"
                , css
                    [ buttonStyles
                    , property "stroke" "#000"
                    , hover
                        [ opacity (num 1)
                        , property "transform" "scale(1.1)"
                        ]
                    ]
                ]
                [ Icons.smallLogo |> fromUnstyled
                ]
            , h1 []
                (config.breadcrumbs
                    |> List.map
                        (\b ->
                            a
                                ([ css
                                    [ cursor pointer
                                    , property "font-family" serif
                                    , color inherit
                                    , Css.batch <|
                                        if b.url /= Nothing then
                                            [ borderBottom3 (px 1) solid currentColor
                                            ]

                                        else
                                            []
                                    ]
                                    |> Just
                                 , b.url |> Maybe.map href
                                 ]
                                    |> List.filterMap identity
                                )
                                [ text b.label ]
                        )
                    |> List.intersperse
                        (span
                            [ css
                                [ display inlineBlock
                                , marginLeft (px 8)
                                , marginRight (px 8)
                                , property "font-family" serif
                                ]
                            ]
                            [ text "//" ]
                        )
                )
            , div
                [ css
                    [ buttonStyles
                    , displayFlex
                    , alignItems center
                    , justifyContent center
                    , Css.batch <|
                        if c2 == Nothing then
                            [ opacity (num 0.01)
                            , property "pointer-events" "none"
                            , hover
                                [ opacity (num 0.01)
                                ]
                            ]

                        else
                            []
                    ]
                , onClick (config.onQuirkyChange (not config.isQuirky))
                ]
                [ switch isQuirky
                ]
            ]
        , div
            [ css [ height (pct 100) ] ]
            [ div [ css [ contentStyles displayPrimary ] ] c1
            , c2
                |> Maybe.map (div [ css [ contentStyles <| not displayPrimary ] ])
                |> Maybe.withDefault (div [ css [ contentStyles <| not displayPrimary ] ] [])
            ]
        ]



-- Main nav


mainNavLink : ( String, String ) -> Html msg
mainNavLink ( label, url ) =
    a
        [ href url
        , css
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
        ]
        [ text label ]


mainNav : Html msg
mainNav =
    nav
        [ css
            [ width (pct 100)
            , padding2 (px 0) (px 20)
            , maxWidth (px 420)
            , zIndex 9
            , color white
            ]
        ]
        [ div
            [ css
                [ width (pct 100)
                , textAlign center
                ]
            ]
            (List.map mainNavLink Content.mainLinks)
        ]


static : { children : List (Html msg), markdown : Maybe String } -> Html msg
static { children, markdown } =
    div
        [ css
            [ width (pct 100)
            , maxWidth (px 680)
            , padding2 (px 20) (px 20)
            , margin auto
            , textAlign left
            , color black
            , Global.descendants
                [ Global.everything
                    [ property "font-family" serif
                    ]
                , Global.h2
                    [ textAlign center
                    ]
                , Global.h1
                    [ property "font-family" serif
                    , margin (px 0)
                    , fontSize (Css.rem 3)
                    ]
                , Global.selector "iframe"
                    [ margin2 (px 10) (px 0)
                    ]
                , Global.p
                    [ margin2 (Css.rem 1.5) (Css.rem 0)
                    , firstChild
                        [ paddingTop (px 0)
                        , marginTop (px 0)
                        ]
                    , lastChild
                        [ paddingBottom (px 0)
                        , marginBottom (px 0)
                        ]
                    , desktop
                        [ margin2 (Css.rem 1.875) (px 0)
                        ]
                    ]
                , Global.each [ Global.p, Global.li, Global.code ]
                    [ bodyType
                    ]
                , Global.each [ Global.p, Global.li, Global.ul, Global.strong ]
                    [ fontFamily inherit
                    ]
                , Global.strong
                    [ fontWeight bolder
                    ]
                , Global.ul
                    [ margin (px 0)
                    , listStylePosition inside
                    , padding (px 0)
                    ]
                , Global.code
                    [ property "font-family" "monospace"
                    , backgroundColor faintMustard
                    , padding2 (px 2) (px 4)
                    , borderRadius (px 2)
                    ]
                , Global.em
                    [ Global.descendants
                        [ Global.code
                            [ backgroundColor faintBlue
                            , fontStyle normal
                            ]
                        ]
                    ]
                , Global.each
                    [ Global.p
                    , Global.li
                    , Global.code
                    ]
                    [ desktop [ fontSize (Css.rem 1.25) ]
                    ]
                , Global.li
                    [ margin2 (px 10) (px 0)
                    ]
                , Global.img
                    [ width (pct 100)
                    , border3 (px 1) solid lightGrey
                    ]
                , Global.a
                    [ fontFamily inherit
                    , color currentColor
                    , borderBottom3 (px 1) solid currentColor
                    ]
                , Global.blockquote
                    [ property "font-family" serif
                    , margin3 (px 20) (px 0) (px 20)
                    , paddingLeft (px 16)
                    , padding2 (px 8) (px 16)
                    , backgroundColor (rgba 0 0 0 0.03)
                    , borderLeft3 (px 3) solid currentColor
                    ]
                ]
            ]
        ]
        ((markdown
            |> Maybe.map (toHtml [] >> fromUnstyled)
            |> Maybe.withDefault (text "")
         )
            :: children
        )


switch : Bool -> Html msg
switch isRight =
    let
        rightStyles =
            [ property "transition" "transform .3s"
            , transform (translate3d (px 12) (px 0) (px 0))
            ]
    in
    div
        [ css
            [ display inlineBlock
            , width (px 28)
            , height (px 16)
            , borderRadius (px 8)
            , overflow hidden
            , opacity (num 1)
            , position relative
            , property "transition" "opacity .3s"
            , borderColor black
            , property "border-width" "1px"
            , borderStyle solid
            ]
        ]
        [ div
            [ css
                [ width (px 16)
                , height (px 16)
                , borderRadius (pct 50)
                , boxSizing borderBox
                , border3 (px 1) solid black
                , backgroundColor white
                , position absolute
                , top (px -1)
                , left (px -1)
                , transform (translate3d (px 0) (px 0) (px 0))
                , property "z-index" "1"
                , Css.batch <|
                    if isRight then
                        rightStyles

                    else
                        []
                ]
            ]
            []
        , div
            [ css
                [ width (px 30)
                , height (px 16)
                , backgroundColor black
                , position absolute
                , top (px 0)
                , left (px -22)
                , property "z-index" "0"
                , Css.batch <|
                    if isRight then
                        rightStyles

                    else
                        []
                ]
            ]
            []
        ]
