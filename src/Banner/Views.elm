module Banner.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Shapes.Logo

view =
  div [class "banner"]
    [ div [class "banner__logo"]
      [ Shapes.Logo.view
      , div [class "banner__image-container"]
        [ div [class "banner__image"] []
        , div [class "banner__overlay"] []
        ]
      ]
    , h1 [] [text "Peter Szerzo"]
    , p [] [text "makes himself a website"]
    ]
