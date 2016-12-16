module Today.Update exposing (..)

import Dict
import Today.Models exposing (Model, deedsDecoder)
import Today.Messages exposing (Msg(..))
import Today.Commands exposing (getRandomDeed)
import Json.Decode as JD


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveDeeds deeds ->
            let
                newDeeds =
                    deeds
                        |> JD.decodeString deedsDecoder
                        |> Result.toMaybe
                        |> Maybe.withDefault Dict.empty

                currentDeedId =
                    newDeeds
                        |> Dict.toList
                        |> List.head
                        |> Maybe.map Tuple.second
                        |> Maybe.map .id

                newModel =
                    { model
                        | deeds = newDeeds
                        , currentDeedId = currentDeedId
                    }
            in
                newModel ! [ getRandomDeed newModel ]

        RequestRandomDeed ->
            model ! [ getRandomDeed model ]

        ReceiveRandomDeed index ->
            let
                currentDeedId =
                    model.deeds
                        |> Dict.toList
                        |> List.drop index
                        |> List.head
                        |> Maybe.map (.id << Tuple.second)
            in
                { model
                    | currentDeedId = currentDeedId
                    , ticksSinceLastDeedChange = 0
                }
                    ! [ Cmd.none ]

        Tick time ->
            { model | ticksSinceLastDeedChange = model.ticksSinceLastDeedChange + 1 } ! [ Cmd.none ]

        Navigate str ->
            model ! [ Cmd.none ]
