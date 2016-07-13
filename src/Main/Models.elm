module Main.Models exposing (..)

type Route = Home | Projects | Now | About | Talks | Archive

type Mode = Conventional | Real

type alias Model =
  { route : Route
  , mode : Mode
  }

init =
  (Model Home Conventional, Cmd.none)
