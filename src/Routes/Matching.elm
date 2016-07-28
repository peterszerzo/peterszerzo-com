module Routes.Matching exposing (..)

import Navigation
import String

import UrlParser exposing (..)
import Routes.Models exposing (Route(..))

routeUrls =
  [ (Home, "")
  , (Projects, "projects")
  , (Now, "now")
  , (About, "about")
  , (Talks, "talks")
  , (Archive, "archive")
  ]

matchers : Parser (Route -> a) a
matchers =
  routeUrls
    |> List.map (\(rt, url) -> (format rt (s url)))
    |> oneOf

pathnameParser location =
  location.pathname
    |> String.dropLeft 1
    |> parse identity matchers

parser =
  Navigation.makeParser pathnameParser

routeFromResult result =
  case result of
    Ok route -> route
    Err string -> NotFound
