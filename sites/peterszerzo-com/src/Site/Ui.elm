module Site.Ui exposing (banner, contentBox, static, switch)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, div, fromUnstyled, h1, header, node, p, span, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Markdown exposing (toHtml)
import Site.Content as Content
import Site.Messages exposing (Msg(..))
import Site.Styles.Constants as Constants exposing (..)
import Site.Styles.Mixins as Mixins
import Site.Ui.Link as Link
import Site.Ui.Nav as Nav
import Site.Ui.Shapes as Shapes


banner : Html Msg
banner =
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
                [ maxWidth (px 360)
                , textAlign center
                , color white
                , position relative
                , Global.children
                    [ Global.svg
                        [ width (px 140)
                        , height (px 140)
                        ]
                    ]
                ]
            ]
            [ Shapes.logo |> fromUnstyled
            , h1
                [ css
                    [ margin3 (px 5) auto (px 10)
                    ]
                ]
                [ text Content.title
                ]
            , p
                [ css
                    [ marginTop (px 0)
                    , fontSize (rem 1.25)
                    , letterSpacing (rem 0.02)
                    ]
                ]
                [ text Content.subtitle ]
            , Nav.view
            ]
        ]


contentBox :
    { content : List (Html Msg)
    , breadcrumbs : List { url : Maybe String, label : String }
    , quirkyContent : Maybe (List (Html Msg))
    , isQuirky : Bool
    }
    -> Html Msg
contentBox config =
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
                , padding (px 15)
                , Mixins.zIndex 3
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
                , Mixins.regularTransition
                , Mixins.desktop
                    [ paddingTop (px 60)
                    ]
                , Css.batch <|
                    if isActive then
                        []

                    else
                        [ opacity (num 0)
                        , Mixins.pointerEventsNone
                        ]
                ]
    in
    div
        [ css
            [ backgroundColor Constants.white
            , textAlign center
            , color Constants.darkGrey
            , width (pct 100)
            , height (pct 100)
            , position fixed
            , left (px 0)
            , top (px 0)
            , Mixins.zIndex 14
            , Mixins.regularTransition
            , Global.descendants
                [ Global.h2
                    [ textAlign center
                    ]
                ]
            ]
        ]
        [ div
            [ css
                [ position absolute
                , top (px 0)
                , left (px 0)
                , width (pct 100)
                , height (px 60)
                , Mixins.zIndex 15
                , displayFlex
                , backgroundColor (rgba 255 255 255 0.92)
                , padding (px 0)
                , alignItems center
                , justifyContent spaceBetween
                , borderBottom3 (px 1) solid (rgba 0 0 0 0.1)
                , Global.descendants
                    [ Global.h1
                        [ fontSize (Css.rem 1)
                        , Mixins.desktop
                            [ fontSize (Css.rem 1.25)
                            ]
                        ]
                    ]
                ]
            ]
            [ Link.link
                { url = "/"
                , css =
                    [ buttonStyles
                    , property "stroke" "#000"
                    , hover
                        [ opacity (num 1)
                        , property "transform" "scale(1.1)"
                        ]
                    ]
                , children =
                    [ Shapes.smallLogo |> fromUnstyled
                    ]
                }
            , h1 []
                (config.breadcrumbs
                    |> List.map
                        (\b ->
                            span
                                ([ css
                                    [ cursor pointer
                                    , property "font-family" Constants.serif
                                    , Css.batch <|
                                        if b.url /= Nothing then
                                            [ borderBottom3 (px 1) solid currentColor
                                            ]

                                        else
                                            []
                                    ]
                                 ]
                                    ++ (b.url
                                            |> Maybe.map (\url -> [ onClick (Navigate url) ])
                                            |> Maybe.withDefault []
                                       )
                                )
                                [ text b.label ]
                        )
                    |> List.intersperse
                        (span
                            [ css
                                [ display inlineBlock
                                , marginLeft (px 8)
                                , marginRight (px 8)
                                , property "font-family" Constants.serif
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
                , onClick ToggleQuirky
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
                    [ property "font-family" Constants.serif
                    ]
                , Global.h2
                    [ textAlign center
                    ]
                , Global.h1
                    [ property "font-family" Constants.serif
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
                    , Mixins.desktop
                        [ margin2 (Css.rem 1.875) (px 0)
                        ]
                    ]
                , Global.each [ Global.p, Global.li, Global.code ]
                    Mixins.bodyType
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
                    [ Mixins.desktop [ fontSize (Css.rem 1.25) ]
                    ]
                , Global.li
                    [ margin2 (px 10) (px 0)
                    ]
                , Global.a
                    [ fontFamily inherit
                    , color currentColor
                    , borderBottom3 (px 1) solid currentColor
                    ]
                , Global.blockquote
                    [ property "font-family" Constants.serif
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
