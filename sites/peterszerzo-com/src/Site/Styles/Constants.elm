module Site.Styles.Constants exposing
    ( black
    , blue
    , dark
    , darkGrey
    , desktop
    , faintBlue
    , faintMustard
    , grey
    , lightBlue
    , lightGrey
    , mustard
    , sansSerif
    , serif
    , white
    )

import Css exposing (Color, hex, rgb, rgba)



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
    rgb 45 81 135


lightBlue : Color
lightBlue =
    rgb 64 96 145


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


dark : Color
dark =
    hex "232323"


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
