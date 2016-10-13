module Views.DesktopNav exposing (..)

import Html exposing (Html, nav)
import Html.Attributes exposing (classList, attribute)

import Router exposing (Route)
import Messages exposing (Msg)
import Views.Links exposing (viewMainLinks, viewSecondaryLinks)
import Models exposing (getActiveSubLinks)
import Data.Navigation exposing (links)

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
