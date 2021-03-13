module Setup exposing
    ( Flags
    , Model
    , Msg
    , playhead
    , subscriptions
    , unsafeDecodeFlags
    , update
    )

import Browser.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Time


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


type Msg
    = Animate Bool
    | Tick Time.Posix


update : Msg -> Model a -> Model a
update msg model =
    case msg of
        Animate isAnimating ->
            { model | isAnimating = isAnimating }

        Tick time ->
            { model
                | startTime =
                    if model.startTime == Nothing then
                        Just time

                    else
                        model.startTime
                , time = Just time
            }


subscriptions : Model a -> Sub Msg
subscriptions model =
    Sub.batch
        [ if model.isAnimating then
            Browser.Events.onAnimationFrame Tick

          else
            Sub.none
        ]
