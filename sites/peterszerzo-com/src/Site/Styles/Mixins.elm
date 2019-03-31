module Site.Styles.Mixins exposing
    ( bodyType
    , desktop
    , highlightedBodyType
    , lineHeight
    , pointerEventsAll
    , pointerEventsNone
    , regularTransition
    , standardShadow
    , titleType
    , zIndex
    )

import Css exposing (..)
import Css.Media as Media
import Site.Styles.Constants as Constants


desktop =
    Media.withMediaQuery [ "screen and (min-width: 600px)" ]


zIndex : Int -> Style
zIndex i =
    property "z-index" (i |> String.fromInt)


lineHeight : Float -> Style
lineHeight =
    String.fromFloat
        >> property "line-height"


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


titleType : Style
titleType =
    Css.batch
        [ fontSize (Css.rem 1.75)
        , lineHeight 1.68
        , property "font-family" Constants.serif
        ]


bodyType : Style
bodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , lineHeight 1.68
        ]


highlightedBodyType : Style
highlightedBodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , property "font-weight" "600"
        ]
