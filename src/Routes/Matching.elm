module Routes.Matching exposing (..)

import Navigation
import String
import UrlParser exposing (..)

import Routes.Models exposing (Route(..))

matchers : Parser (Route -> a) a
matchers =
  oneOf
  [ format Home (s "")
  , format Projects (s "projects")
  , format Now (s "now")
  , format About (s "about")
  , format Talks (s "talks")
  , format Archive (s "archive")
  ]

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
