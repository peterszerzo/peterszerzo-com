module Views.Main exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.Attributes exposing (class, classList, src, href, attribute, style)
import Html.Events exposing (onClick)
import Markdown exposing (toHtml)
import Models exposing (Model)
import Router
import Messages exposing (Msg(..))
import Views.TextBox
import Views.ProjectBox
import Views.Background
import Content
import Views.Banner
import Views.Shapes exposing (logo, smallLogo, falafel, close)
import Views.Links exposing (viewMainLinks)
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
                    menu model

                Router.Talks ->
                    Views.TextBox.view ( Content.talks, Nothing ) model.isQuirky

                Router.NotFound ->
                    div [] []
    in
        div [ style [ ( "width", "100%" ), ( "height", "100%" ) ] ]
            [ node "style" [] [ compile [ css ] |> .css |> text ]
            , div
                [ class "Main"
                ]
                [ div
                    [ class "MainContent"
                    ]
                    [ Views.Banner.view
                    ]
                , content
                , Views.Background.view model
                , header_ model
                , notification model
                ]
            ]


header_ : Model -> Html Msg
header_ model =
    let
        currentPath =
            Router.routeToSlug model.route

        isHome =
            model.route == Router.Home
    in
        header
            [ classList
                [ ( "Header", True )
                , ( "HeaderDiscrete", isHome )
                ]
            ]
            [ div
                [ class "HeaderIcon HeaderLogo"
                , onClick
                    (ChangePath "")
                ]
                [ smallLogo ]
            , viewMainLinks currentPath "DesktopLinks" "DesktopLink"
            , div
                [ class "HeaderIcon HeaderFalafel"
                , onClick
                    (ChangePath
                        (if model.route == Router.Menu then
                            ""
                         else
                            "menu"
                        )
                    )
                ]
                [ if (model.route == Router.Menu) then
                    close
                  else
                    falafel True
                ]
            ]


notification : Models.Model -> Html.Html Msg
notification model =
    div
        [ classList
            [ ( "Notification", True )
            , ( "NotificationVisible", (not model.isNotificationDismissed) && (model.time > 12 && model.time < 75) )
            ]
        ]
        [ toHtml
            [ class "NotificationBody"
            ]
            Content.notification
        , div
            [ class "NotificationClose"
            , onClick DismissNotification
            ]
            [ close
            ]
        ]


menu : Model -> Html Msg
menu model =
    let
        currentPath =
            Router.routeToSlug model.route
    in
        div
            [ class "Menu"
            ]
            [ viewMainLinks currentPath "MenuLinks" "MenuLink"
            ]
