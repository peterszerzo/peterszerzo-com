module Maddi.Views.Mixins exposing (black, bodyType, borderColor_, headingType, linkType, mobile, stickoutStyles, titleType, white, yellow)

import Css exposing (..)
import Css.Media as Media


mobile : List Style -> Style
mobile =
    Media.withMedia
        [ Media.only Media.screen
            [ Media.maxWidth (px 600) ]
        ]


black : Color
black =
    hex "000000"


white : Color
white =
    hex "FFFFFF"


yellow : Color
yellow =
    hex "F7CE00"


borderColor_ : Color
borderColor_ =
    hex "#CECECE"


bodyType : Style
bodyType =
    Css.batch
        [ fontSize (Css.rem 1)
        , lineHeight (num 1.6)
        , mobile
            [ fontSize (Css.rem 1)
            ]
        ]


headingType : Style
headingType =
    Css.batch
        [ fontSize (Css.rem 1.5)
        , textDecoration none
        , color inherit
        ]


linkType : Style
linkType =
    Css.batch
        [ display inlineBlock
        , color inherit
        , bodyType
        , paddingLeft (px 1)
        , paddingRight (px 1)
        , borderRadius (px 2)
        , textDecoration underline
        , property "transition" "all 0.15s"
        , hover
            [ backgroundColor yellow
            ]
        , focus
            [ outline none
            , backgroundColor (rgb 250 250 250)
            ]
        ]


titleType : Style
titleType =
    Css.batch
        [ property "font-family" "Quicksand"
        , textTransform uppercase
        , fontSize (Css.rem 1.75)
        , lineHeight (num 1.15)
        , margin (px 0)
        , property "font-weight" "600"
        , mobile
            [ fontSize (Css.rem 2)
            ]
        ]


stickoutStyles : { hover : Bool } -> Style
stickoutStyles { hover } =
    let
        stickout =
            10

        common =
            Css.batch
                [ position absolute
                , property "content" "' '"
                , property "z-index" "9"
                , property "transition" "border-color 0.05s"
                , borderColor
                    (if hover then
                        hex "BDBDBD"

                     else
                        borderColor_
                    )
                ]
    in
    Css.batch
        [ before
            [ top (px -stickout)
            , bottom (px -stickout)
            , left (px 0)
            , right (px 0)
            , borderLeft2 (px 1) solid
            , borderRight2 (px 1) solid
            , common
            ]
        , after
            [ left (px -stickout)
            , right (px -stickout)
            , top (px 0)
            , bottom (px 0)
            , borderTop2 (px 1) solid
            , borderBottom2 (px 1) solid
            , common
            ]
        ]
