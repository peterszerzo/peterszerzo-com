module OverEasy.Views.Home exposing (..)

import Time
import Json.Decode as Decode
import Css exposing (..)
import Css.Media as Media
import Html.Styled exposing (Html, text, div, img, h2, a, p, fromUnstyled, br)
import Html.Styled.Attributes exposing (class, css, src, href)
import Html.Styled.Events exposing (onWithOptions)
import OverEasy.Views.Icons as Icons
import OverEasy.Views.Home.Bg
import Window


type alias Config msg =
    { delayedNavigate : String -> msg
    , navigate : String -> msg
    , links : List ( String, String )
    , page : Int
    , window : Window.Size
    , time : Time.Time
    , css : List Style
    }


link : { navigate : String -> msg, url : String, label : String, discrete : Bool } -> Html msg
link { navigate, url, label, discrete } =
    a
        [ href url
        , onWithOptions "click"
            { preventDefault = True
            , stopPropagation = False
            }
            (navigate url |> Decode.succeed)
        , css
            [ textDecoration none
            , color inherit
            , display inlineBlock
            , margin (px 6)
            , borderBottom3 (px 1) solid (transparent)
            , padding2 (px 4) (px 12)
            , borderRadius (px 16)
            , backgroundColor <|
                if discrete then
                    (rgba 0 0 0 0)
                else
                    (rgba 0 0 0 0.06)
            , border2 (px 1) solid
            , borderColor transparent
            , property "transition" "all 0.2s"
            , hover <|
                if discrete then
                    [ backgroundColor (rgba 0 0 0 0.04)
                    ]
                else
                    [ backgroundColor (hex "000")
                    , color (hex "ffc235")
                    ]
            , opacity
                (if url == "" then
                    (num 0.4)
                 else
                    (num 1.0)
                )
            , fontSize (Css.rem 0.875)
            , property "transform-origin" "center center"
            , property "-webkit-font-smoothing" "subpixel-antialiased"
            , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
                [ fontSize (Css.rem 1)
                ]
            ]
        ]
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
        , fontSize (Css.rem 0.875)
        , property "transform-origin" "center center"
        , property "-webkit-font-smoothing" "subpixel-antialiased"
        , firstOfType
            [ left (px -110)
            , property "transform" "rotateZ(-45deg)"
            , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
                [ left (px -150)
                ]
            ]
        , lastOfType
            [ right (px -110)
            , property "transform" "rotateZ(+45deg)"
            , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
                [ right (px -150)
                ]
            ]
        , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
            [ fontSize (Css.rem 1)
            , top (px -60)
            , width (px 200)
            ]
        ]


view : Config msg -> Html msg
view config =
    div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , position absolute
            , Css.top (px 0)
            , Css.left (px 0)
            , overflow hidden
            , backgroundColor (hex "ffc235")
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
                , color (hex "000000")
                , property "z-index" "10"
                ]
            ]
            [ div
                [ css
                    [ textAlign center
                    , position relative
                    , top (px 20)
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
                        , Media.withMediaQuery [ "screen and (min-width: 600px)" ]
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
                        [ br [] []
                        , text "~ bryhllaupp with "
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
                        , minHeight (px 160)
                        , marginTop (px 30)
                        ]
                    ]
                    [ if config.page > 0 then
                        link
                            { navigate = config.navigate
                            , url = "/?p=" ++ (toString <| config.page - 1)
                            , label = "Newer.."
                            , discrete = True
                            }
                      else
                        text ""
                    , config.links
                        |> List.reverse
                        |> List.drop (config.page * 3)
                        |> List.take 3
                        |> List.map
                            (\( url, label ) ->
                                link
                                    { navigate = config.delayedNavigate
                                    , url = url
                                    , label = label
                                    , discrete = False
                                    }
                            )
                        |> div []
                    , if (config.page + 1) * 3 < List.length config.links then
                        link
                            { navigate = config.navigate
                            , url = "/?p=" ++ (toString <| config.page + 1)
                            , label = "..Older"
                            , discrete = True
                            }
                      else
                        text ""
                    ]
                ]
            ]
        , OverEasy.Views.Home.Bg.view config.window config.time
        ]
