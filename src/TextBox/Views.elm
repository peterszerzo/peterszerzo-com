module TextBox.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Main.Models exposing (Route(..))
import Main.Messages exposing (..)

viewContents model =
  div [class "text-box__contents"] [ div [class "text-box__content"]
      [ toHtml [class "static"] (Maybe.withDefault "" model.primaryContent)
      ]
  , div [class "text-box__content"]
      [ toHtml [class "static"] (Maybe.withDefault "" model.secondaryContent)
      ]
  ]

view model =
  div
  [ classList
    [ ("text-box", True)
    , ("text-box--hidden", model.primaryContent == Nothing)
    , ("text-box--primary-displayed", model.isPrimaryContentDisplayed)
    , ("text-box--secondary-displayed", not model.isPrimaryContentDisplayed)
    ]
  ]
  [ viewContents model
  ]
