module Nav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Main.Models exposing (Route(..), Mode(..))
import Main.Messages exposing (Msg(..))

import Shapes.Logo as Logo
import Shapes.Falafel as Falafel
import Switch.Views
import Switch.Models

view model =
  let
    switchModel = if model.mode == Conventional then Switch.Models.Left else Switch.Models.Right
    hideSwitch = model.route /= About
  in
    div [class "nav"]
      [ div [class "nav__home-link", onClick (ChangeRoute Home)]
        [ Logo.view
        ]
      , div [classList [("nav__switch", True), ("nav__switch--hidden", hideSwitch)]]
        [ Switch.Views.view switchModel ToggleMode
        ]
      ]
