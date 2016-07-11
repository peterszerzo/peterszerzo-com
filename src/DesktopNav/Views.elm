module DesktopNav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Data.Links exposing (projects, archives)
import Main.Models exposing (Route(..))
import Main.Messages exposing (..)

viewLinkBox links =
  let
    className = if List.length links > 0 then "link-box" else "link-box link-box--hidden"
  in
    div [class className] (List.map (\(name, url) -> (a [href url] [text name])) links)

viewMainLink txt targetRoute hrefMaybe route =
  let
    className = if targetRoute == route then "main-links__link main-links__link--active" else "main-links__link"
    attributes = case hrefMaybe of
      Just hrefString -> [class className, href hrefString]
      Nothing -> [class className, onClick (ChangeRoute targetRoute)]
  in
    a attributes [text txt]

viewMainLinks model =
  div [class "main-links"]
    [ viewMainLink "Projects" Projects Nothing model.route
    , viewMainLink "Blog" Home (Just "http://blog.peterszerzo.com") Now
    , viewMainLink "About" About Nothing model.route
    , viewMainLink "Now" Now Nothing model.route
    , viewMainLink "Archive" Archive Nothing model.route
    ]

view model =
  let
    subLinks = case model.route of
      Home -> []
      Projects -> projects
      About -> []
      Now -> []
      Archive -> archives
    className = if (List.length subLinks) > 0 then "desktop-nav desktop-nav--expanded" else "desktop-nav"
  in
    nav [class className]
      [ viewMainLinks model
      , viewLinkBox subLinks
      ]
