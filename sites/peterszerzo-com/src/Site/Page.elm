module Site.Page exposing (Page(..))

import OverEasy
import Site.Page.Home as Home
import Site.Router as Router
import Time


type Page
    = Home
        { startTime : Maybe Time.Posix
        , time : Maybe Time.Posix
        }
    | Projects
    | Project String
    | Now
    | Talks
    | About
    | NotFound
    | OverEasy OverEasy.Model
