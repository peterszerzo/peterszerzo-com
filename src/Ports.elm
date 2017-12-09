port module Ports exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode


port notificationDismissed : () -> Cmd msg


port packLayoutReq : Encode.Value -> Cmd msg


port packLayoutRes : (Decode.Value -> msg) -> Sub msg
