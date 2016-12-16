module Map.Views exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (id, class)
import Map.Messages exposing (Msg(..))
import Map.Models exposing (Model, Sound, Sounds)


view : Model -> Html Msg
view model =
    div
        [ class "m"
        ]
        [ div [ class "m_map", id "m_map" ] []
        ]
