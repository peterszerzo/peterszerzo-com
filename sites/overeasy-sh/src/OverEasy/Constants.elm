module OverEasy.Constants exposing (black, desktop, white, yellow)

import Css exposing (..)
import Css.Media as Media


yellow : Color
yellow =
    hex "ffc235"


black : Color
black =
    hex "000000"


white : Color
white =
    hex "FFFFFF"


desktop : List Style -> Style
desktop =
    Media.withMediaQuery [ "screen and (min-width: 600px)" ]
