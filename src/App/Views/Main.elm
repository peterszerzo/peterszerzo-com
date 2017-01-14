module Views.Main exposing (..)

import Html exposing (Html, div, map)
import Html.Attributes exposing (class, src, href)
import Models exposing (Model, Mode(..))
import Router
import Messages exposing (Msg(..))
import Views.DesktopNav
import Views.MobileNav
import Views.TextBox
import Views.ProjectBox
import Views.Banner
import Views.Notification
import Content


view : Model -> Html Msg
view model =
    let
        currentSlug =
            Router.routeToSlug model.route

        content =
            case model.route of
                Router.Home ->
                    div [] []

                Router.Projects ->
                    Views.ProjectBox.view Content.projects

                Router.Now ->
                    Views.TextBox.view ( Content.now, Nothing ) model.mode

                Router.About ->
                    Views.TextBox.view ( Content.aboutConventional, Just Content.aboutReal ) model.mode

                Router.Talks ->
                    div [] []

                Router.NotFound ->
                    div [] []
    in
        div
            [ class "main"
            ]
            [ div
                [ class "main__content"
                ]
                [ Views.Banner.view
                ]
            , content
            , Views.DesktopNav.view currentSlug
            , Views.Notification.view model
            , Views.MobileNav.view currentSlug model.isMobileNavActive
            ]
