module Views.Shapes exposing (..)

import Html exposing (Html)
import Svg exposing (svg, g, path, polyline, rect, line, circle, polygon)
import Svg.Attributes exposing (viewBox, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, d, points, transform, textRendering, x, y, width, height, rx, x1, x2, y1, y2, cx, cy, r)


ripsaw : Html msg
ripsaw =
    svg [ viewBox "0 0 400 400" ]
        [ path [ d "M45.4297887,217.655867 L74.9021163,107.635798 C76.0485964,100.674591 71.7449043,93.8451811 64.7791798,91.9814291 C55.3647965,89.4688873 45.9482607,86.9488165 36.5306485,84.4298212 C92.5379953,5.39661381 197.162823,-22.1789628 284.887611,18.9703628 C372.611323,60.1218396 418.227008,158.172278 393.167549,251.721438 C368.107014,345.270597 279.573925,407.43342 183.010574,399.283793 C86.4450693,391.13309 9.59950662,315.009311 0.59411679,218.586217 C10.011729,221.106288 19.4282648,223.625283 28.8426481,226.142127 C35.8009038,228.00489 42.9353637,224.24711 45.4297887,217.655867 Z M51.8137869,216.323294 C59.4177347,216.331471 67.0211692,216.338971 74.6273114,216.345795 C79.2855314,210.62374 83.4626461,205.825602 87.1554263,201.949232 C93.8155616,199.585119 96.2340044,204.390786 94.4042969,216.363005 C99.0635933,210.6431 103.240708,205.844962 106.933488,201.967517 C113.593623,199.603404 116.008837,204.409071 114.181282,216.382365 C118.840579,210.661385 123.015541,205.862172 126.710474,201.984726 C133.370609,199.622765 135.785823,204.427355 133.955039,216.399574 C138.617564,210.679669 142.792526,205.880456 146.486383,202.005162 C153.146518,199.641049 155.564961,204.44564 153.733101,216.418934 C158.392397,210.697954 162.569512,205.899817 166.261216,202.022371 C172.92458,199.658259 175.34087,204.463925 173.510087,216.437219 C178.169383,210.716239 182.346497,205.919177 186.039278,202.041731 C192.700489,199.676543 195.114627,204.48221 193.284919,216.454428 C197.947445,210.735599 202.122407,205.936386 205.816263,202.061092 C212.476399,199.695904 214.893765,204.50157 213.062981,216.472713 C217.722278,210.753884 221.899392,205.954671 225.591096,202.079376 C232.252308,199.714188 234.669674,204.52093 232.841043,216.493149 C238.869391,216.498527 244.897739,216.50498 250.930393,216.511434 C257.225663,216.515736 262.737388,212.29088 264.365827,206.213885 C267.038276,196.23363 269.712878,186.252299 272.386404,176.274195 C274.370022,168.863488 269.97119,161.249496 262.557646,159.267213 C201.761275,143.002224 140.96389,126.738249 80.1684428,110.475286 L51.8137869,216.323294 Z M21.5604122,109.178788 C24.6214052,109.998376 27.681322,110.815813 30.742315,111.6354 C38.1580119,113.618759 42.5611492,121.232751 40.5753784,128.642383 C35.7836973,146.529185 30.9920163,164.418139 26.2003352,182.306017 C24.2156407,189.715649 16.5954471,194.112597 9.18190279,192.129238 C6.11983346,191.30965 3.05991673,190.491138 0,189.67155 C1.49713126,160.728918 8.38974707,134.999027 21.5604122,109.178788 Z" ]
            []
        ]


