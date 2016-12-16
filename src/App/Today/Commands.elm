module Today.Commands exposing (..)

import Random
import Dict
import Today.Models exposing (Model, deedsDecoder)
import Today.Messages exposing (Msg(..))
import Today.Models exposing (deedsDecoder)


getRandomDeed : Model -> Cmd Msg
getRandomDeed model =
    if (Dict.isEmpty model.deeds) then
        Cmd.none
    else
        (Random.int 0 ((model.deeds |> Dict.toList |> List.length) - 1))
            |> Random.generate ReceiveRandomDeed
