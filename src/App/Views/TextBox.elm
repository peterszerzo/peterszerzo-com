module Views.TextBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)

import Router exposing (Route(..))
import Messages exposing (..)
import Models exposing (Mode(..))
import Models exposing (getTextBox)

import Views.Shapes.Arrow as Arrow
import Views.Switch
import Models exposing (SwitchPosition(..))

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
    switchModel = if model.mode == Conventional then Left else Right
    isSwitchHidden = model.route /= About
  in
    div [class "text-box-nav"]
      [ div [class "text-box-nav__home-link", onClick (ChangeRoute Home)]
        [ Arrow.view
        ]
      , div [classList [("text-box-nav__switch", True), ("text-box-nav__switch--hidden", isSwitchHidden)]]
        [ Views.Switch.view switchModel ToggleMode
        ]
      ]

view model =
  let
    textBoxModel = getTextBox model
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
