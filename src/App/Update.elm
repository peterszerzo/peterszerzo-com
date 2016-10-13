module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Mode(..))
import Notification.Update
import Notification.Messages
import Router
import Navigation exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({mode, mobileNav} as model) =
  case msg of
    ToggleMode ->
      let
        newMode =
          if mode == Conventional
            then Real
            else Conventional
      in
        ( { model | mode = newMode }
        , Cmd.none)

    NotificationMsg msg ->
      let
        ( notificationModel
        , notificationCmd ) =
          Notification.Update.update msg model.notification
      in
        ( { model | notification = notificationModel }
        , notificationCmd
        )

    ToggleMobileNav ->
      let
        newMobileNav =
          { mobileNav
              | isActive = not mobileNav.isActive
          }
      in
        ( { model
              | mobileNav = newMobileNav
          }
        , Cmd.none
        )

    ChangeRoute newRoute ->
      ( model
      , Navigation.newUrl ("/" ++ (Router.getUrl newRoute))
      )

    Tick time ->
      let
        ( notificationModel
        , notificationCmd ) =
          model.notification
            |> Notification.Update.update (Notification.Messages.Tick model.time)
      in
        ( { model
              | time = model.time + 1
              , notification = notificationModel
          }
        , Cmd.none
        )
