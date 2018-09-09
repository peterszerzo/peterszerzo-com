module Site exposing (Model, init, main, subscriptions, update, view)

import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Browser.Navigation as Navigation
import Css exposing (..)
import Html.Styled exposing (Html, div, fromUnstyled, h1, h2, header, node, p, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Json.Decode as Decode
import Json.Encode as Encode
import Site.Content as Content
import Site.Data.PackBubble as PackBubble
import Site.Messages exposing (Msg(..))
import Site.Ports as Ports
import Site.Router as Router exposing (Route, parse)
import Site.Styles exposing (globalStyles)
import Site.Styles.Constants exposing (..)
import Site.Styles.Raw exposing (raw)
import Site.Ui as Ui
import Site.Ui.Background
import Site.Ui.Projects
import Task
import Time
import Url


type alias Flags =
    Encode.Value


type alias Model =
    { key : Navigation.Key
    , route : Route
    , isQuirky : Bool
    , time : Maybe Time.Posix
    , startTime : Maybe Time.Posix
    , window : { width : Int, height : Int }
    , projectPackBubbles : List PackBubble.PackBubble
    }


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , route = parse url
      , isQuirky = False
      , time = Nothing
      , startTime = Nothing
      , window = { width = 0, height = 0 }
      , projectPackBubbles = []
      }
    , Dom.getViewport
        |> Task.perform
            (\viewport ->
                Resize
                    (floor viewport.viewport.width)
                    (floor viewport.viewport.height)
            )
    )


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view =
            view
                >> (\styledDocument ->
                        { title = styledDocument.title
                        , body = List.map toUnstyled styledDocument.body
                        }
                   )
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = ChangeRoute << parse
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
            , Navigation.pushUrl model.key newPath
            )

        ChangeRoute newRoute ->
            ( { model | route = newRoute }
            , Cmd.none
            )

        UrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Navigation.load href )

        Resize width height ->
            ( { model
                | window =
                    { width = width
                    , height = height
                    }
              }
            , Ports.packLayoutReq <|
                Encode.object
                    [ ( "width", Encode.int width )
                    , ( "height", Encode.int <| height - 60 )
                    , ( "sizes"
                      , List.map .size Content.projects
                            |> Encode.list Encode.int
                      )
                    ]
            )

        AnimationTick time ->
            ( { model
                | time = Just time
                , startTime =
                    if model.startTime == Nothing then
                        Just time

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
        [ Events.onResize Resize
        , Ports.packLayoutRes PackLayoutResponse
        , case model.route of
            Router.Home ->
                if startedSince model > 30000 then
                    Sub.none

                else
                    Events.onAnimationFrame AnimationTick

            _ ->
                Sub.none
        ]


startedSince : Model -> Float
startedSince model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0


layout : List (Html msg) -> List (Html msg)
layout children =
    [ div
        [ css
            [ width (pct 100)
            , height (pct 100)
            ]
        ]
        [ node "style"
            []
            [ text raw
            ]
        , globalStyles
        , div
            [ css
                [ width (pct 100)
                , height (pct 100)
                , backgroundColor blue
                , displayFlex
                , alignItems center
                , justifyContent center
                , property "animation" "fade-in ease-out .5s"
                , position relative
                ]
            ]
            children
        ]
    ]


view : Model -> { title : String, body : List (Html Msg) }
view model =
    case model.route of
        Router.Home ->
            { title = "Home"
            , body =
                [ Ui.banner
                , Site.Ui.Background.view model.window (startedSince model) |> fromUnstyled
                ]
                    |> layout
            }

        Router.Projects ->
            { title = "Projects"
            , body =
                [ Ui.contentBox
                    { content =
                        [ Site.Ui.Projects.view
                            { packBubbles = model.projectPackBubbles
                            , projects = Content.projects
                            , activeProject = Nothing
                            }
                        ]
                    , breadcrumbs = [ { label = "Projects", url = Nothing } ]
                    , quirkyContent = Nothing
                    , isQuirky = model.isQuirky
                    }
                ]
                    |> layout
            }

        Router.Project prj ->
            let
                project =
                    Content.projects
                        |> List.filter (\currentProject -> currentProject.id == prj)
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
            { title = "Projects"
            , body =
                [ Ui.contentBox
                    { content =
                        [ Site.Ui.Projects.view
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
                ]
                    |> layout
            }

        Router.Now ->
            { title = "Now"
            , body =
                [ Ui.contentBox
                    { content = [ Ui.static Content.now ]
                    , quirkyContent = Nothing
                    , breadcrumbs = [ { label = "Now!", url = Nothing } ]
                    , isQuirky = model.isQuirky
                    }
                ]
            }

        Router.About ->
            { title = "About"
            , body =
                [ Ui.contentBox
                    { content = [ Ui.static Content.aboutConventional ]
                    , breadcrumbs = [ { label = "About", url = Nothing } ]
                    , quirkyContent = Just [ Ui.static Content.aboutReal ]
                    , isQuirky = model.isQuirky
                    }
                ]
                    |> layout
            }

        Router.Talks ->
            { title = "Talks"
            , body =
                [ Ui.contentBox
                    { content = [ Ui.static Content.talks ]
                    , quirkyContent = Nothing
                    , breadcrumbs = [ { label = "Talks", url = Nothing } ]
                    , isQuirky = model.isQuirky
                    }
                ]
            }

        Router.NotFound ->
            { title = "Not found"
            , body =
                [ div [] []
                ]
                    |> layout
            }