smallLogo : Html msg
smallLogo =
    svg [ viewBox "0 0 1000 1000" ]
        [ path [ d "M507.606,77.743c2.035,0.488 4.114,0.819 6.104,1.465c3.992,1.297 7.755,3.215 11.15,5.682c1.693,1.23 3.182,2.717 4.773,4.076l262.626,262.626c3.608,4.225 4.81,5.128 7.356,10.124c5.714,11.215 5.722,25.089 0,36.32c-2.546,4.997 -3.748,5.899 -7.356,10.124l-102.086,102.086c-3.189,2.723 -6.404,5.46 -10.125,7.356c-3.74,1.906 -7.756,3.211 -11.902,3.868c-2.067,0.327 -4.172,0.328 -6.258,0.492l-104.063,0c-2.086,-0.164 -4.191,-0.165 -6.258,-0.492c-16.552,-2.622 -30.613,-16.601 -33.25,-33.251c-2.622,-16.552 6.328,-34.244 21.348,-41.897c3.74,-1.906 7.757,-3.211 11.902,-3.867c2.067,-0.328 4.172,-0.329 6.258,-0.493l87.495,0l62.086,-62.086l-222.626,-222.625l-82.891,0l0,618.802c-0.329,4.179 -0.667,8.388 -1.958,12.36c-1.297,3.992 -3.214,7.755 -5.681,11.151c-1.23,1.693 -2.718,3.182 -4.077,4.773l-107.221,107.222c-1.591,1.358 -3.08,2.846 -4.773,4.076c-13.558,9.851 -33.385,9.908 -47.023,0c-13.558,-9.851 -19.74,-28.689 -14.531,-44.721c1.297,-3.992 3.215,-7.755 5.682,-11.151c1.23,-1.693 2.717,-3.182 4.076,-4.773l95.506,-95.506l0,-642.233l0.493,-6.258c1.297,-5.403 1.321,-6.905 3.867,-11.902c4.732,-9.287 13.274,-16.632 23.279,-19.883c5.334,-1.733 6.822,-1.522 12.361,-1.957l139.46,0c2.086,0.164 4.172,0.328 6.257,0.492Z" ] []
        ]


newamerica : Html msg
newamerica =
    svg [ viewBox "0 -25 170 170" ]
        [ rect [ height "22.6", width "164.6", x "0.1", y "96.4" ]
            []
        , rect [ height "23.9", width "164.6", x "0.1", y "48.6" ]
            []
        , rect [ height "23.9", width "124.4", x "40.3", y "0.9" ]
            []
        , path [ d "M13.2,26.4c7.3,0,13.2-5.9,13.2-13.2C26.4,5.9,20.5,0,13.2,0C5.9,0,0,5.9,0,13.2C0,20.5,5.9,26.4,13.2,26.4" ]
            []
        ]


theseed : Html msg
theseed =
    svg [ viewBox "0 0 200 200" ]
        [ path [ d "M100.592649,61.0007188 C89.9527396,61.0007188 80.1376028,46.0108639 68.8641582,19.2789456 C45.1261781,48.6683999 30.3779811,89.2063942 31.8200074,122.75257 C33.5142631,162.166412 56.2752579,185.777491 100.112499,185.777491 C144.077564,185.777491 166.826786,162.14139 168.434722,122.669198 C169.799568,89.1644747 155.011068,48.6751902 131.303053,19.2957605 C120.729151,46.0174464 111.291338,61.0007188 100.592649,61.0007188 Z M77.7541721,13.1771415 C78.6502611,12.394302 79.5975609,11.6245708 80.5943616,10.8788001 C93.8967595,0.926420715 108.799753,-0.0656382832 122.354802,13.1978696 C123.104817,11.2836421 123.856387,9.31599448 124.608647,7.29882041 C125.988611,3.59846643 130.79644,2.67189638 133.452763,5.59437285 C162.239954,37.2659325 180.560865,84.1372288 178.973741,123.098514 C177.142628,168.049331 149.927684,196.325251 100.112499,196.325251 C50.4327564,196.325251 23.2112708,168.08709 21.2819794,123.205561 C19.6080182,84.2638341 37.818136,37.4308108 66.5639685,5.75057783 C69.1830278,2.86416267 73.9202382,3.71792749 75.3668308,7.33707568 C76.1649202,9.33377031 76.9610109,11.2817133 77.7541721,13.1771415 Z M82.2622191,23.4408379 C84.8422806,29.0114474 87.3706339,33.9263918 89.8133974,38.048723 C92.3686399,42.36087 94.7636021,45.6819296 96.9029138,47.8687054 C98.691992,49.6974772 100.013895,50.4529591 100.592649,50.4529591 C102.322702,50.4529591 106.373513,46.1897373 110.958334,38.0799424 C113.225697,34.06935 115.554419,29.3101599 117.916423,23.9287655 C107.442218,11.3841101 97.3128285,11.5437311 86.9130908,19.3244438 C85.2907749,20.5382026 83.8230678,21.8454479 82.5473181,23.1469985 C82.4477878,23.2485417 82.3527297,23.3465685 82.2622191,23.4408379 Z" ]
            []
        ]


