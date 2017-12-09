module Data.PackBubble exposing (..)

import Json.Decode as Decode


type alias PackBubble =
    { x : Float
    , y : Float
    , r : Float
    }


decoder : Decode.Decoder PackBubble
decoder =
    Decode.map3 PackBubble
        (Decode.field "x" Decode.float)
        (Decode.field "y" Decode.float)
        (Decode.field "r" Decode.float)
