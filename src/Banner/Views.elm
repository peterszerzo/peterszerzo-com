module Banner.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Shapes.Logo

view =
  div [class "banner"]
    [ Shapes.Logo.view
    , h1 [] [text "Peter Szerzo"]
    , p [] [text "makes himself a website"]
    ]
