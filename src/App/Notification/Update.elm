module Notification.Update exposing (..)

import Notification.Messages exposing (Msg(..))
import Ports


update msg model =
    case msg of
        Dismiss ->
            ( { model
                | isVisible = False
                , isDismissed = True
              }
            , Ports.notificationDismissed ()
            )

        Tick time ->
            ( { model
                | isVisible = (not model.isDismissed) && (time > 3) && (time < 60)
              }
            , Cmd.none
            )
