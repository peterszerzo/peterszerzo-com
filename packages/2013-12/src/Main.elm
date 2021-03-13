module Main exposing (..)

import P07
import Html

css : String
css = """
.engrave {
  fill: none;
  stroke: #000;
  stroke-width: 1;
  stroke-linecap: round; 
  stroke-linejoin: round; 
}

.cut {
  fill: none;
  z-index: 2;
  stroke: #999;
  stroke-width: 1;
  stroke-linecap: round; 
  stroke-linejoin: round; 
}
"""

main : Html.Html Never
main =
    Html.div [] 
        [ Html.node "style" [] [ Html.text css ]
        , P07.view
        ]
