module Maddi.Views exposing (..)

import Css exposing (..)
import Css.Foreign as Foreign
import Css.Media as Media
import Json.Decode as Decode
import Html.Styled exposing (Html, text, div, a, p, br, header, h2, fromUnstyled)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onWithOptions, onClick)
import Svg.Styled exposing (svg, path, line)
import Svg.Styled.Attributes exposing (d, viewBox, x1, x2, y1, y2)
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3
import Markdown


--

import Maddi.Data.Project as Project


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


borderColor_ : Color
borderColor_ =
    hex "#CECECE"


bodyType : Style
bodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , lineHeight (num 1.6)
        , mobile
            [ fontSize (Css.rem 1)
            ]
        ]


headingType : Style
headingType =
    Css.batch
        [ fontSize (Css.rem 1.25)
        , textDecoration none
        , color inherit
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
            [ fontSize (Css.rem 2)
            ]
        ]


largeLogo : Html msg
largeLogo =
    svg [ Svg.Styled.Attributes.viewBox "0 0 1000 1000" ]
        [ path [ Svg.Styled.Attributes.fill "currentColor", d """M484.082,340.547c-25.282,9.199 -67.21,23.411 -80.054,26.045c-12.546,2.573 -27.661,1.034 -43.858,4.21c-16.197,3.176 -32.909,16.196 -49.12,14.035c-16.212,-2.162 -28.433,-16.495 -35.087,-24.561c-6.654,-8.066 -10.479,-15.389 -9.122,-22.104c1.357,-6.716 13.5,-23.863 16.14,-34.034c2.639,-10.171 7.91,-25.245 0.701,-35.086c-7.745,-10.573 -20.106,-17.229 -42.805,-15.438c-7.22,0.569 -17.714,-10.396 -16.491,-16.14c1.179,-5.537 17.899,-7.984 23.508,-14.034c5.61,-6.051 22.438,-28.561 63.156,-28.07c37.914,0.458 73.851,7.461 115.784,3.509c41.933,-3.951 49.884,-20.058 77.19,-24.56c27.307,-4.503 48.489,-0.613 63.156,-7.018c14.667,-6.404 33.431,-25.286 41.752,-27.016c7.161,-1.489 4.666,1.88 10.175,1.754c5.509,-0.126 4.693,-5.658 9.846,-3.158c5.153,2.501 29.649,22.651 22.434,63.507c-6.867,38.882 -35.214,68.363 -56.138,84.207c-18.363,13.904 -67.864,36.63 -91.817,46.532c5.797,-0.111 11.274,1.448 14.627,5.045c5.436,5.833 6.268,14.337 1.626,22.563c2.188,-2.248 4.179,-4.345 5.742,-6.073c6.875,-7.6 14.933,-18.029 16.841,-19.648c3.973,-3.371 13.812,-6.751 24.21,-5.263c8.64,1.236 26.251,-9.836 34.385,-12.28c7.464,-2.243 34.481,-14.953 41.401,-16.14c6.438,-1.104 9.781,0.926 11.93,-1.754c1.846,-2.302 2.284,-11.823 4.912,-18.245c2.628,-6.422 6.462,-18.705 3.859,-22.455c-2.522,-3.634 -7.834,-4.399 -10.259,-8.07c-2.32,-3.513 -0.267,-5.906 0,-7.719c0.228,-1.548 -5.297,-13.975 -1.319,-24.21c3.978,-10.234 11.651,-19.954 17.543,-21.052c5.892,-1.097 12.069,-0.958 15.087,-0.35c3.019,0.607 4.126,3.47 6.316,3.859c2.189,0.389 7.228,4.589 8.42,8.07c1.176,3.43 -1.047,11.464 -1.403,15.087c-0.361,3.669 1.065,16.53 -1.403,20.701c-2.139,3.614 -3.614,9.68 -2.807,13.333c0.773,3.502 -2.953,18.85 -4.912,25.964c-1.696,6.155 -11.068,13.139 -12.281,15.438c-1.148,2.177 -1.604,12.809 -1.403,18.245c0.196,5.31 2.622,15.887 2.105,19.999c-0.48,3.818 8.318,22.405 13.684,30.525c5.365,8.119 14.268,18.072 15.438,19.999c1.369,2.257 8.659,30.423 13.332,40.349c4.225,8.972 11.297,39.184 10.877,47.016c-0.419,7.832 2.633,31.853 2.807,41.051c0.174,9.198 -1.001,51.003 -1.754,59.998c-0.749,8.946 -2.671,23.994 -1.404,35.437c1.268,11.443 1.766,17.227 3.158,21.052c1.493,4.101 0.323,9.747 2.105,10.876c1.763,1.118 11.752,-6.404 20.701,-6.315c8.95,0.088 18.659,5.793 22.806,3.158c4.148,-2.636 9.68,-11.795 10.877,-17.544c1.201,-5.768 0.913,-11.795 3.158,-17.894c2.244,-6.098 7.047,-15.939 11.228,-18.946c4.18,-3.008 11.11,-5.042 15.437,-2.807c4.531,2.34 4.921,13.368 11.228,17.894c2.562,1.839 4.356,12.692 10.175,16.14c4.907,2.906 7.755,10.136 9.824,11.578c2.71,1.888 1.297,7.095 3.509,10.877c2.175,3.718 11.504,9.055 10.175,16.14c-1.356,7.232 -17.249,12.097 -21.403,17.894c-4.003,5.586 -4.84,18.945 -7.719,23.157c-3.136,4.588 -9.595,7.611 -12.28,7.017c-2.514,-0.556 -3.002,-4.449 -5.965,-3.86c-2.676,0.533 -10.895,20.208 -22.455,33.683c-6.219,7.25 -18.18,22.462 -26.315,28.42c-7.991,5.854 -16.812,10.822 -21.753,9.473c-4.854,-1.325 -6.558,-18.483 -6.666,-23.157c-0.109,-4.667 -3.156,-5.547 -3.509,-7.719c-0.253,-1.557 0.322,-5.723 -2.105,-7.017c-5.201,-2.773 -17.474,-11.438 -21.052,-22.455c-3.69,-11.36 -0.512,-15.308 -1.053,-19.648c-0.604,-4.854 -1.855,-16.391 0,-21.754c1.856,-5.363 3.447,-7.085 4.211,-10.526c0.746,-3.36 -4.544,-27.148 -4.912,-39.998c-0.369,-12.851 0.97,-48.692 2.456,-59.921c0.759,-5.738 1.209,-23.489 0.701,-33.76c-0.491,-9.951 -1.329,-26.691 -1.052,-29.472c0.384,-3.866 0.362,-12.172 -0.351,-18.677c-0.864,-7.882 -3.24,-21.775 -5.889,-27.134c-4.361,-8.823 -12.945,-39.935 -17.268,-46.466c-4.323,-6.532 -18.338,-21.777 -25.262,-37.543c-4.289,-9.764 -7.849,-25.751 -8.772,-32.279c-0.976,-6.904 0.773,-15.535 -1.403,-17.192c-1.895,-1.443 -36.074,9.883 -47.718,15.438c-11.643,5.554 -32.255,8.864 -39.647,13.332c-8.768,5.3 -26.381,28.393 -33.332,35.438c-6.835,6.927 -25.731,26.385 -37.192,35.086c-6.693,5.082 -24.892,12.386 -35.437,16.491c-11.29,4.395 -27.141,12.111 -34.384,13.332c-13.99,2.358 -28.041,-1.506 -39.999,0.702c-11.957,2.208 -17.838,7.827 -22.104,9.473c-4.266,1.647 -25.119,1.993 -26.666,4.912c-1.547,2.92 0.961,3.839 1.404,5.614c0.288,1.16 -1.324,19.132 -4.211,34.034c-2.881,14.876 -4.995,36.557 -5.964,42.104c-1.449,8.292 -13.823,43.219 -17.544,64.909c-1.933,11.272 -6.942,23.696 -9.824,34.385c-2.664,9.88 -3.34,18.332 -2.105,21.753c2.571,7.123 9.597,9.338 13.333,14.386c3.151,4.257 6.382,17.768 8.238,29.121c1.472,9 5.835,16.45 5.796,21.754c-0.057,7.738 -3.201,9.919 -5.796,15.087c-1.567,3.122 -1.867,11.313 -0.785,19.561c1.35,10.279 -1.738,22.099 -2.19,31.314c-0.565,11.517 -9.563,25.883 -15.087,30.525c-4.981,4.185 -9.17,4.046 -14.386,6.316c-5.216,2.27 -5.728,9.859 -12.619,8.771c-6.891,-1.087 -7.201,-7.457 -8.783,-9.473c-1.636,-2.084 -4.326,-2.001 -5.263,-4.912c-1.118,-3.47 -0.67,-6.339 -2.807,-7.719c-2.152,-1.389 -8.228,-10.6 -11.228,-23.508c-3.064,-13.187 1.589,-19.258 -0.351,-27.718c-1.87,-8.159 -5.666,-9.556 -7.719,-14.736c-1.433,-3.616 0.362,-4.27 -1.403,-9.473c-1.555,-4.583 -17.333,-21.023 -14.133,-38.245c3.201,-17.221 13.076,-35.139 26.764,-41.752c14.311,-6.915 21.659,-1.648 25.964,-3.86c4.304,-2.212 6.072,-15.13 6.666,-20.35c0.595,-5.22 12.792,-52.808 15.789,-63.155c2.998,-10.348 8.251,-25.065 8.772,-36.841c0.286,-6.488 3.458,-26.523 6.666,-40.349c3.064,-13.206 3.596,-25.464 1.053,-27.367c-3.263,-2.443 -8.202,3.6 -15.438,3.859c-7.236,0.259 -9.706,-3.64 -15.087,-4.912c-5.382,-1.273 -16.902,1.738 -22.105,-2.105c-5.451,-4.027 -2.688,-10.649 -5.614,-16.14c-2.926,-5.491 -23.439,-17.247 -28.069,-38.946c-4.63,-21.698 -0.973,-31.008 2.456,-34.735c4.041,-4.392 6.498,-3.485 8.421,-4.912c1.923,-1.428 -1.368,-3.544 1.754,-6.316c3.123,-2.772 14.394,-3.04 20,-0.351c5.605,2.69 6.188,9.951 10.175,12.982c3.987,3.031 8.351,2.281 11.929,5.965c3.715,3.824 7.747,11.034 8.07,16.49c0.308,5.2 14.092,11.648 14.736,19.298c0.582,6.917 -5.827,27.818 -1.754,31.578c4.073,3.759 12.144,-7.451 22.104,-7.719c4.418,-0.119 18.26,-0.971 23.859,-4.211c6.054,-3.503 23.119,-8.824 30.174,-10.175c13.028,-2.494 23.526,1.031 29.823,0.351c6.072,-0.655 34.57,-9.499 54.033,-19.999c19.464,-10.5 28.254,-26.293 34.034,-31.578c1.49,-1.362 5.69,-5.393 10.465,-10.097c-10.07,5.434 -24.623,5.117 -29.762,-2.183c-5.422,-7.701 -2.913,-20.636 3.916,-27.799Zm74.888,-149.081c-10.381,1.57 -21.974,2.667 -33.894,3.904c-27.679,2.873 -45.16,21.951 -96.136,27.017c-52.24,5.191 -82.89,-8.321 -111.926,-6.666c-23.655,1.347 -32.984,12.76 -37.893,16.894c-4.909,4.133 -4.231,9.108 3.158,10.876c7.389,1.768 13.755,-0.245 13.721,3.509c-0.034,3.762 -4.728,0.359 -5.3,5.509c-0.573,5.149 8.027,8.395 16.841,9.525c8.814,1.131
        13.614,16.318 10.526,38.595c-3.088,22.278 -20.166,34.418 -20.35,44.56c-0.184,10.142 7.815,16.193 14.034,17.894c6.22,1.701 22.519,-8.874 37.894,-12.28c14.862,-3.293 34.267,-0.554 59.646,-4.561c25.38,-4.008 64.331,-30.057 80.699,-37.894c16.21,-7.761 84.198,-35.973 98.241,-53.331c13.078,-16.164 32.988,-54.35 38.595,-63.155c5.608,-8.805 -0.934,-28.036 -7.368,-30.174c-6.433,-2.139 -14.652,10.604 -27.718,19.648c-3.904,2.702 -8.955,4.786 -14.857,6.456l0,0c5.946,5.081 -1.125,19.806 -5.844,22.315c-4.719,2.509 -14.346,3.89 -17.192,0c-3.491,-4.772 1.282,-15.606 5.123,-18.641l0,0Zm-231.781,48.815c8.031,-5.403 14.715,-8.327 19.298,-2.807c4.583,5.52 0.574,15.836 -7.368,17.894c-7.943,2.058 -15.869,1.704 -17.544,-3.859c-1.675,-5.564 0.706,-7.926 5.614,-11.228Z""" ] []
        ]


