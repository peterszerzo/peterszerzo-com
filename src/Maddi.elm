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
import Maddi.Views as Views
import Maddi.Views.Carousel as Carousel
import Maddi.Views.Mixins as Mixins exposing (mobile)
import Maddi.Views.Project as ProjectView
import Maddi.Views.Wing as Wing
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
    = NoOp
    | Navigate String
    | DelayedNavigate String
    | SetMobileNav Bool
    | UrlRequest Browser.UrlRequest
    | ChangeRoute Route
    | ChangeProjectView ProjectView.State ProjectView.Data
    | ChangeProjectViewState ProjectView.State
    | ChangeAboutCarousel Carousel.State Carousel.Data
    | ChangeAboutCarouselState Carousel.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetMobileNav mobileNav ->
            ( { model | mobileNav = mobileNav }, Cmd.none )

        Navigate newPath ->
            ( model
            , Navigation.pushUrl model.key newPath
            )

        DelayedNavigate newPath ->
            ( { model
                | nextRoute =
                    newPath
                        |> Url.fromString
                        |> Maybe.map parse
              }
            , Process.sleep 400
                |> Task.attempt (\res -> Navigate newPath)
            )

        UrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Navigation.pushUrl model.key (Url.toString url)
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

        ChangeProjectView newProjectViewState _ ->
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

        ChangeAboutCarousel newState _ ->
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
            Views.pageLayout model.mobileNav SetMobileNav >> List.map toUnstyled
    in
    case model.route of
        Home ->
            { title = "Anna Cingi | Set Designer"
            , body =
                [ div
                    [ css
                        [ margin2 (px 60) (px 0)
                        , Mixins.fadeIn
                        ]
                    ]
                  <|
                    List.map
                        (\{ title, projects } ->
                            div
                                [ css
                                    [ textAlign center
                                    , paddingBottom (px 40)
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
                [ Views.simplePageContent
                    [ Views.static Content.about
                    , Carousel.view
                        { data = [ ( "/maddi/cover.jpg", "Anna Cingi" ) ]
                        , state = model.aboutCarouselState
                        , toMsg = ChangeAboutCarousel
                        }
                    ]
                ]
                    |> layout
            }

        Project id ->
            let
                project =
                    Project.findById id Content.groupedProjects
                        |> Maybe.withDefault Project.placeholder
            in
            { title = project.title
            , body =
                [ ProjectView.view
                    { data = project
                    , state = model.projectViewState
                    , toStatefulMsg = ChangeProjectView
                    }
                ]
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