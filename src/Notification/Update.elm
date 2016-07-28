module Notification.Update exposing (..)

import Notification.Messages exposing (Msg(..))

update msg model =
  case msg of

    Dismiss ->
      { model |
          isVisible = False
        , isDismissed = True
      }

    Tick time ->
      { model |
          isVisible = (not model.isDismissed) && (time > 5) && (time < 60)
      }
