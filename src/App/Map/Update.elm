module Map.Update exposing (..)

import Json.Decode as JD
import Json.Encode as JE
import Dict
import Map.Models exposing (Model, soundsDecoder, encodeSounds)
import Map.Messages exposing (..)
import Map.Ports exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapReady isMapReady ->
            let
                cmd =
                    if (Dict.isEmpty model.sounds) then
                        Cmd.none
                    else
                        (model.sounds |> encodeSounds |> JE.encode 0 |> renderSounds)
            in
                { model | isMapReady = isMapReady } ! [ cmd ]

        SetActiveSound soundId ->
            let
                newModel =
                    { model
                        | activeSoundId = Just soundId
                    }

                audioRef =
                    model.sounds
                        |> Dict.get soundId
                        |> Maybe.map .trackRef
                        |> Maybe.withDefault ""
            in
                newModel ! [ playAudio audioRef ]

        ClearActiveSound placeholder ->
            let
                newModel =
                    { model
                        | activeSoundId = Nothing
                    }
            in
                newModel ! [ pauseAudio () ]

        ReceiveSoundData sounds ->
            let
                newSounds =
                    sounds
                        |> JD.decodeString soundsDecoder
                        |> Result.toMaybe
                        |> Maybe.withDefault Dict.empty

                cmd =
                    if model.isMapReady then
                        (renderSounds sounds)
                    else
                        Cmd.none
            in
                { model
                    | sounds = newSounds
                }
                    ! [ Cmd.none ]

        Navigate str ->
            model ! [ Cmd.none ]
