module Shapes.Falafel exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)

view =
  let
    height' = 8
    spacing = 24
    startY = 50 - spacing - 1.5 * height'
  in
    svg [viewBox "0 0 100 100"]
    [ g []
      [ rect
        [ x "0"
        , y (toString startY)
        , width "100"
        , height (toString height')
        , rx "4"
        ] []
      , rect
        [ x "0"
        , y (toString (startY + height' + spacing))
        , width "100"
        , height (toString height')
        , rx "4"
        ] []
      , rect
        [ x "0"
        , y (toString (startY + 2 * height' + 2 * spacing))
        , width "100"
        , height (toString height')
        , rx "4"
        ] []
      ]
    ]
