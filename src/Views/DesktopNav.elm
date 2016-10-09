module Views.DesktopNav exposing (..)

import Html exposing (Html, nav)
import Html.Attributes exposing (classList, attribute)

import Routes.Models exposing (Route)
import Main.Messages exposing (Msg)
import Links.Views exposing (viewMainLinks, viewSecondaryLinks)
import Links.Models exposing (links, getActiveSubLinks)

view : Route -> Html Msg
view currentRoute =
  nav
    [ attribute "role" "navigation"
    , classList
        [ ("desktop-nav", True)
        , ("desktop-nav--expanded", List.length (getActiveSubLinks links currentRoute) > 0)
        ]
    ]
    [ viewMainLinks "main-links" currentRoute
    , viewSecondaryLinks "link-box" currentRoute
    ]
