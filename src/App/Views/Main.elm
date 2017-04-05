module Views.Main exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.Attributes exposing (class, classList, src, href, attribute, style)
import Html.Events exposing (onClick)
import Markdown exposing (toHtml)
import Models exposing (Model, Mode(..))
import Router
import Messages exposing (Msg(..))
import Views.TextBox
import Views.ProjectBox
import Views.Background
import Content
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
                    Views.TextBox.view ( Content.now, Nothing ) model.mode

                Router.About ->
                    Views.TextBox.view ( Content.aboutConventional, Just Content.aboutReal ) model.mode

                Router.Menu ->
                    menu model

                Router.Talks ->
                    Views.TextBox.view ( Content.talks, Nothing ) model.mode

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
                    [ banner
                    ]
                , content
                , Views.Background.view model
                , header_ model
                , notification model
                ]
            ]


banner : Html Msg
banner =
    div
        [ class "banner"
        ]
        [ div
            [ class "banner__logo"
            ]
            [ logo
            , div [ class "banner__image-container" ]
                [ div [ class "banner__image" ] []
                , div [ class "banner__overlay" ] []
                ]
            ]
        , h1 [] [ text Content.title ]
        , p [] [ text Content.subtitle ]
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
                [ ( "header", True )
                , ( "header--discrete", isHome )
                ]
            ]
            [ div
                [ class "header__icon header__logo"
                , onClick
                    (ChangePath "")
                ]
                [ smallLogo ]
            , viewMainLinks currentPath "header__desktop-links" "header__desktop-link"
            , div
                [ class "header__icon header__falafel"
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
            [ ( "notification", True )
            , ( "notification--visible", (not model.isNotificationDismissed) && (model.time > 12 && model.time < 75) )
            ]
        ]
        [ toHtml
            [ class "notification__body"
            ]
            Content.notification
        , div
            [ class "notification__close"
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
            [ class "menu"
            ]
            [ viewMainLinks currentPath "menu__links" "menu__link"
            ]
