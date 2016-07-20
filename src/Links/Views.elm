module Links.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Routes.Models exposing (Route(..))
import Main.Messages exposing (Msg(..))
import Links.Models exposing (Url(..), links, getActiveSubLinks)

viewSecondaryLink (name, url) =
  a [href url] [text name]

viewSecondaryLinks className currentRoute =
  let
    activeSubLinks = getActiveSubLinks links currentRoute
    (isHidden, subLinks) = if (List.length activeSubLinks) == 0 then (True, []) else (False, activeSubLinks)
  in
    div [classList [(className, True), (className ++ "--hidden", isHidden)]]
      (List.map viewSecondaryLink subLinks)

viewMainLink className currentRoute {label, url, subLinks} =
  let
    (variableAttr, htmlTag, isActive) = case url of
      Internal route -> ([onClick (ChangeRoute (if currentRoute == route then Home else route))], div, currentRoute == route)
      External route -> ([href route, target "_blank"], a, False)
    attr = (classList [(className ++ "__link", True), (className ++ "__link--active", isActive)]) :: variableAttr
  in
    htmlTag attr [text label]

viewMainLinks className currentRoute =
  div [class className] (List.map (viewMainLink className currentRoute) links)
