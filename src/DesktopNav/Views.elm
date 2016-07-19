module DesktopNav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Routes.Models exposing (Route(..))
import Main.Messages exposing (..)
import Links.Views exposing (viewMainLinks, viewLinkBox)
import Links.Models exposing (links, getActiveSubLinks)

view currentRoute =
  nav
  [ classList
    [ ("desktop-nav", True)
    , ("desktop-nav--expanded", List.length (getActiveSubLinks links currentRoute) > 0)
    ]
  ]
  [ viewMainLinks "main-links" currentRoute
  , viewLinkBox currentRoute
  ]
