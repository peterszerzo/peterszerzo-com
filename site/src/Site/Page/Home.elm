module Site.Page.Home exposing (Model, Msg(..), init)

import Browser.Events as Events
import Time


type alias Model =
    { startTime : Maybe Time.Posix
    , time : Maybe Time.Posix
    }


type Msg
    = StartTime Time.Posix
    | Tick Time.Posix


init : ( Model, Cmd Msg )
init =
    ( { startTime = Nothing
      , time = Nothing
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Events.onAnimationFrame Tick
