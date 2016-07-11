module Switch.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Main.Messages

import Switch.Models exposing (..)

view model msgOnClick =
  let
    className = case model of
      Left -> "switch switch--left"
      Center -> "switch"
      Right -> "switch switch--right"
  in
    div [class className, onClick msgOnClick]
      [ div [class "switch__frame"] []
      , div [class "switch__button"] []
      ]
