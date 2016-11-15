module Views.Shapes.Falafel exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)


view : Bool -> Html a
view showAll =
    let
        height_ =
            8

        spacing =
            24

        startY =
            50 - spacing - 1.5 * height_
    in
        svg [ viewBox "0 0 100 100" ]
            [ g []
                [ rect
                    [ x "0"
                    , y (toString startY)
                    , width "100"
                    , height
                        (if showAll then
                            (toString height_)
                         else
                            "0"
                        )
                    , rx "4"
                    ]
                    []
                , rect
                    [ x "0"
                    , y (toString (startY + height_ + spacing))
                    , width "100"
                    , height (toString height_)
                    , rx "4"
                    ]
                    []
                , rect
                    [ x "0"
                    , y (toString (startY + 2 * height_ + 2 * spacing))
                    , width "100"
                    , height
                        (if showAll then
                            (toString height_)
                         else
                            "0"
                        )
                    , rx "4"
                    ]
                    []
                ]
            ]
