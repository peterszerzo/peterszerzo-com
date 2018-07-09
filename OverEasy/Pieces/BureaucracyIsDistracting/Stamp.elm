module Pieces.BureaucracyIsDistracting.Stamp exposing (..)

import Time
import Html exposing (Html, text)
import Svg exposing (svg, path, line, rect, g, defs, linearGradient, stop)
import Svg.Attributes exposing (id, viewBox, x, y, x1, x2, y1, y2, width, height, rx, ry, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, d, offset, stopColor)
import Pieces.BureaucracyIsDistracting.Constants as Constants


toPx : Float -> String
toPx =
    toString
        >> (\p -> p ++ "%")


gradient : { id : String, phase : Float, isHorizontal : Bool } -> Html msg
gradient config =
    let
        factor =
            sin config.phase

        blackStart =
            8 - 4 * factor |> toPx

        blackEnd =
            92 + 3 * factor |> toPx

        redStart =
            20
                + 20
                * (1 + factor)
                |> toPx

        redEnd =
            45
                + 20
                * (1 + factor)
                |> toPx
    in
        linearGradient
            (if config.isHorizontal then
                [ id config.id
                , x1 "0%"
                , x2 "100%"
                , y1 "0%"
                , y2 "0%"
                ]
             else
                [ id config.id
                , x1 "0%"
                , x2 "0%"
                , y1 "0%"
                , y2 "100%"
                ]
            )
            [ stop [ offset "0%", stopColor "#000" ] []
            , stop [ offset redStart, stopColor "#000" ] []
            , stop [ offset redStart, stopColor Constants.red ] []
            , stop [ offset redEnd, stopColor Constants.red ] []
            , stop [ offset redEnd, stopColor "#000" ] []
            , stop [ offset "100%", stopColor "#000" ] []
            ]


view : { time : Time.Time, singleSnake : Bool } -> Html msg
view config =
    svg [ viewBox "0 0 160 160" ]
        [ defs
            []
            [ gradient { id = "snake1", phase = config.time / 960, isHorizontal = False }
            , gradient { id = "snake2", phase = config.time / 1080, isHorizontal = True }
            ]
        , rect
            [ x "20"
            , y "24"
            , rx "6"
            , ry "6"
            , width "98"
            , height "98"
            , fill "none"
            , stroke "#000"
            , strokeWidth "2"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            []
        , path
            [ fill "none"
            , stroke "#000"
            , strokeWidth "2"
            , strokeLinecap "round"
            , stroke "#000"
            , strokeLinejoin "round"
            , d <|
                "M126,18 "
                    ++ (String.repeat 5 "l0,6 t2,2 l6,0 t2,2 l0,6 t-2,2 l-6,0 t-2,2")
            ]
            []
        , path
            [ fill "none"
            , stroke "#000"
            , strokeWidth "2"
            , strokeLinecap "round"
            , stroke "url(#snake1)"
            , strokeLinejoin "round"
            , d <|
                "M1,24 "
                    ++ (String.repeat 5 "l0,6 t2,2 l6,0 t2,2 l0,6 t-2,2 l-6,0 t-2,2")
            ]
            []
        , path
            [ fill "none"
            , stroke "#000"
            , strokeWidth "2"
            , stroke "#000"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            , d <|
                "M20,132 "
                    ++ (String.repeat 5 "l6,0 t2,2 l0,6 t2,2 l6,0 t2,-2 l0,-6 t2,-2")
            ]
            []
        , path
            [ fill "none"
            , stroke "#000"
            , strokeWidth "2"
            , strokeLinecap "round"
            , stroke <|
                if config.singleSnake then
                    "#000"
                else
                    "url(#snake2)"
            , strokeLinejoin "round"
            , d <|
                "M14,4 "
                    ++ (String.repeat 5 "l6,0 t2,2 l0,6 t2,2 l6,0 t2,-2 l0,-6 t2,-2")
            ]
            []
        ]
