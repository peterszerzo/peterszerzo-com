module MobileNav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Shapes.Falafel as Falafel
import Links.Views exposing (viewMainLinks, viewLinkBox)
import Links.Models exposing (links, getActiveSubLinks)

view model currentRoute handleToggleClick =
  div
  [ classList
    [ ("mobile-nav", True)
    , ("mobile-nav--active", model.isActive)]
    ]
  [ div [class "mobile-nav__toggle", onClick handleToggleClick] [Falafel.view]
  , viewMainLinks "mobile-nav-links" currentRoute
  ]
