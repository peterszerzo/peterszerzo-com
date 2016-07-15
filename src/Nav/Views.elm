module Nav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Main.Models exposing (Mode(..))
import Routes.Models exposing (Route(..))
import Main.Messages exposing (Msg(..))

import Shapes.Logo as Logo
import Shapes.Falafel as Falafel
import Shapes.Arrow as Arrow
import Switch.Views
import Switch.Models

view model =
  let
    switchModel = if model.mode == Conventional then Switch.Models.Left else Switch.Models.Right
    isSwitchHidden = model.route /= About
  in
    div [class "nav"]
      [ div [class "nav__home-link", onClick (ChangeRoute Home)]
        [ Arrow.view
        ]
      , div [classList [("nav__switch", True), ("nav__switch--hidden", isSwitchHidden)]]
        [ Switch.Views.view switchModel ToggleMode
        ]
      ]
