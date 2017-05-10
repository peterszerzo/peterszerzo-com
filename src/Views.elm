module Views exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.Attributes exposing (class, classList, src, href, attribute, style)
import Models exposing (Model)
import Router
import Messages exposing (Msg(..))
import Views.TextBox
import Views.ProjectBox
import Views.Background
import Content
import Views.Banner
import Views.Notification
import Views.Header
import Views.Menu
import Views.Styles exposing (CssClasses(..), localClass)
import Styles exposing (css)
import Css.File exposing (compile)


view : Model -> Html Msg
view model =
    let
        content =
            case model.route of
                Router.Home ->
                    div [] []

                Router.Projects ->
                    Views.ProjectBox.view Content.projects

                Router.Now ->
                    Views.TextBox.view ( Content.now, Nothing ) model.isQuirky

                Router.About ->
                    Views.TextBox.view ( Content.aboutConventional, Just Content.aboutReal ) model.isQuirky

                Router.Menu ->
                    Views.Menu.view model

                Router.Talks ->
                    Views.TextBox.view ( Content.talks, Nothing ) model.isQuirky

                Router.NotFound ->
                    div [] []
    in
        div [ localClass [ Root ] ]
            ((if model.isDev then
                [ node "style" [] [ compile [ css ] |> .css |> text ] ]
              else
                []
             )
                ++ [ div
                        [ localClass [ Container ]
                        ]
                        [ div
                            [ localClass [ Content ]
                            ]
                            [ Views.Banner.view
                            ]
                        , content
                        , Views.Background.view model
                        , Views.Header.view model
                        , Views.Notification.view model
                        ]
                   ]
            )
