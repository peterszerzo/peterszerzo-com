module Map.Subscriptions exposing (..)

import Map.Models exposing (Model)
import Map.Messages exposing (Msg(..))
import Map.Ports exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ mapReady MapReady
        , setActiveSound SetActiveSound
        , clearActiveSound ClearActiveSound
        , receiveSoundData ReceiveSoundData
        ]
