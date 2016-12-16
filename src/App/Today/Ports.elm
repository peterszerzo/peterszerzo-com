port module Today.Ports exposing (..)

-- JS Subscriptions


port receiveDeeds : (String -> msg) -> Sub msg



-- JS Commands


port requestDeeds : () -> Cmd msg
