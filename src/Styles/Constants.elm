module Styles.Constants exposing (..)

import Css exposing (Color, hex)


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
    hex "15487F"


mustard : Color
mustard =
    hex "DBA700"


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
