module Today.Messages exposing (..)

import Time exposing (Time)


type Msg
    = ReceiveDeeds String
    | RequestRandomDeed
    | ReceiveRandomDeed Int
    | Tick Time
    | Navigate String


navigate : Msg -> Maybe String
navigate msg =
    case msg of
        Navigate str ->
            Just str

        _ ->
            Nothing
