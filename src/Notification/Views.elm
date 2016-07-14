module Notification.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

view txt isVisible handleClick =
  div [classList [("notification", True), ("notification--visible", isVisible)], onClick handleClick]
    [ p [class "notification__text"] [text txt]
    ]
