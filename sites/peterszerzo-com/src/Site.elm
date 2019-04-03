module Site exposing (main)

import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Browser.Navigation as Navigation
import Css exposing (..)
import Html.Styled exposing (Html, a, div, fromUnstyled, iframe, li, node, text, toUnstyled)
import Html.Styled.Attributes exposing (attribute, css, href, src, style)
import Json.Decode as Decode
import Json.Encode as Encode
import Site.Content as Content
import Site.Data.PackBubble as PackBubble
import Site.Ports as Ports
import Site.Router as Router exposing (Route, parse)
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
    , window :
        { width : Int
        , height : Int
        }
    , projectPackBubbles : List PackBubble.PackBubble
    }


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
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


type Msg
    = SetQuirky Bool
    | Navigate String
    | ChangeRoute Route
    | UrlRequest Browser.UrlRequest
    | AnimationTick Time.Posix
    | Resize Int Int
    | PackLayoutResponse Decode.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuirky isQuirky ->
            ( { model | isQuirky = isQuirky }
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
    [ node "style"
        []
        [ text """
@keyframes fade-in {
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

@keyframes spin {
  0% {
    transform: rotate(0turn);
  }

  100% {
    transform: rotate(1turn);
  }
}
"""
        ]
    , Ui.globalStyles
    , div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , displayFlex
            , alignItems center
            , justifyContent center
            , property "animation" "fade-in ease-out .5s"
            , position relative
            ]
        ]
        children
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
                [ Ui.layout
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
                    , onQuirkyChange = SetQuirky
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
                            , color = ""
                            }
            in
            { title = project.name
            , body =
                [ Ui.layout
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
                    , onQuirkyChange = SetQuirky
                    }
                ]
                    |> layout
            }

        Router.Now ->
            { title = "Now"
            , body =
                [ Ui.layout
                    { content = [ Ui.static { markdown = Just Content.now, children = [] } ]
                    , quirkyContent = Nothing
                    , breadcrumbs = [ { label = "Now!", url = Nothing } ]
                    , isQuirky = model.isQuirky
                    , onQuirkyChange = SetQuirky
                    }
                ]
            }

        Router.About ->
            { title = "About"
            , body =
                [ Ui.layout
                    { content = [ Ui.static { markdown = Just Content.aboutConventional, children = [] } ]
                    , breadcrumbs = [ { label = "About", url = Nothing } ]
                    , quirkyContent = Just [ Ui.static { markdown = Just Content.aboutReal, children = [] } ]
                    , isQuirky = model.isQuirky
                    , onQuirkyChange = SetQuirky
                    }
                ]
                    |> layout
            }

        Router.Talks ->
            { title = "Talks"
            , body =
                [ Ui.layout
                    { content =
                        [ Ui.static
                            { markdown = Just Content.talksIntro
                            , children =
                                [ div []
                                    (Content.talks
                                        |> List.reverse
                                        |> List.map
                                            (\talk ->
                                                [ li []
                                                    ((text <|
                                                        talk.title
                                                            ++ " // "
                                                            ++ talk.location
                                                            ++ " // "
                                                            ++ talk.date
                                                     )
                                                        :: (talk.slidesUrl
                                                                |> Maybe.map
                                                                    (\slidesUrl ->
                                                                        [ text " // "
                                                                        , a [ href slidesUrl ] [ text "Slides" ]
                                                                        ]
                                                                    )
                                                                |> Maybe.withDefault []
                                                           )
                                                    )
                                                , talk.youtubeUrl
                                                    |> Maybe.map
                                                        (\youtubeUrl ->
                                                            div
                                                                [ style "position" "relative"
                                                                , style "padding-bottom" "56%"
                                                                , style "height" "0"
                                                                , style "overflow" "hidden"
                                                                ]
                                                                [ iframe
                                                                    [ style "position" "absolute"
                                                                    , style "top" "0"
                                                                    , style "left" "0"
                                                                    , style "width" "100%"
                                                                    , style "height" "100%"
                                                                    , src youtubeUrl
                                                                    , attribute "frameBorder" "0"
                                                                    , attribute "gesture" "media"
                                                                    , attribute "allow" "encrypted-media"
                                                                    , attribute "allowfullscreen" "true"
                                                                    ]
                                                                    []
                                                                ]
                                                        )
                                                    |> Maybe.withDefault (text "")
                                                ]
                                            )
                                        |> List.foldl (++) []
                                    )
                                ]
                            }
                        ]
                    , quirkyContent = Nothing
                    , breadcrumbs = [ { label = "Talks", url = Nothing } ]
                    , isQuirky = model.isQuirky
                    , onQuirkyChange = SetQuirky
                    }
                ]
                    |> layout
            }

        Router.NotFound ->
            { title = "Not found"
            , body =
                [ div [] []
                ]
                    |> layout
            }
