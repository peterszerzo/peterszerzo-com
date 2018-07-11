module Site.Messages exposing (..)

--

import Time exposing (Time)
import Window
import Json.Decode as Decode


--

import Site.Router exposing (Route)


type Msg
    = NoOp
    | ToggleQuirky
    | Navigate String
    | ChangeRoute Route
    | AnimationTick Time
    | Resize Window.Size
    | PackLayoutResponse Decode.Value
