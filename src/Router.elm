module Router exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = Home
    | Projects
    | Project String
    | Now
    | About
    | Talks
    | NotFound


parse : Navigation.Location -> Route
parse location =
    location
        |> parsePath matchers
        |> Maybe.withDefault NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "" |> map Home
        , s "projects" |> map Projects
        , s "projects" </> string |> map Project
        , s "about" |> map About
        , s "now" |> map Now
        , s "talks" |> map Talks
        ]
