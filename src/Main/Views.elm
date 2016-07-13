module Main.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)

import Main.Models exposing (Route(..), Mode(..))
import Main.Messages exposing (..)
import Switch.Views
import Switch.Models
import DesktopNav.Views
import Nav.Views
import TextBox.Views
import TextBox.Models
import Banner.Views
import Links.Models

import Data.Markdown

viewTextBox model =
  let
    isPrimaryContentDisplayed = model.mode == Conventional
    viewModel = case model.route of
      Home -> TextBox.Models.Model Nothing Nothing False
      Projects -> TextBox.Models.Model Nothing Nothing False
      Talks -> TextBox.Models.Model Nothing Nothing False
      Archive -> TextBox.Models.Model Nothing Nothing False
      Now -> TextBox.Models.Model (Just Data.Markdown.now) Nothing True
      About -> TextBox.Models.Model (Just Data.Markdown.aboutConventional) (Just Data.Markdown.aboutReal) isPrimaryContentDisplayed
  in
    TextBox.Views.view viewModel

viewMainContent model =
  div [class "main__content"]
    [ Banner.Views.view
    ]

view model =
  div [class "main"]
    [ viewMainContent model
    , viewTextBox model
    , DesktopNav.Views.view model
    , Nav.Views.view model
    ]
