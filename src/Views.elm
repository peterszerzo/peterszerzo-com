module Views exposing (..)

import Html exposing (Html, div, text, h1, h2, p, header, node)
import Models exposing (Model)
import Router
import Messages exposing (Msg(..))
import Views.ContentBox
import Views.Background
import Content
import Views.Banner
import Views.Notification
import Views.Project
import Views.Header
import Views.Menu
import Views.Static
import Views.Styles exposing (CssClasses(..), localClass)
import Styles exposing (css)
import Styles.Raw exposing (raw)
import Css.File exposing (compile)


view : Model -> Html Msg
view model =
    let
        content =
            case model.route of
                Router.Home ->
                    div [] []

                Router.Projects ->
                    Views.ContentBox.view
                        ( [ h2 [] [ text "Recent works" ]
                          ]
                            ++ (List.map Views.Project.view Content.projects)
                        , Nothing
                        )
                        model.isQuirky

                Router.Now ->
                    Views.ContentBox.view
                        ( [ Views.Static.view Content.now ]
                        , Nothing
                        )
                        model.isQuirky

                Router.About ->
                    Views.ContentBox.view
                        ( [ Views.Static.view Content.aboutConventional ]
                        , Just [ Views.Static.view Content.aboutReal ]
                        )
                        model.isQuirky

                Router.Menu ->
                    Views.Menu.view model

                Router.Talks ->
                    Views.ContentBox.view
                        ( [ Views.Static.view Content.talks ]
                        , Nothing
                        )
                        model.isQuirky

                Router.NotFound ->
                    div [] []
    in
        div [ localClass [ Root ] ]
            ((if model.isDev then
                [ node "style"
                    []
                    [ text (raw ++ (compile [ css ] |> .css))
                    ]
                ]
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
