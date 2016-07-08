module Main.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)

import Main.Models
import Logo.Views
import Switch.Views
import Switch.Models

view model =
  let
    switchModel = case model.mode of
      Main.Models.Conventional -> Switch.Models.Left
      Main.Models.Real -> Switch.Models.Right
  in
    div [class "main"]
      [ div [class "main__switch"] [Switch.Views.view switchModel]
      , div [class "main__content"]
        [ Logo.Views.view
        , div [class "title-bar"]
          [ h1 [] [text "Peter Szerzo"]
          , p [] [text "makes himself a website"]
          ]
        , div [class "main-links"]
          [ a [] [text "Projects"]
          , a [] [text "Blog"]
          , a [] [text "Archive"]
          , a [] [text "Now"]
          , a [] [text "About"]
          ]
        , div [class "social-links"] []
        ]
      ]
