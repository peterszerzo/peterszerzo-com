module Site.Messages exposing (Msg(..))

import Browser
import Json.Decode as Decode
import Site.Router exposing (Route)
import Time


type Msg
    = ToggleQuirky
    | Navigate String
    | ChangeRoute Route
    | UrlRequest Browser.UrlRequest
    | AnimationTick Time.Posix
    | Resize Int Int
    | PackLayoutResponse Decode.Value
