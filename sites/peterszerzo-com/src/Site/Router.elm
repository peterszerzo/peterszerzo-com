module Site.Router exposing (Route(..), parse, parser)

import OverEasy
import Url
import Url.Parser exposing (..)


type Route
    = Home
    | Projects
    | Project String
    | Now
    | About
    | Talks
    | NotFound
    | OverEasy OverEasy.Route


parse : Url.Url -> Route
parse location =
    location
        |> Url.Parser.parse parser
        |> Maybe.withDefault NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ top |> map Home
        , s "projects" |> map Projects
        , s "projects" </> string |> map Project
        , s "about" |> map About
        , s "now" |> map Now
        , s "talks" |> map Talks
        , s "overeasy" </> OverEasy.matchers |> map OverEasy
        ]
