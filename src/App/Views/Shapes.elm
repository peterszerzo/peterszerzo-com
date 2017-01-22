module Views.Shapes exposing (..)

import Html exposing (Html)
import Svg exposing (svg, g, path, polyline, rect, line)
import Svg.Attributes exposing (viewBox, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, d, points, transform, textRendering, x, y, width, height, rx, x1, x2, y1, y2)


arrow : Html a
arrow =
    svg
        [ viewBox "0 0 100 100"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        , strokeWidth "7"
        , fill "none"
        , textRendering "geometricPrecision"
        ]
        [ g [ transform "translate(16, 30)" ]
            [ polyline [ points "68.0398236 11 59.7022701 18.0675195 15 18.0675195" ] []
            , g []
                [ path [ d "M0,17.6684458 L19.4432202,0" ] []
                , path [ d "M0,18 L19.3248439,37.6608273" ] []
                ]
            ]
        ]


falafel : Bool -> Html a
falafel showAll =
    let
        height_ =
            6

        spacing =
            18

        startY =
            50 - spacing - 1.5 * height_
    in
        svg [ viewBox "0 0 100 100" ]
            [ g []
                [ rect
                    [ x "0"
                    , y (toString startY)
                    , width "100"
                    , height (toString height_)
                    , rx "3"
                    ]
                    []
                , rect
                    [ x "0"
                    , y (toString (startY + height_ + spacing))
                    , width "100"
                    , height (toString height_)
                    , rx "3"
                    ]
                    []
                , rect
                    [ x "0"
                    , y (toString (startY + 2 * height_ + 2 * spacing))
                    , width "100"
                    , height (toString height_)
                    , rx "3"
                    ]
                    []
                ]
            ]


close : Html a
close =
    svg
        [ viewBox "0 0 100 100"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        , strokeWidth "8"
        , textRendering "geometricPrecision"
        ]
        [ g []
            [ line
                [ x1 "10"
                , y1 "10"
                , x2 "90"
                , y2 "90"
                ]
                []
            , line
                [ x1 "10"
                , y1 "90"
                , x2 "90"
                , y2 "10"
                ]
                []
            ]
        ]


logo : Html a
logo =
    svg [ viewBox "0 0 250 250" ]
        [ g
            [ fill "none"
            , strokeWidth "3.5"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ path [ d "M61.448 142.317l-30.25 38.185M62.64 141.508l5.252-6.632M134.531 168.821l-49.135 62.035M114.354 108.486l-6.871 8.672M134.342 136.304l2.552 2.021M89.19 139.857l5.102 4.042M69.929 136.03l-1.531-1.214M149.816 123.639l6.63 5.253M146.425 100.271l-3.571-2.829M151.295 136.38l5.25-6.633M97.741 139.791l-3.234 4.083M103.38 114.391l3.572 2.83M64.849 108.217l-7.655-6.062M93.991 89.203l-.806 1.02M91.807 69.421l43.505-54.926M141.342 83.504l38.554-48.672M60.737 96.724l-3.638 4.59M98.255 180.171l-33.049 41.723M179.162 179.579l-44.297 55.926M174.547 139.149l4.041-5.101M52.646 102.221L23.085 78.806M200.8 131.006l26.115-32.973M178.588 134.048l22.212-3.042M174.547 139.149l4.615 40.43M132.129 145.695l2.402 23.126M142.502 97.482l-1.16-13.978M93.991 89.203l-2.184-19.782M100.947 97.696l2.433 16.695M114.354 108.486l22.085-3.35M156.446 128.892l14.946-1.268M136.914 138.51l14.381-2.13M116.793 137.493l17.549-1.189M97.741 139.791l6.082-1.112M94.292 143.899l3.963 36.272M109.14 131.434l-2.188-14.213M67.892 134.876l-3.043-26.659M52.646 102.221l4.453-.907" ] []
            ]
        ]


smallLogo : Html a
smallLogo =
    svg [ viewBox "0 0 100 100" ]
        [ g [ transform "translate(14.000000, 7.000000)" ]
            [ path [ d "M14.4448309,50.8528503 L19.2016279,81.8026945 C19.537365,83.9871498 21.5775105,85.4853895 23.7584204,85.1491067 C25.9393304,84.8128238 27.4351386,82.7693619 27.0994015,80.5849066 L22.5479132,50.9708923 L37.2906201,32.3336366 L68.1762871,25.8035559 C70.3353128,25.3470784 71.7161013,23.223949 71.2603647,21.0614136 C70.804628,18.8988783 68.6849444,17.5158451 66.5259187,17.9723226 L34.2555664,24.7951639 C33.7957369,24.8889186 33.3510193,25.0636465 32.9446365,25.3166521 C32.5305926,25.5779113 32.1873666,25.8914939 31.9063147,26.2521056 L18.1794558,43.6051592 L13.7247485,40.0700765 L8.39881428,3.46464527 C8.08060267,1.27755982 6.0525356,-0.237042427 3.8689997,0.081686468 C1.68546381,0.400415363 0.173319699,2.43177925 0.49153131,4.6188647 L6.04504916,42.7884905 C6.11524488,43.278898 6.27586505,43.756784 6.52375197,44.1948595 C6.80488095,44.6763595 7.13711833,45.0551959 7.52551669,45.3619513 L14.4448309,50.8528503 Z" ] []
            ]
        ]
