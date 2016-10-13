module Router exposing (..)

import Navigation
import UrlParser exposing (Parser, format, s, oneOf)
import String

type Route
  = Home
  | Projects
  | Now
  | About
  | Talks
  | Archive
  | NotFound

routeUrls : List (Route, String)
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

getUrl : Route -> String
getUrl route =
  routeUrls
    |> List.filter (\(rt, url) -> rt == route)
    |> List.head
    |> Maybe.withDefault (Home, "")
    |> snd

pathnameParser : Navigation.Location -> (Result String Route)
pathnameParser location =
  location.pathname
    |> String.dropLeft 1
    |> UrlParser.parse identity matchers

parser : Navigation.Parser (Result String Route)
parser =
  Navigation.makeParser pathnameParser

routeFromResult : Result String Route -> Route
routeFromResult result =
  case result of
    Ok route -> route
    Err string -> NotFound
