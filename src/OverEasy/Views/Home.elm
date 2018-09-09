module OverEasy.Views.Home exposing (Config, link, smallTextStyles, textStyles, tiltedSubtitleStyle, view)

import Css exposing (..)
import Html.Styled exposing (Html, a, br, div, fromUnstyled, h2, img, p, text)
import Html.Styled.Attributes exposing (class, css, href, src)
import Json.Decode as Decode
import OverEasy.Constants exposing (..)
import OverEasy.Views.Home.Bg
import OverEasy.Views.Icons as Icons
import String.Future
import Time


type alias Config =
    { links : List ( String, String )
    , page : Int
    , window : { width : Int, height : Int }
    , time : Float
    , css : List Style
    }


textStyles : Style
textStyles =
    Css.batch
        [ fontSize (Css.rem 0.875)
        , desktop
            [ fontSize (Css.rem 1)
            ]
        ]


smallTextStyles : Style
smallTextStyles =
    Css.batch
        [ fontSize (Css.rem 0.5)
        , desktop
            [ fontSize (Css.rem 0.625)
            ]
        ]


link : { url : Maybe String, label : String, discrete : Bool } -> Html msg
link { url, label, discrete } =
    a
        ((case url of
            Just linkUrl ->
                [ href linkUrl
                ]

            Nothing ->
                []
         )
            ++ [ css
                    [ textDecoration none
                    , color inherit
                    , display inlineBlock
                    , borderBottom3 (px 1) solid transparent
                    , if url /= Nothing then
                        Css.batch [ opacity (num 1.0) ]

                      else
                        Css.batch
                            [ opacity (num 0.6)
                            , pointerEvents none
                            ]
                    , if discrete then
                        Css.batch
                            [ padding2 (px 2) (px 6)
                            , margin (px 2)
                            , backgroundColor (rgba 0 0 0 0)
                            , smallTextStyles
                            ]

                      else
                        Css.batch
                            [ padding2 (px 4) (px 12)
                            , margin (px 6)
                            , backgroundColor (rgba 0 0 0 0.06)
                            , textStyles
                            ]
                    , borderRadius (px 16)
                    , border2 (px 1) solid
                    , borderColor transparent
                    , property "transition" "all 0.2s"
                    , hover <|
                        if discrete then
                            [ backgroundColor (rgba 0 0 0 0.04)
                            ]

                        else
                            [ backgroundColor black
                            , color yellow
                            ]
                    ]
               ]
        )
        [ text label ]


tiltedSubtitleStyle : Style
tiltedSubtitleStyle =
    Css.batch
        [ position absolute
        , top (px -60)
        , width (px 150)
        , lineHeight (num 1.4)
        , textAlign center
        , letterSpacing (Css.rem 0.08)
        , padding2 (px 2) (px 6)
        , borderRadius (px 16)
        , backgroundColor yellow
        , property "transform-origin" "center center"
        , textStyles
        , fontWeight bold
        , firstOfType
            [ left (px -110)
            , property "transform" "rotateZ(-45deg)"
            , desktop
                [ left (px -150)
                ]
            ]
        , lastOfType
            [ right (px -110)
            , property "transform" "rotateZ(+45deg)"
            , desktop
                [ right (px -150)
                ]
            ]
        , desktop
            [ top (px -60)
            , width (px 200)
            ]
        ]


view : Config -> Html msg
view config =
    div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , position absolute
            , top (px 0)
            , left (px 0)
            , overflow hidden
            , backgroundColor yellow
            , Css.batch config.css
            ]
        ]
        [ div
            [ css
                [ width (pct 100)
                , height (pct 100)
                , position absolute
                , top (px 0)
                , left (px 0)
                , displayFlex
                , alignItems center
                , justifyContent center
                , color black
                , property "z-index" "10"
                ]
            ]
            [ div
                [ css
                    [ textAlign center
                    , position relative
                    , top (px 40)
                    , padding (px 20)
                    ]
                ]
                [ div
                    [ css
                        [ width (px 120)
                        , height (px 120)
                        , margin auto
                        , position relative
                        , fontSize (Css.rem 0.875)
                        , desktop
                            [ width (px 140)
                            , height (px 140)
                            ]
                        ]
                    ]
                    [ Icons.logo
                    , h2
                        [ css
                            [ tiltedSubtitleStyle
                            ]
                        ]
                        [ text "~ it's like computer art ~" ]
                    , h2
                        [ css
                            [ tiltedSubtitleStyle
                            ]
                        ]
                        [ text "~ bryhllaupp with "
                        , a
                            [ css
                                [ textDecoration none
                                , color inherit
                                , hover
                                    [ borderBottom3 (px 1) solid currentColor
                                    ]
                                ]
                            , href "http://peterszerzo.com"
                            ]
                            [ text "peter" ]
                        , text " ~"
                        ]
                    ]
                , div
                    [ css
                        [ maxWidth (px 480)
                        , minHeight (px 180)
                        , marginTop (px 30)
                        ]
                    ]
                    [ div [ css [ marginBottom (px 10) ] ]
                        [ link
                            { url =
                                if config.page > 0 then
                                    "/?nosmooth=true&p=" ++ (String.Future.fromInt <| config.page - 1) |> Just

                                else
                                    Nothing
                            , label = "<- Newer.."
                            , discrete = True
                            }
                        , link
                            { url =
                                if (config.page + 1) * 3 < List.length config.links then
                                    "/?nosmooth=true&p=" ++ (String.Future.fromInt <| config.page + 1) |> Just

                                else
                                    Nothing
                            , label = "Older ->"
                            , discrete = True
                            }
                        ]
                    , config.links
                        |> List.reverse
                        |> List.drop (config.page * 3)
                        |> List.take 3
                        |> List.map
                            (\( url, label ) ->
                                link
                                    { url = Just url
                                    , label = label
                                    , discrete = False
                                    }
                            )
                        |> div []
                    ]
                ]
            ]
        , OverEasy.Views.Home.Bg.view config.window config.time
        ]
