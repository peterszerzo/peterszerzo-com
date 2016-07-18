module Notification.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)

import Notification.Messages exposing (Msg(..))

view model =
  div [classList [("notification", True), ("notification--visible", model.isVisible)]]
    [ toHtml [class "notification__body"] model.text
    , p [class "notification__close", onClick Toggle] [text "x"]
    ]
