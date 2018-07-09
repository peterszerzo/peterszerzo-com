module Views.ContentBox exposing (..)

import Html.Styled exposing (Html, div, h1, span, text, fromUnstyled)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Css exposing (..)
import Css.Foreign as Foreign
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Messages exposing (..)
import Views.Switch
import Views.Shapes
import Views.Link as Link


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

        displayPrimary =
            not isQuirky || c2 == Nothing
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
                , Mixins.zIndex 14
                , Mixins.regularTransition
                , Foreign.descendants
                    [ Foreign.h2
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
                    , Foreign.descendants
                        [ Foreign.h1
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
                        [ Views.Shapes.smallLogo |> fromUnstyled
                        ]
                    }
                , h1 []
                    (config.breadcrumbs
                        |> List.map
                            (\b ->
                                span
                                    ([ css
                                        [ cursor pointer
                                        , property "font-family" Styles.Constants.serif
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
                                    , property "font-family" Styles.Constants.serif
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
                    [ Views.Switch.view isQuirky NoOp
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
