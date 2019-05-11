module Shared.Flags exposing (Flags, unsafeDecode)

import Json.Decode as Decode
import Json.Encode as Encode


type alias Flags =
    { size : Float
    , animating : Bool
    }


unsafeDecode : Encode.Value -> Flags
unsafeDecode flags =
    flags
        |> Decode.decodeValue
            (Decode.map2 Flags
                (Decode.field "size" Decode.float)
                (Decode.field "animating" Decode.bool)
            )
        |> Result.withDefault
            { size = 640
            , animating = True
            }
