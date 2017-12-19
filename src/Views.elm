module Views exposing (..)

import Html exposing (Html, div, text, h1, h2, p, header, node)
import Data.State exposing (State)
import Router
import Messages exposing (Msg(..))
import Views.ContentBox
import Views.Background
import Content
import Views.Banner
import Views.Notification
import Views.Static
import Views.Projects
import Views.Styles exposing (CssClasses(..), localClass)
import Styles exposing (css)
import Styles.Raw exposing (raw)
import Css.File exposing (compile)


view : State -> Html Msg
view model =
    let
        content =
            case model.route of
                Router.Home ->
                    div [] []

                Router.Projects ->
                    Views.ContentBox.view
                        { content =
                            [ Views.Projects.view
                                { packBubbles = model.projectPackBubbles
                                , projects = Content.projects
                                , activeProject = Nothing
                                }
                            ]
                        , breadcrumbs = [ { label = "Projects", url = Nothing } ]
                        , quirkyContent = Nothing
                        , isQuirky = model.isQuirky
                        }

                Router.Project prj ->
                    Views.ContentBox.view
                        { content =
                            [ Views.Projects.view
                                { packBubbles = model.projectPackBubbles
                                , projects = Content.projects
                                , activeProject = Just prj
                                }
                            ]
                        , breadcrumbs =
                            [ { label = "Projects", url = Nothing }
                            , { label = prj, url = Nothing }
                            ]
                        , quirkyContent = Nothing
                        , isQuirky = model.isQuirky
                        }

                Router.Now ->
                    Views.ContentBox.view
                        { content = [ Views.Static.view Content.now ]
                        , quirkyContent = Nothing
                        , breadcrumbs = [ { label = "Now!", url = Nothing } ]
                        , isQuirky = model.isQuirky
                        }

                Router.About ->
                    Views.ContentBox.view
                        { content = [ Views.Static.view Content.aboutConventional ]
                        , breadcrumbs = [ { label = "About", url = Nothing } ]
                        , quirkyContent = Just [ Views.Static.view Content.aboutReal ]
                        , isQuirky = model.isQuirky
                        }

                Router.Talks ->
                    Views.ContentBox.view
                        { content = [ Views.Static.view Content.talks ]
                        , quirkyContent = Nothing
                        , breadcrumbs = [ { label = "Talks", url = Nothing } ]
                        , isQuirky = model.isQuirky
                        }

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
                        [ Views.Banner.view
                        , content
                        , Views.Background.view model
                        , Views.Notification.view model
                        ]
                   ]
            )
