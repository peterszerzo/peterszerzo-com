module Main.Views exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)
import Html.App exposing (map)

import Routes.Models exposing (Route(..))
import Main.Models exposing (Model, Mode(..))
import Main.Messages exposing (Msg(..))
import Data.Markdown
import Links.Models
import Switch.Views
import Switch.Models
import DesktopNav.Views
import MobileNav.Views
import TextBox.Views
import Notification.Views
import TextBox.Models
import TextBox.Views
import Banner.Views

viewMainContent : Model -> Html Msg
viewMainContent model =
  div
    [ class "main__content"
    ]
    [ Banner.Views.view
    ]

view : Model -> Html Msg
view model =
  div
    [ class "main"
    ]
    [ viewMainContent model
    , TextBox.Views.view model
    , DesktopNav.Views.view model.route
    , map NotificationMsg (Notification.Views.view model.notification)
    , MobileNav.Views.view model.mobileNav model.route (not model.mobileNav.isActive) ToggleMobileNav
    ]
