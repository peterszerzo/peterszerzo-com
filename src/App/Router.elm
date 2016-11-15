module Router exposing (..)

import Navigation
import String


type Route
    = Home
    | Projects
    | Now
    | About
    | Talks
    | Archive
    | NotFound


routeDefs : List ( Route, String )
routeDefs =
    [ ( Home, "" )
    , ( Projects, "projects" )
    , ( Now, "now" )
    , ( About, "about" )
    , ( Talks, "talks" )
    , ( Archive, "archive" )
    ]


parse : Navigation.Location -> Route
parse =
  (parseUrlFragment routeDefs) << getPathname


getPathname : Navigation.Location -> String
getPathname location =
  location.pathname
    |> String.dropLeft 1


parseUrlFragment : List ( Route, String ) -> String -> Route
parseUrlFragment routeDefs str =
  case List.head routeDefs of
    Just routeDef ->
      if (Tuple.second routeDef) == str then
        Tuple.first routeDef
      else
        parseUrlFragment (List.drop 1 routeDefs) str
    Nothing ->
      NotFound
