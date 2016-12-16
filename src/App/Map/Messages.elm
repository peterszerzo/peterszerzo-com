module Map.Messages exposing (..)


type Msg
    = MapReady Bool
    | SetActiveSound String
    | ClearActiveSound String
    | ReceiveSoundData String
    | Navigate String


navigate : Msg -> Maybe String
navigate msg =
    case msg of
        Navigate str ->
            Just str

        _ ->
            Nothing
