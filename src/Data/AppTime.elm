module Data.AppTime exposing (AppTime, init, set, sinceStart)

import Time exposing (Time)


type AppTime
    = AppTime
        { atStart : Maybe Time
        , current : Maybe Time
        }


init : AppTime
init =
    AppTime { atStart = Nothing, current = Nothing }


set : Time -> AppTime -> AppTime
set time (AppTime appTime) =
    AppTime
        { atStart =
            case appTime.atStart of
                Just atStartTime ->
                    Just atStartTime

                Nothing ->
                    Just time
        , current = Just time
        }


sinceStart : AppTime -> Time
sinceStart (AppTime appTime) =
    Maybe.map2 (\current atStart -> current - atStart) appTime.current appTime.atStart
        |> Maybe.withDefault 0
