module Links.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Main.Messages exposing (Msg(..))
import Links.Models exposing (Url(..), links, getActiveSubLinks)

viewLinkBoxItems (name, url) =
  a [href url] [text name]

viewLinkBox model =
  let
    activeSubLinks = getActiveSubLinks links model
    (isHidden, subLinks) = if (List.length activeSubLinks) == 0 then (True, []) else (False, activeSubLinks)
  in
    div [classList [("link-box", True), ("link-box--hidden", isHidden)]]
      (List.map viewLinkBoxItems subLinks)

viewMainLink model {label, url, subLinks} =
  let
    (variableAttr, htmlTag, isActive) = case url of
      Internal route -> ([onClick (ChangeRoute route)], div, model.route == route)
      External route -> ([href route], a, False)
    attr = (classList [("main-links__link", True), ("main-links__link--active", isActive)]) :: variableAttr
  in
    htmlTag attr [text label]

viewMainLinks model =
  div [class "main-links"] (List.map (viewMainLink model) links)
