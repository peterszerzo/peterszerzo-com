module DesktopNav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Data.Links exposing (projects, archives, talks)
import Main.Models exposing (Route(..))
import Main.Messages exposing (..)
import Links.Views exposing (viewMainLinks, viewLinkBox)
import Links.Models exposing (links, getActiveSubLinks)

view model =
  nav [classList [("desktop-nav", True), ("desktop-nav--expanded", List.length (getActiveSubLinks links model) > 0)]]
    [ viewMainLinks model
    , viewLinkBox model
    ]
