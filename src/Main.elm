module Main exposing (..)

import Task
import AnimationFrame
import Window
import Time
import Json.Encode as Encode
import Json.Decode as Decode
import Navigation exposing (Location, programWithFlags)
import Messages exposing (Msg(..))
import Html exposing (Html, div, text, h1, h2, p, header, node)
import Content
import Data.PackBubble as PackBubble
import Ports
import Router exposing (Route, parse)
import Views.ContentBox
import Views.Background
import Views.Banner
import Views.Static
import Views.Projects
import Views.Styles exposing (CssClasses(..), localClass)
import Styles exposing (css)
import Styles.Raw exposing (raw)
import Css.File exposing (compile)


type alias Flags =
    { isDev : Bool
    }


type alias Model =
    { route : Route
    , isQuirky : Bool
    , time : Time.Time
    , startTime : Time.Time
    , isDev : Bool
    , window : Window.Size
    , projectPackBubbles : List PackBubble.PackBubble
    }


init : Flags -> Location -> ( Model, Cmd Msg )
init { isDev } location =
    ( { route = (parse location)
      , isQuirky = False
      , isDev = isDev
      , time = 0
      , startTime = 0
      , window = (Window.Size 0 0)
      , projectPackBubbles = []
      }
    , Task.perform Resize Window.size
    )


main : Program Flags Model Msg
main =
    programWithFlags
        (ChangeRoute << parse)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleQuirky ->
            ( { model | isQuirky = not model.isQuirky }
            , Cmd.none
            )

        Navigate newPath ->
            ( model
            , Navigation.newUrl newPath
            )

        ChangeRoute newRoute ->
            ( { model | route = newRoute }
            , Cmd.none
            )

        Resize window ->
            ( { model | window = window }
            , Ports.packLayoutReq <|
                Encode.object
                    [ ( "width", Encode.int window.width )
                    , ( "height", Encode.int <| window.height - 60 )
                    , ( "sizes", Encode.list <| List.map Encode.int (List.map .size Content.projects) )
                    ]
            )

        AnimationTick time ->
            ( { model
                | time = time
                , startTime =
                    if model.startTime == 0 then
                        time
                    else
                        model.startTime
              }
            , Cmd.none
            )

        PackLayoutResponse value ->
            ( { model
                | projectPackBubbles =
                    value
                        |> Decode.decodeValue (Decode.list PackBubble.decoder)
                        |> Result.withDefault []
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes Resize
        , Ports.packLayoutRes PackLayoutResponse
        , case model.route of
            Router.Home ->
                AnimationFrame.times AnimationTick

            _ ->
                Sub.none
        ]


view : Model -> Html Msg
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
                    let
                        project =
                            Content.projects
                                |> List.filter (\p -> p.id == prj)
                                |> List.head
                                |> Maybe.withDefault
                                    { id = ""
                                    , name = ""
                                    , description = ""
                                    , image = ""
                                    , size = 0
                                    , url = ""
                                    }
                    in
                        Views.ContentBox.view
                            { content =
                                [ Views.Projects.view
                                    { packBubbles = model.projectPackBubbles
                                    , projects = Content.projects
                                    , activeProject = Just prj
                                    }
                                ]
                            , breadcrumbs =
                                [ { label = "Projects", url = Just "/projects" }
                                , { label = project.name, url = Nothing }
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
                        , Views.Background.view model.window (model.time - model.startTime)
                        ]
                   ]
            )