nlx : Html msg
nlx =
    svg [ viewBox "0 0 200 200" ]
        [ g [ transform "translate(3.000000, 62.000000)" ]
            [ polygon
                [ points "155.726218 37.7403935 186.528167 6.55285037 193 0 179.270629 0 174.809198 4.51728173 148.882554 30.7684879 142.161741 37.5734348 121.102213 58.8965968 120.818289 59.1840752 113 67.1007898 113 72.8956921 113 77 116.952006 77 122.239547 71.6462665 129.538036 64.2569644 129.53749 64.2569644 149.041442 44.5094055" ]
                []
            , polygon
                [ points "157.839396 41 151 47.5855236 181.678791 77 195 77" ]
                []
            , polygon
                [ points "146 28.2335419 122.330914 4.48371823 117.835119 0 104 0 110.521681 6.50471129 139.215867 35" ]
                []
            , polygon
                [ points "9.83360985 0 0 0 0 2.03612148 0 77 9.83360985 77 9.83360985 11.8656735 59 60.983027 59 47.113297 11.8699043 0" ]
                []
            , polygon
                [ points "78.7495255 67.170448 78.2329693 66.6518811 78.198826 66.6518811 72.8030722 61.2345706 72.8030722 61.2008472 71.7914372 60.1858271 71.7914372 55.5867246 71.7914372 0 62 0 62 45.7571726 62 50.3894457 62 64.2569644 69.3606496 71.6462665 70.59697 72.8873995 74.6936236 77 88.50737 77 93.1216812 77 109 77 109 67.170448 83.3302439 67.170448" ]
                []
            ]
        ]


overeasy : Html msg
overeasy =
    svg [ viewBox "0 0 200 200" ]
        [ g [ transform "translate(27,-0)" ]
            [ path [ d "M108.407382,80.5926184 C98.7165254,70.9700076 87.0808478,66.1587744 73.5,66.1587744 C59.9191522,66.1587744 48.3175969,70.9700076 38.6949861,80.5926184 C29.0041298,90.2834746 24.1587744,101.919152 24.1587744,115.5 C24.1587744,129.080848 29.0041298,140.682403 38.6949861,150.305014 C48.3175969,159.99587 59.9191522,164.841226 73.5,164.841226 C87.0808478,164.841226 98.7165254,159.99587 108.407382,150.305014 C118.029992,140.682403 122.841226,129.080848 122.841226,115.5 C122.841226,101.919152 118.029992,90.2834746 108.407382,80.5926184 Z M125.502786,167.400418 C111.102992,181.800211 93.7689036,189 73.5,189 C53.2310964,189 35.9311302,181.800211 21.5995822,167.400418 C7.19978873,153.06887 0,135.768904 0,115.5 C0,95.2310964 7.19978873,77.8970079 21.5995822,63.4972145 C35.9311302,49.1656665 53.2310964,42 73.5,42 C93.7689036,42 111.102992,49.1656665 125.502786,63.4972145 C139.834333,77.8970079 147,95.2310964 147,115.5 C147,135.768904 139.834333,153.06887 125.502786,167.400418 Z" ]
                []
            , path [ d "M35.7774069,33.5505943 C49.0309993,26.0933881 61.7370155,22.4486189 74,22.4486189 C86.2629845,22.4486189 98.9690007,26.0933881 112.222593,33.5505943 C117.63438,36.5955659 124.495498,34.6867433 127.547329,29.2871198 C130.59916,23.8874963 128.686038,17.0417993 123.274251,13.9968277 C106.789332,4.72149854 90.329734,0 74,0 C57.670266,0 41.2106676,4.72149854 24.7257495,13.9968277 C19.3139623,17.0417993 17.4008398,23.8874963 20.4526708,29.2871198 C23.5045017,34.6867433 30.3656197,36.5955659 35.7774069,33.5505943 Z" ]
                []
            ]
        ]


splytlight : Html msg
splytlight =
    svg [ viewBox "0 0 500 500" ]
        [ g [ stroke "none", transform "translate(239.500000, 276.500000) rotate(10.000000) translate(-239.500000, -276.500000) translate(50.000000, 17.000000)" ]
            [ g [ transform "translate(163.237814, 302.480884) rotate(15.000000) translate(-163.237814, -302.480884) translate(46.237814, 109.980884)" ]
                [ path [ d "M153.492504,199.701707 C153.492504,185.894588 142.299623,174.701707 128.492504,174.701707 C114.685385,174.701707 103.492504,185.894588 103.492504,199.701707 L103.492504,359.46192 C103.492504,373.269039 114.685385,384.46192 128.492504,384.46192 C142.299623,384.46192 153.492504,373.269039 153.492504,359.46192 L153.492504,199.701707 Z" ]
                    []
                , path [ d "M190.252322,52.3963645 L113.313133,175.229105 C105.98382,186.930289 109.527921,202.357554 121.229105,209.686867 C132.930289,217.01618 148.357554,213.472079 155.686867,201.770895 L233.497959,77.5461703 C215.842021,75.3467506 200.418913,65.9555867 190.25232,52.3963645 Z" ]
                    []
                , path [ d "M0.45936666,25.7862312 L99.9109551,196.106075 C106.873098,208.029376 122.182775,212.051188 134.106075,205.089045 C146.029376,198.126902 150.051188,182.817225 143.089045,170.893925 L43.8139034,0.876261419 C33.5839328,14.3666434 18.1270867,23.6753006 0.45936666,25.7862312 Z" ]
                    []
                ]
            , g [ transform "translate(280.822664, 114.403094)" ]
                [ circle
                    [ cx "49", cy "49", r "49" ]
                    []
                ]
            , g [ transform "translate(54.000000, 0.000000)" ]
                [ circle
                    [ cx "49", cy "49", r "49" ]
                    []
                ]
            ]
        ]


