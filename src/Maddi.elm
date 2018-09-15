module Maddi exposing (main)

import Browser
import Browser.Navigation as Navigation
import Css exposing (..)
import Css.Global as Global
import Html exposing (Html)
import Html.Styled exposing (div, h1, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Json.Encode as Encode
import Maddi.Content as Content
import Maddi.Data.Project as Project
import Maddi.Views as Views
import Maddi.Views.Carousel as CarouselView
import Maddi.Views.Mixins exposing (mobile)
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
    , project : ProjectView.State
    , home : Maybe Int
    , mobileNav : Bool
    }


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , route = parse url
      , prevRoute = Nothing
      , nextRoute = Nothing
      , project = ProjectView.init
      , home = Nothing
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
    | ChangeProjectModel ProjectView.State ProjectView.Data


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
                , project = ProjectView.init
                , mobileNav = False
              }
            , Cmd.none
            )

        ChangeProjectModel project _ ->
            ( { model
                | project = project
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
            { title = "Home"
            , body =
                [ div
                    [ css
                        [ margin2 (px 60) (px 0)
                        , property "animation" "fadein 0.5s ease-in-out forwards"
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
            { title = "About"
            , body =
                [ Views.simplePageContent
                    [ Views.static Content.about
                    , CarouselView.view
                        { data = [ ( "/maddi/cover.jpg", "Anna Cingi" ) ]
                        , state = CarouselView.init
                        , toMsg = \_ _ -> NoOp
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
            { title = "Projects"
            , body =
                [ ProjectView.view
                    { data = project
                    , state = model.project
                    , toStatefulMsg = ChangeProjectModel
                    }
                ]
                    |> layout
            }

        NotFound ->
            { title = "Not found"
            , body =
                [ Html.Styled.text "Not found"
                ]
                    |> layout
            }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []
