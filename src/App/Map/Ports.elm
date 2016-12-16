port module Map.Ports exposing (..)

-- JS Subscriptions


port mapReady : (Bool -> msg) -> Sub msg


port setActiveSound : (String -> msg) -> Sub msg


port clearActiveSound : (String -> msg) -> Sub msg


port receiveSoundData : (String -> msg) -> Sub msg



-- JS Commands


port playAudio : String -> Cmd msg


port pauseAudio : () -> Cmd msg


port createMap : () -> Cmd msg


port renderSounds : String -> Cmd msg


port requestSoundData : () -> Cmd msg
