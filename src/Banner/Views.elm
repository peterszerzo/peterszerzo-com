module Banner.Views exposing (..)

import Html exposing (Html, div, h1, p, text)
import Html.Attributes exposing (class)
import Shapes.Logo

view : Html a
view =
  div
    [ class "banner"
    ]
    [ div
      [ class "banner__logo"
      ]
      [ Shapes.Logo.view
      , div [class "banner__image-container"]
        [ div [class "banner__image"] []
        , div [class "banner__overlay"] []
        ]
      ]
    , h1 [] [text "Peter Szerzo"]
    , p [] [text "makes himself a website"]
    ]
