module Styles.Mixins exposing (..)

import Css exposing (..)


calcPctMinusPx : Float -> Float -> String
calcPctMinusPx percent pixels =
    "calc(" ++ (percent |> toString) ++ "% - " ++ (pixels |> toString) ++ "px)"


zIndex : Int -> Mixin
zIndex i =
    property "z-index" (i |> toString)


lineHeight : Float -> Mixin
lineHeight lh =
    property "line-height" (lh |> toString)


pointerEventsNone : Mixin
pointerEventsNone =
    property "pointer-events" "none"


pointerEventsAll : Mixin
pointerEventsAll =
    property "pointer-events" "all"


regularTransition : Mixin
regularTransition =
    property "transition" "all .3s"


standardShadow : List Mixin
standardShadow =
    [ property "box-shadow" "0 0 12px rgba(20, 20, 20, .3)" ]
