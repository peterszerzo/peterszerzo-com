module Map.Models exposing (..)

import Dict
import Json.Encode as JE
import Json.Decode as JD
import Map.Ports exposing (..)
import Map.Messages exposing (..)


type alias Model =
    { sounds : Sounds
    , activeSoundId : Maybe String
    , isMapReady : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { sounds = Dict.empty
      , activeSoundId = Maybe.Nothing
      , isMapReady = False
      }
    , Cmd.batch
        [ requestSoundData ()
        , createMap ()
        ]
    )



-- Sound


type alias Sound =
    { id : String
    , title : String
    , description : String
    , date : String
    , trackRef : String
    , lat : Float
    , lng : Float
    }


type alias Sounds =
    Dict.Dict String Sound



-- Encoders


encodeSound : Sound -> JE.Value
encodeSound sound =
    JE.object
        [ ( "id", JE.string sound.id )
        , ( "title", JE.string sound.title )
        , ( "description", JE.string sound.description )
        , ( "date", JE.string sound.date )
        , ( "trackRef", JE.string sound.trackRef )
        , ( "lat", JE.float sound.lat )
        , ( "lng", JE.float sound.lng )
        ]


encodeSounds : Dict.Dict String Sound -> JE.Value
encodeSounds =
    Dict.toList >> List.map (\( key, value ) -> ( key, encodeSound value )) >> JE.object



-- Decoders


soundDecoder : JD.Decoder Sound
soundDecoder =
    JD.map7 Sound
        (JD.field "id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "description" JD.string)
        (JD.field "date" JD.string)
        (JD.field "trackRef" JD.string)
        (JD.field "lat" JD.float)
        (JD.field "lng" JD.float)


soundsDecoder : JD.Decoder (Dict.Dict String Sound)
soundsDecoder =
    JD.dict soundDecoder
