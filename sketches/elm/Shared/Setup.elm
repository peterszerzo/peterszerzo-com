port module Shared.Setup exposing (Flags, Model, animate, playhead, unsafeDecodeFlags)

import Json.Decode as Decode
import Json.Encode as Encode
import Time


port animate : (Encode.Value -> msg) -> Sub msg


type alias Flags =
    { size : Float
    , animating : Bool
    }


unsafeDecodeFlags : Encode.Value -> Flags
unsafeDecodeFlags flags =
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


type alias Model a =
    { a
        | time : Maybe Time.Posix
        , startTime : Maybe Time.Posix
        , isAnimating : Bool
        , size : Float
    }


playhead : Model a -> Float
playhead model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0
