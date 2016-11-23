module Views.Main exposing (..)

import Html exposing (Html, div, map)
import Html.Attributes exposing (class, src, href)
import Models exposing (Model, Mode(..))
import Messages exposing (Msg(..))
import Views.DesktopNav
import Views.MobileNav
import Views.TextBox
import Views.Banner
import Views.Notification


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
        , Views.DesktopNav.view model
        , Views.Notification.view model
        , Views.MobileNav.view model
        ]
