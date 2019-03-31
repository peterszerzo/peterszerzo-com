port module Site.Ports exposing (packLayoutReq, packLayoutRes)

import Json.Decode as Decode
import Json.Encode as Encode


port packLayoutReq : Encode.Value -> Cmd msg


port packLayoutRes : (Decode.Value -> msg) -> Sub msg