static : String -> Html msg
static markdownContent =
    div
        [ css
            [ overflow auto
            , Foreign.descendants
                [ Foreign.each [ Foreign.p, Foreign.li ]
                    [ bodyType
                    ]
                , Foreign.each [ Foreign.a ]
                    [ linkType
                    ]
                ]
            , Foreign.children
                [ Foreign.everything
                    [ Foreign.children
                        [ Foreign.everything
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
                , Foreign.children
                    [ Foreign.everything
                        [ firstChild
                            [ color (hex "000")
                            ]
                        ]
                    ]
                ]
            ]
        , onWithOptions "click" { preventDefault = True, stopPropagation = False } (Decode.succeed navigate)
        , href "/"
        ]
        [ largeLogo
        ]


customLink : { navigate : String -> msg, url : String, css : Style } -> List (Html msg) -> Html msg
customLink config children =
    a
        ([ href config.url
         , css [ config.css ]
         ]
            ++ (if List.member (String.left 4 config.url) [ "http", "mail" ] then
                    []
                else
                    [ onWithOptions "click" { preventDefault = True, stopPropagation = False } (config.navigate config.url |> Decode.succeed) ]
               )
        )
        children


link : (String -> msg) -> String -> List (Html msg) -> Html msg
link navigate url children =
    customLink { navigate = navigate, url = url, css = linkType } children


intro : (String -> msg) -> Html msg
intro navigate =
    div
        [ css
            [ bodyType
            ]
        ]
        [ p [ css [ marginTop (px -4) ] ]
            [ text "My name is Anna. I design sets for theatre pieces like "
            , link navigate "/projects/karmafulminien" [ text "Karmafulminien" ]
            , text " and "
            , link navigate "/projects/story-of-qu" [ text "Story of Qu" ]
            , text ", and I also work in opera."
            ]
        , p []
            [ text "I studied at Accademia di Brera, trained at Teatro alla Scala, currently based in Reggio Emilia and Milan, traveling across Italy with brief escapades to New York, Sydney, and wherever next."
            ]
        ]


matrixTransform : Matrix4.Mat4 -> Style
matrixTransform matrix =
    let
        r =
            Matrix4.toRecord matrix
    in
        property "transform"
            ("matrix3d("
                ++ ([ [ r.m11, r.m12, r.m13, r.m14 ]
                    , [ r.m21, r.m22, r.m23, r.m24 ]
                    , [ r.m31, r.m32, r.m33, r.m34 ]
                    , [ r.m41, r.m42, r.m43, r.m44 ]
                    ]
                        |> List.foldr (++) []
                        |> List.map toString
                        |> String.join ","
                   )
                ++ ")"
            )


wingTransform : { skewAngle : Float, scale : Float, w : Float, offset : Int } -> Style
wingTransform { skewAngle, scale, w, offset } =
    [ "skewX(" ++ (toString skewAngle) ++ "rad)"
    , "rotate(" ++ (toString skewAngle) ++ "rad)"
    , "scale(" ++ (toString scale) ++ ")"
    , "translate3d("
        ++ (toString (w * (toFloat offset) - (scale - 1) * 40))
        ++ "px, "
        ++ (toString
                (if skewAngle > 0 then
                    w * (tan (-skewAngle)) + (scale - 1) * 16
                 else
                    0
                )
           )
        ++ "px, 0)"
    ]
        |> String.join " "
        |> property "transform"


wing :
    { navigate : String -> msg
    , order : Int
    , project : Project.Project
    , selected : Maybe String
    }
    -> Html msg
wing { navigate, order, project, selected } =
    let
        translation =
            Matrix4.makeTranslate (Vector3.vec3 0 0 0)

        rotation =
            Matrix4.makeRotate 0.9 (Vector3.vec3 0 1 0)

        perspective =
            Matrix4.makeLookAt
                (Vector3.vec3 0 0.05 0.1)
                (Vector3.vec3 0 0 0)
                (Vector3.vec3 0 0 -1)

        matrix =
            rotation
                |> Matrix4.mul translation
                |> Matrix4.mul perspective

        skewAngle =
            -20 * pi / 180

        width_ =
            140
    in
        customLink
            { css =
                Css.batch
                    [ display block
                    , textDecoration none
                    , color inherit
                    , position absolute
                    , left (px ((2 * width_ * 1.06417) * (toFloat order)))
                    , overflow visible
                    , property "z-index" "100"
                    , property "transition" "all 0.2s"
                    , case selected of
                        Just projectId ->
                            Css.batch <|
                                if projectId == project.id then
                                    []
                                else
                                    [ opacity (num 0.3)
                                    ]

                        Nothing ->
                            Css.batch []
                    , Foreign.children
                        [ Foreign.div
                            [ width (px width_)
                            , height (px 240)
                            , position absolute
                            , stickoutStyles { hover = False }
                            , property "word-break" "break-all"
                            , property "transition" "all 0.2s ease-in-out"
                            ]
                        ]
                    , hover
                        [ property "z-index" "101"
                        , Foreign.children
                            [ Foreign.div
                                [ stickoutStyles { hover = True }
                                ]
                            ]
                        ]
                    ]
            , navigate = navigate
            , url = "/projects/" ++ project.id
            }
            [ div
                [ css
                    [ wingTransform
                        (if selected == Just project.id then
                            { skewAngle = skewAngle * 0.65
                            , w = width_
                            , offset = 0
                            , scale = 1.15
                            }
                         else
                            { skewAngle = skewAngle
                            , w = width_
                            , offset = 0
                            , scale = 1
                            }
                        )
                    , padding (px 10)
                    , displayFlex
                    , flexDirection column
                    , justifyContent spaceBetween
                    ]
                ]
                [ h2
                    [ css
                        [ fontSize (Css.rem 1.5)
                        , textTransform uppercase
                        , margin (px 0)
                        , fontWeight normal
                        ]
                    ]
                    [ text (project.title) ]
                , p
                    [ css
                        [ fontSize (Css.rem 1.5)
                        , color (hex "ADADAD")
                        , margin (px 0)
                        ]
                    ]
                    [ project.openedAt
                        |> (\( year, month, day ) ->
                                text (toString month ++ " / " ++ toString year)
                           )
                    ]
                ]
            , div
                [ css
                    [ padding (px 6)
                    , wingTransform
                        (if selected == Just project.id then
                            { skewAngle = -skewAngle * 0.65
                            , scale = 1.15
                            , w = width_
                            , offset = 1
                            }
                         else
                            { skewAngle = -skewAngle
                            , scale = 1
                            , w = width_
                            , offset = 1
                            }
                        )
                    , property "background-size" "cover"
                    , property "background-position" "50% 50%"
                    , property "background-clip" "content-box"
                    , property "background-image"
                        (project.imgs
                            |> List.head
                            |> Maybe.map (\( img, alt ) -> "linear-gradient(45deg, rgba(255, 255, 255, 0.30), rgba(255, 255, 255, 0.15)), url(" ++ img ++ ")")
                            |> Maybe.withDefault ""
                        )
                    ]
                ]
                []
            ]


iconContainer : { handleClick : msg, css : Style } -> List (Html msg) -> Html msg
iconContainer config children =
    div
        [ css
            [ cursor pointer
            , Foreign.descendants
                [ Foreign.svg
                    [ width (px 30)
                    , height (px 30)
                    ]
                , Foreign.line
                    [ property "stroke" "#000"
                    , property "stroke-width" "2"
                    ]
                ]
            , config.css
            ]
        , onClick config.handleClick
        ]
        children


siteHeader : { navigate : String -> msg, mobileNav : Bool, setMobileNav : Bool -> msg } -> Html msg
siteHeader { navigate, mobileNav, setMobileNav } =
    let
        links =
            [ ( "/", "home" )
            , ( "/about", "about" )
            , ( "mailto:annamcingi@gmail.com", "contact" )
            ]
    in
        header
            [ css
                [ position absolute
                , top (px 0)
                , padding2 (px 20) (px 20)
                , left (px 0)
                , width (pct 100)
                , alignItems start
                , marginBottom (px 20)
                , property "z-index" "10000"
                , backgroundColor white
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
                [ customLink
                    { css =
                        Css.batch
                            [ width (px 220)
                            , displayFlex
                            , textDecoration none
                            , color inherit
                            ]
                    , url = "/"
                    , navigate = navigate
                    }
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
                        [ largeLogo
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
                            customLink
                                { url = url
                                , css =
                                    Css.batch
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
                                , navigate = navigate
                                }
                                [ text label ]
                        )
                        (List.tail links |> Maybe.withDefault [])
                    )
                , if mobileNav then
                    div
                        [ css
                            [ position fixed
                            , property "z-index" "10000"
                            , top (px 0)
                            , left (px 0)
                            , width (vw 100)
                            , height (vh 100)
                            , padding2 (px 45) (px 20)
                            , textAlign right
                            , backgroundColor (rgba 255 255 255 0.9)
                            , display none
                            , mobile [ display block ]
                            ]
                        ]
                        [ iconContainer { handleClick = (setMobileNav False), css = Css.batch [] }
                            [ svg [ Svg.Styled.Attributes.viewBox "0 0 100 100" ]
                                [ line [ x1 "20", y1 "20", x2 "80", y2 "80" ] []
                                , line [ x1 "80", y1 "20", x2 "20", y2 "80" ] []
                                ]
                            ]
                        , div
                            [ css
                                []
                            ]
                            (List.map
                                (\( url, label ) ->
                                    customLink
                                        { url = url
                                        , navigate = navigate
                                        , css =
                                            Css.batch
                                                [ display block
                                                , margin (px 0)
                                                , lineHeight (num 1)
                                                , padding2 (px 10) (px 0)
                                                , headingType
                                                ]
                                        }
                                        [ text label ]
                                )
                                links
                            )
                        ]
                  else
                    iconContainer
                        { handleClick = (setMobileNav (not mobileNav))
                        , css =
                            Css.batch
                                [ display none
                                , mobile [ display block ]
                                ]
                        }
                        [ svg
                            [ Svg.Styled.Attributes.viewBox "0 0 100 100" ]
                            [ line [ x1 "10", y1 "30", x2 "90", y2 "30" ] []
                            , line [ x1 "10", y1 "50", x2 "90", y2 "50" ] []
                            , line [ x1 "10", y1 "70", x2 "90", y2 "70" ] []
                            ]
                        ]
                ]
            ]


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
                , property "transition" "border-color 0.2s"
                , borderColor
                    (if hover then
                        (hex "444")
                     else
                        borderColor_
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


layout : List (Html msg) -> Html msg
layout children =
    let
        stickout =
            10
    in
        div
            [ css
                [ padding (px 20)
                , position relative
                , width (pct 100)
                , margin2 (px 60) auto
                , height (px 400)
                , property "animation" "fadein 0.5s ease-in-out forwards"
                , mobile
                    [ height auto
                    ]
                , stickoutStyles { hover = False }
                ]
            ]
            ([ div
                [ css
                    [ position absolute
                    , property "z-index" "9"
                    , borderRight3 (px 1) solid borderColor_
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
                    , Foreign.children
                        [ Foreign.everything
                            [ property "width" "calc(50% - 20px)"
                            , position relative
                            , height (pct 100)
                            , property "z-index" "10"
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
            )
