module Today.Models exposing (..)

import Json.Decode as JD
import Dict
import Today.Messages exposing (Msg)
import Today.Ports exposing (requestDeeds)


type alias Deed =
    { id : String
    , title : String
    , startGifUrl : String
    , endGifUrl : String
    , shiftAngle : Float
    }


type alias Model =
    { deeds : Dict.Dict String Deed
    , currentDeedId : Maybe String
    , loadedImageUrls : List String
    , ticksSinceLastDeedChange : Float
    }


init : ( Model, Cmd Msg )
init =
    ( Model Dict.empty Nothing [] 0, requestDeeds () )


getCurrentDeed : Model -> Maybe Deed
getCurrentDeed model =
    model.currentDeedId
        |> Maybe.andThen ((flip Dict.get) model.deeds)


deedDecoder : JD.Decoder Deed
deedDecoder =
    JD.map5 Deed
        (JD.field "id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "startGifUrl" JD.string)
        (JD.field "endGifUrl" JD.string)
        (JD.field "shiftAngle" JD.float)


deedsDecoder : JD.Decoder (Dict.Dict String Deed)
deedsDecoder =
    JD.dict deedDecoder
