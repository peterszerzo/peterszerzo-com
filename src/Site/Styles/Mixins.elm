module Site.Styles.Mixins exposing (..)

import Css exposing (..)
import Css.Media as Media


desktop =
    Media.withMediaQuery [ "screen and (min-width: 600px)" ]


calcPctMinusPx : Float -> Float -> String
calcPctMinusPx percent pixels =
    "calc(" ++ (percent |> toString) ++ "% - " ++ (pixels |> toString) ++ "px)"


zIndex : Int -> Style
zIndex i =
    property "z-index" (i |> toString)


lineHeight : Float -> Style
lineHeight lh =
    property "line-height" (lh |> toString)


pointerEventsNone : Style
pointerEventsNone =
    property "pointer-events" "none"


pointerEventsAll : Style
pointerEventsAll =
    property "pointer-events" "all"


regularTransition : Style
regularTransition =
    property "transition" "all .3s"


standardShadow : List Style
standardShadow =
    [ property "box-shadow" "0 0 12px rgba(20, 20, 20, .3)" ]


bodyType : List Style
bodyType =
    [ fontSize (Css.rem 1)
    , lineHeight 1.68
    ]


highlightedBodyType : List Style
highlightedBodyType =
    [ fontSize (Css.rem 1)
    , property "font-weight" "600"
    ]
