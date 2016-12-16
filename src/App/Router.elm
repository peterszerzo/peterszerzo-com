module Router exposing (..)

import Navigation
import String
import Today.Models


type Route
    = Home
    | Projects
    | Now
    | About
    | Talks
    | Archive
    | Today Today.Models.Model
    | NotFound


simpleRouteDefs : List ( Route, String )
simpleRouteDefs =
    [ ( Home, "" )
    , ( Projects, "projects" )
    , ( Now, "now" )
    , ( About, "about" )
    , ( Talks, "talks" )
    , ( Archive, "archive" )
    ]


parse : Navigation.Location -> Route
parse =
    slugToRoute << getPathname


getPathname : Navigation.Location -> String
getPathname location =
    location.pathname
        |> String.dropLeft 1


slugToRoute : String -> Route
slugToRoute slug =
    simpleRouteDefs
        |> List.filter (\( route, slug_ ) -> slug == slug_)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault
            (if slug == "today" then
                Today.Models.init |> Tuple.first |> Today
             else
                NotFound
            )


routeToSlug : Route -> Maybe String
routeToSlug route =
    simpleRouteDefs
        |> List.filter (\( route_, slug ) -> route == route_)
        |> List.head
        |> Maybe.map Tuple.second
