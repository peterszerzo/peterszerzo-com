module Logo.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

view =
  div [class "logo"]
    [ img [src "/logo.svg"] []
    ]