elmgameroom : Html msg
elmgameroom =
    svg [ viewBox "0 0 1000 1000" ]
        [ path [ d "M964.593,955.179l0.039,-480.472l-239.825,240.412l239.786,240.06Z" ] []
        , path [ d "M945.226,974.796l-240.531,-240.235l-240.074,240.131l480.605,0.104Z" ] []
        , path [ d "M961.451,346.235l-177.246,0l0,-177.043l177.246,177.043Z" ] []
        , path [ d "M565.758,754.337l194.156,-194.088l-194.156,-194.233l0,388.321Z" ] []
        , path [ d "M432.422,304.428l-198.543,198.472l-198.395,-198.472l396.938,0Z" ] []
        , path [ d "M226.843,692.162l222.333,222.255l0,-438.84l-222.333,216.585Z" ] []
        , path [ d "M35.204,574.808l0.317,400.185l399.879,-0.211l-400.196,-399.974Z" ] []
        ]


arrow : Html msg
arrow =
    svg
        [ viewBox "0 0 100 100"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        , strokeWidth "7"
        , fill "none"
        ]
        [ g [ transform "translate(16, 30)" ]
            [ polyline [ points "68.0398236 11 59.7022701 18.0675195 15 18.0675195" ] []
            , g []
                [ path [ d "M0,17.6684458 L19.4432202,0" ] []
                , path [ d "M0,18 L19.3248439,37.6608273" ] []
                ]
            ]
        ]


close : Html msg
close =
    svg
        [ viewBox "0 0 100 100"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        , strokeWidth "8"
        ]
        [ g []
            [ line
                [ x1 "15"
                , y1 "15"
                , x2 "85"
                , y2 "85"
                ]
                []
            , line
                [ x1 "15"
                , y1 "85"
                , x2 "85"
                , y2 "15"
                ]
                []
            ]
        ]


logo : Html msg
logo =
    svg [ viewBox "0 0 250 250" ]
        [ g
            [ fill "none"
            , strokeWidth "4"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ path [ d "M61.448 142.317l-30.25 38.185M62.64 141.508l5.252-6.632M134.531 168.821l-49.135 62.035M114.354 108.486l-6.871 8.672M134.342 136.304l2.552 2.021M89.19 139.857l5.102 4.042M69.929 136.03l-1.531-1.214M149.816 123.639l6.63 5.253M146.425 100.271l-3.571-2.829M151.295 136.38l5.25-6.633M97.741 139.791l-3.234 4.083M103.38 114.391l3.572 2.83M64.849 108.217l-7.655-6.062M93.991 89.203l-.806 1.02M91.807 69.421l43.505-54.926M141.342 83.504l38.554-48.672M60.737 96.724l-3.638 4.59M98.255 180.171l-33.049 41.723M179.162 179.579l-44.297 55.926M174.547 139.149l4.041-5.101M52.646 102.221L23.085 78.806M200.8 131.006l26.115-32.973M178.588 134.048l22.212-3.042M174.547 139.149l4.615 40.43M132.129 145.695l2.402 23.126M142.502 97.482l-1.16-13.978M93.991 89.203l-2.184-19.782M100.947 97.696l2.433 16.695M114.354 108.486l22.085-3.35M156.446 128.892l14.946-1.268M136.914 138.51l14.381-2.13M116.793 137.493l17.549-1.189M97.741 139.791l6.082-1.112M94.292 143.899l3.963 36.272M109.14 131.434l-2.188-14.213M67.892 134.876l-3.043-26.659M52.646 102.221l4.453-.907" ] []
            ]
        ]
