module BureaucracyIsDistracting.Stamp exposing (view)

import BureaucracyIsDistracting.Constants as Constants
import Html exposing (Html)
import Svg exposing (defs, linearGradient, path, rect, stop, svg)
import Svg.Attributes
    exposing
        ( d
        , fill
        , height
        , id
        , offset
        , rx
        , ry
        , stopColor
        , stroke
        , strokeLinecap
        , strokeLinejoin
        , strokeWidth
        , viewBox
        , width
        , x
        , x1
        , x2
        , y
        , y1
        , y2
        )


toPercentString : Float -> String
toPercentString =
    String.fromFloat
        >> (\p -> p ++ "%")


strokeAttrs =
    [ strokeWidth "6"
    , strokeLinecap "round"
    , strokeLinejoin "round"
    , fill "none"
    ]


view :
    { time : Float
    , scale : Float
    }
    -> Html msg
view config =
    svg
        [ viewBox "0 0 160 160"
        , (160 * config.scale) |> String.fromFloat |> width
        , (160 * config.scale) |> String.fromFloat |> height
        ]
        [ rect
            ([ x "30"
             , y "30"
             , rx "8"
             , ry "8"
             , width "100"
             , height "100"
             , stroke Constants.black
             ]
                ++ strokeAttrs
            )
            []
        , path
            ([ stroke Constants.black
             , d <|
                "M142,28 "
                    ++ String.repeat 4 "l0,6 t4,4 l6,0 t4,4 l0,6 t-4,4 l-6,0 t-4,4"
             ]
                ++ strokeAttrs
            )
            []
        , path
            ([ stroke Constants.black
             , d <|
                "M4,34 "
                    ++ String.repeat 3 "l0,6 t4,4 l6,0 t4,4 l0,6 t-4,4 l-6,0 t-4,4"
             ]
                ++ strokeAttrs
            )
            []
        , path
            ([ stroke Constants.red
             , d <|
                "M40,142 "
                    ++ String.repeat 3 "l6,0 t4,4 l0,6 t4,4 l6,0 t4,-4 l0,-6 t4,-4"
             ]
                ++ strokeAttrs
            )
            []
        , path
            ([ stroke Constants.red
             , d <|
                "M20,4 "
                    ++ String.repeat 4 "l6,0 t4,4 l0,6 t4,4 l6,0 t4,-4 l0,-6 t4,-4"
             ]
                ++ strokeAttrs
            )
            []
        ]
