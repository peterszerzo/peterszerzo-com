module Notification.Update exposing (..)

import Notification.Messages exposing (Msg(..))

update msg model =
  case msg of

    Toggle ->
      {model | isVisible = not model.isVisible, timeSinceVisible = 0}

    Tick ->
      let
        (isVisible, timeSinceVisible) = case model.isVisible of
          True -> (model.timeSinceVisible < 10, model.timeSinceVisible + 1)
          False -> (False, 0)
      in
        {model | timeSinceVisible = timeSinceVisible, isVisible = isVisible}
