module TextBox.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Routes.Models exposing (Route(..))
import Messages exposing (..)
import Models exposing (Mode(..))
import TextBox.Models exposing (getModel)

import Views.Shapes.Arrow as Arrow
import Switch.Views
import Switch.Models

viewContents model =
  div [class "text-box__contents"] [ div [class "text-box__content"]
      [ toHtml [class "static"] (Maybe.withDefault "" model.primaryContent)
      ]
  , div [class "text-box__content"]
      [ toHtml [class "static"] (Maybe.withDefault "" model.secondaryContent)
      ]
  ]

viewNav model =
  let
    switchModel = if model.mode == Conventional then Switch.Models.Left else Switch.Models.Right
    isSwitchHidden = model.route /= About
  in
    div [class "text-box-nav"]
      [ div [class "text-box-nav__home-link", onClick (ChangeRoute Home)]
        [ Arrow.view
        ]
      , div [classList [("text-box-nav__switch", True), ("text-box-nav__switch--hidden", isSwitchHidden)]]
        [ Switch.Views.view switchModel ToggleMode
        ]
      ]

view model =
  let
    textBoxModel = getModel model
  in
    div
    [ classList
      [ ("text-box", True)
      , ("text-box--hidden", textBoxModel.primaryContent == Nothing)
      , ("text-box--primary-displayed", textBoxModel.isPrimaryContentDisplayed)
      , ("text-box--secondary-displayed", not textBoxModel.isPrimaryContentDisplayed)
      ]
    ]
    [ viewNav model
    , viewContents textBoxModel
    ]
