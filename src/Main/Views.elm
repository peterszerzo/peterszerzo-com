module Main.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)
import Html.App exposing (map)

import Routes.Models exposing (Route(..))
import Main.Models exposing (Mode(..))
import Main.Messages exposing (..)
import Switch.Views
import Switch.Models
import DesktopNav.Views
import Nav.Views
import TextBox.Views
import Notification.Views
import TextBox.Models
import Banner.Views
import Links.Models

import Data.Markdown

viewTextBox model =
  let
    isPrimaryContentDisplayed = model.mode == Conventional
    defaultModel = TextBox.Models.Model Nothing Nothing False
    viewModel = case model.route of
      Home -> defaultModel
      Projects -> defaultModel
      Talks -> defaultModel
      Archive -> defaultModel
      NotFound -> defaultModel
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
    , map Notification (Notification.Views.view model.notification)
    ]
