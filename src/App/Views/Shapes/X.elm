module Views.Shapes.X exposing (..)

import Html exposing (Html)
import Svg exposing (svg, g, line)
import Svg.Attributes exposing (viewBox, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, x1, y1, x2, y2, textRendering)


view : Html a
view =
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
