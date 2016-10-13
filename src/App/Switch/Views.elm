module Switch.Views exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg)

import Switch.Models exposing (Model(..))

view : Model -> Msg -> Html Msg
view model msgOnClick =
  let
    className = case model of
      Left ->
        "switch switch--left"
      Center ->
        "switch"
      Right ->
        "switch switch--right"
  in
    div
      [ class className
      , onClick msgOnClick
      ]
      [ div
          [ class "switch__content"
          ]
          [ div [class "switch__frame"] []
          , div [class "switch__button"] []
          ]
      ]
