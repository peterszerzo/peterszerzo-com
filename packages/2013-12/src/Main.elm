module Main exposing (..)

import Html
import Html.Attributes
import P01
import P02
import P03
import P04
import P05
import P07
import P08
import P09
import P12
import P13
import P14
import P15
import P18
import P21
import P22
import P23
import P24
import P25
import P26
import P27
import P29
import P30
import P31
import P32


css : String
css =
    """
* {
  font-family: monospace;
}

.container {
  padding: 10px;
}

.grid {
}

.grid svg {
  display: inline-block;
  width: 160px;
}

.engrave {
  fill: none;
  stroke: #ababab;
  stroke-width: 2;
  stroke-linecap: round; 
  stroke-linejoin: round; 
}

.cut {
  fill: none;
  z-index: 2;
  stroke: #343434;
  stroke-width: 2;
  stroke-linecap: round; 
  stroke-linejoin: round; 
}
"""


main : Html.Html Never
main =
    Html.div
        [ Html.Attributes.class "container" ]
        [ Html.node "style" [] [ Html.text css ]
        , Html.h1 [] [ Html.text "Lasercut necklaces" ]
        , Html.p [] [ Html.text "by ", Html.a [ Html.Attributes.href "/" ] [ Html.text "peterszerzo" ] ]
        , Html.div [ Html.Attributes.class "grid" ]
            [ P01.view
            , P02.view
            , P03.view
            , P04.view
            , P05.view
            , P07.view
            , P08.view
            , P09.view
            , P12.view
            , P13.view
            , P14.view
            , P15.view
            , P18.view
            , P21.view
            , P22.view
            , P23.view
            , P24.view
            , P25.view
            , P26.view
            , P27.view
            , P29.view
            , P30.view
            , P31.view
            , P32.view
            ]
        ]
