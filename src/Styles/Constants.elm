module Styles.Constants exposing (..)

import Css exposing (Color, hex, rgba, rgb)


-- Dimensions
-- Fonts


sansSerif : String
sansSerif =
    "'PT Sans', sans-serif"


serif : String
serif =
    "'PT Serif', serif"



-- Colors


blue : Color
blue =
    hex "325891"


lightBlue : Color
lightBlue =
    rgb 31 82 137


faintBlue : Color
faintBlue =
    rgba 21 72 127 0.08


mustard : Color
mustard =
    hex "EEB902"


faintMustard : Color
faintMustard =
    rgba 238 185 2 0.2


black : Color
black =
    hex "000000"


darkGrey : Color
darkGrey =
    hex "333333"


grey : Color
grey =
    hex "777777"


lightGrey : Color
lightGrey =
    hex "BBBBBB"


white : Color
white =
    hex "FFFFFF"


desktop : String
desktop =
    "screen and (min-width: 700px)"
