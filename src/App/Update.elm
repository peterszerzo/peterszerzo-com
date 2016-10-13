module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Mode(..))
import Notification.Update
import Notification.Messages
import Router
import Navigation exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleMode ->
      let
        mode =
          if model.mode == Conventional
            then Real
            else Conventional
      in
        ( {model | mode = mode}
        , Cmd.none)

    NotificationMsg msg ->
      let
        (notificationModel, notificationCmd) = Notification.Update.update msg model.notification
      in
        ( {model | notification = notificationModel}
        , notificationCmd
        )

    ToggleMobileNav ->
      let
        oldMobileNav = model.mobileNav
        newMobileNav = {oldMobileNav | isActive = not oldMobileNav.isActive}
      in
        ( {model | mobileNav = newMobileNav}
        , Cmd.none
        )

    ChangeRoute newRoute ->
      let
        newUrl =
          Router.routeUrls
            |> List.filter (\(rt, url) -> rt == newRoute)
            |> List.head
            |> Maybe.withDefault (Router.Home, "")
            |> snd
      in
        ( model
        , Navigation.newUrl ("/" ++ newUrl)
        )

    Tick time ->
      let
        (notificationModel, notificationCmd) = Notification.Update.update (Notification.Messages.Tick model.time) model.notification
      in
        ( { model |
              time = model.time + 1
            , notification = notificationModel
          }
        , Cmd.none
        )
