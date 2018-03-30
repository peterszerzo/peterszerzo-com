module Views.ContentBox exposing (..)

import Html exposing (Html, div, h1, span)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Messages exposing (..)
import Views.Switch
import Views.Shapes


type alias Config =
    { content : List (Html Msg)
    , breadcrumbs : List { url : Maybe String, label : String }
    , quirkyContent : Maybe (List (Html Msg))
    , isQuirky : Bool
    }


view : Config -> Html Msg
view config =
    let
        c1 =
            config.content

        c2 =
            config.quirkyContent

        isQuirky =
            config.isQuirky
    in
        div
            [ localClassList
                [ ( Root, True )
                , ( DisplayPrimary, not isQuirky || c2 == Nothing )
                , ( DisplaySecondary, isQuirky && c2 /= Nothing )
                ]
            ]
            [ div [ localClass [ Header ] ]
                [ div
                    [ localClass [ BackLink ]
                    , onClick (Navigate "/")
                    ]
                    [ Views.Shapes.smallLogo
                    ]
                , h1 []
                    (config.breadcrumbs
                        |> List.map
                            (\b ->
                                span
                                    ([ localClassList
                                        [ ( HeaderText, True )
                                        , ( HeaderTextLink, b.url /= Nothing )
                                        ]
                                     ]
                                        ++ (b.url
                                                |> Maybe.map (\url -> [ onClick (Navigate url) ])
                                                |> Maybe.withDefault []
                                           )
                                    )
                                    [ Html.text b.label ]
                            )
                        |> List.intersperse (span [ localClass [ HeaderDivider ] ] [ Html.text "//" ])
                    )
                , div
                    [ localClassList
                        [ ( Switch, True )
                        , ( SwitchHidden, (c2 == Nothing) )
                        ]
                    , onClick ToggleQuirky
                    ]
                    [ Views.Switch.view isQuirky NoOp
                    ]
                ]
            , div
                [ localClass [ Contents ] ]
                [ div [ localClass [ Content ] ] c1
                , c2
                    |> Maybe.map (div [ localClass [ Content ] ])
                    |> Maybe.withDefault (div [ localClass [ Content ] ] [])
                ]
            ]


cssNamespace : String
cssNamespace =
    "ContentBox"


type CssClasses
    = Root
    | Header
    | HeaderDivider
    | HeaderText
    | HeaderTextLink
    | Hidden
    | DisplayPrimary
    | DisplaySecondary
    | Content
    | Contents
    | BackLink
    | Switch
    | SwitchHidden


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ backgroundColor white
        , textAlign center
        , color darkGrey
        , width (pct 100)
        , height (pct 100)
        , position fixed
        , left (px 0)
        , top (px 0)
        , Mixins.zIndex 14
        , Mixins.regularTransition
        , descendants
            [ Elements.h2
                [ textAlign center
                ]
            ]
        ]
    , class Header
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
        , descendants
            [ Elements.h1
                [ fontSize (Css.rem 1)
                ]
            ]
        ]
    , mediaQuery desktop
        [ class Header
            [ descendants
                [ Elements.h1
                    [ fontSize (Css.rem 1.25)
                    ]
                ]
            ]
        ]
    , class HeaderDivider
        [ display inlineBlock
        , marginLeft (px 8)
        , marginRight (px 8)
        , property "font-family" Styles.Constants.serif
        ]
    , class HeaderText
        [ property "font-family" Styles.Constants.serif
        ]
    , class HeaderTextLink
        [ borderBottom3 (px 1) solid currentColor
        , cursor pointer
        ]
    , class Hidden
        [ opacity (num 0)
        , Mixins.pointerEventsNone
        ]
    , class DisplayPrimary
        [ descendants
            [ class Content
                [ nthOfType "2"
                    [ opacity (num 0)
                    , Mixins.pointerEventsNone
                    ]
                ]
            ]
        ]
    , class DisplaySecondary
        [ descendants
            [ class Content
                [ nthOfType "1"
                    [ opacity (num 0)
                    , Mixins.pointerEventsNone
                    ]
                ]
            ]
        ]
    , class Contents
        [ height (pct 100)
        ]
    , class Content
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
        ]
    , mediaQuery desktop
        [ class Content
            [ paddingTop (px 60)
            ]
        ]
    , each [ class Switch, class BackLink ]
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
    , class BackLink
        [ hover
            [ opacity (num 1)
            , property "transform" "scale(1.1)"
            ]
        ]
    , class Switch
        [ displayFlex
        , alignItems center
        , justifyContent center
        ]
    , class BackLink
        [ property "stroke" "#000"
        ]
    , class SwitchHidden
        [ opacity (num 0.01)
        , property "pointer-events" "none"
        , hover
            [ opacity (num 0.01)
            ]
        ]
    ]
        |> namespace cssNamespace
