module Shapes.Arrow exposing (..)

import Svg exposing (svg, g, path, polyline)
import Svg.Attributes exposing (viewBox, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, d, points, transform, textRendering)

view =
  svg
  [ viewBox "0 0 100 100"
  , strokeLinecap "round"
  , strokeLinejoin "round"
  , strokeWidth "7"
  , textRendering "geometricPrecision"]
  [ g [transform "translate(16, 30)"]
    [ polyline [points "68.0398236 11 59.7022701 18.0675195 15 18.0675195"] []
    , g []
      [ path [d "M0,17.6684458 L19.4432202,0"] []
      , path [d "M0,18 L19.3248439,37.6608273"] []
      ]
    ]
  ]
