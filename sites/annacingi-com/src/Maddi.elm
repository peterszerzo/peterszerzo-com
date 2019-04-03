module Maddi exposing (main)

import Browser
import Browser.Events as Events
import Browser.Navigation as Navigation
import Css exposing (..)
import Css.Global as Global
import Html exposing (Html)
import Html.Styled exposing (div, h1, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Json.Decode as Decode
import Json.Encode as Encode
import Maddi.Content as Content
import Maddi.Data.Project as Project
import Maddi.Ui as Ui
import Maddi.Ui.Carousel as Carousel
import Maddi.Ui.Project as ProjectView
import Maddi.Ui.Wing as Wing
import Process
import Task
import Time
import Url
import Url.Parser exposing (..)


type alias Flags =
    Encode.Value


type alias Model =
    { key : Navigation.Key
    , route : Route
    , prevRoute : Maybe Route
    , nextRoute : Maybe Route
    , projectViewState : ProjectView.State
    , aboutCarouselState : Carousel.State
    , mobileNav : Bool
    }


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , route = parse url
      , prevRoute = Nothing
      , nextRoute = Nothing
      , projectViewState = ProjectView.init
      , aboutCarouselState = Carousel.init
      , mobileNav = False
      }
    , Cmd.none
    )


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange =
            ChangeRoute << parse
        }


type Route
    = Home
    | About
    | Project String
    | NotFound


parse : Url.Url -> Route
parse location =
    location
        |> Url.Parser.parse matchers
        |> Maybe.withDefault NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ Url.Parser.top |> map Home
        , s "projects" </> string |> map Project
        , s "about" |> map About
        ]


type Msg
    = Navigate String
    | SetMobileNav Bool
    | UrlRequest Browser.UrlRequest
    | ChangeRoute Route
    | ChangeProjectView ProjectView.State
    | ChangeProjectViewState ProjectView.State
    | ChangeAboutCarousel Carousel.State
    | ChangeAboutCarouselState Carousel.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetMobileNav mobileNav ->
            ( { model | mobileNav = mobileNav }, Cmd.none )

        Navigate newPath ->
            ( model
            , Navigation.pushUrl model.key newPath
            )

        UrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    let
                        stringUrl =
                            Url.toString url
                    in
                    if String.right 4 stringUrl == ".pdf" then
                        ( model, Navigation.load stringUrl )

                    else
                        ( model
                        , Navigation.pushUrl model.key stringUrl
                        )

                Browser.External href ->
                    ( model, Navigation.load href )

        ChangeRoute newRoute ->
            ( { model
                | route = newRoute
                , nextRoute = Nothing
                , prevRoute = Just model.route
                , projectViewState = ProjectView.init
                , aboutCarouselState = Carousel.init
                , mobileNav = False
              }
            , Cmd.none
            )

        ChangeProjectView newProjectViewState ->
            ( { model
                | projectViewState = newProjectViewState
              }
            , Cmd.none
            )

        ChangeProjectViewState newProjectViewState ->
            ( { model
                | projectViewState = newProjectViewState
              }
            , Cmd.none
            )

        ChangeAboutCarousel newState ->
            ( { model
                | aboutCarouselState = newState
              }
            , Cmd.none
            )

        ChangeAboutCarouselState newState ->
            ( { model
                | aboutCarouselState = newState
              }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    let
        layout =
            Ui.pageLayout model.mobileNav SetMobileNav >> List.map toUnstyled
    in
    case model.route of
        Home ->
            { title = "Anna Cingi | Set Designer"
            , body =
                [ div
                    [ css
                        [ margin2 (px 60) (px 0)
                        , Ui.fadeIn
                        ]
                    ]
                  <|
                    List.map
                        (\{ title, projects } ->
                            div
                                [ css
                                    [ textAlign center
                                    , paddingBottom (px 35)
                                    , paddingTop (px 100)
                                    , firstChild
                                        [ paddingTop (px 20)
                                        ]
                                    , lastChild
                                        [ paddingBottom (px 10)
                                        ]
                                    ]
                                ]
                                (Wing.wingHeader title
                                    :: List.map
                                        (\project -> Wing.wing project)
                                        projects
                                )
                        )
                        Content.groupedProjects
                ]
                    |> layout
            }

        About ->
            { title = "About Anna"
            , body =
                [ Ui.simplePageContent
                    { title = "About Anna"
                    , left = Ui.static Content.about
                    , right =
                        Carousel.view
                            { data = [ { url = "/maddi/cover.jpg", alt = "Anna Cingi", credit = Nothing } ]
                            , state = model.aboutCarouselState
                            , toMsg = ChangeAboutCarousel
                            }
                    }
                ]
                    |> layout
            }

        Project id ->
            let
                project =
                    Project.findById id Content.groupedProjects
            in
            project
                |> Maybe.map
                    (\project_ ->
                        { title = project_.title
                        , body =
                            [ ProjectView.view
                                { data = project_
                                , state = model.projectViewState
                                , toMsg = ChangeProjectView
                                }
                            ]
                                |> layout
                        }
                    )
                |> Maybe.withDefault
                    { title = "Project not found"
                    , body =
                        [ text "This project was not found" ]
                            |> layout
                    }

        NotFound ->
            { title = "Not found"
            , body =
                [ Wing.wingHeader "It has not been found."
                ]
                    |> layout
            }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ ProjectView.subscriptions model.projectViewState |> Sub.map ChangeProjectViewState
        , Carousel.subscriptions model.aboutCarouselState |> Sub.map ChangeAboutCarouselState
        ]
