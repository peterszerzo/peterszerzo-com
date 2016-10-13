module Views exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class, src, href)
import Html.App exposing (map)

import Models exposing (Model, Mode(..))
import Messages exposing (Msg(..))
import Views.DesktopNav
import Views.MobileNav
import Notification.Views
import Views.TextBox
import Views.Banner

viewMainContent : Model -> Html Msg
viewMainContent model =
  div
    [ class "main__content"
    ]
    [ Views.Banner.view
    ]

view : Model -> Html Msg
view model =
  div
    [ class "main"
    ]
    [ viewMainContent model
    , Views.TextBox.view model
    , Views.DesktopNav.view model.route
    , map NotificationMsg (Notification.Views.view model.notification)
    , Views.MobileNav.view model.mobileNav model.route (not model.mobileNav.isActive) ToggleMobileNav
    ]
