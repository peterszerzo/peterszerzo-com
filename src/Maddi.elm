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


type alias State =
    { key : Navigation.Key
    , route : Route
    , prevRoute : Maybe Route
    , nextRoute : Maybe Route
    , project : ProjectView.State
    , home : Maybe Int
    , mobileNav : Bool
    }


init : Flags -> Url.Url -> Navigation.Key -> ( State, Cmd Msg )
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


main : Program Flags State Msg
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
    | ChangeProjectState ProjectView.State ProjectView.Data


update : Msg -> State -> ( State, Cmd Msg )
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

        ChangeProjectState project _ ->
            ( { model
                | project = project
              }
            , Cmd.none
            )


layout : State -> List (Html.Styled.Html Msg) -> List (Html Msg)
layout model children =
    [ div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , padding2 (px 60) (px 20)
            , displayFlex
            , alignItems center
            , justifyContent center
            , mobile
                [ overflow auto
                ]
            ]
        ]
        [ Global.global
            [ Global.everything
                [ boxSizing borderBox
                , property "-webkit-font-smoothing" "antialiased"
                , property "font-family" "Lato, sans-serif"
                ]
            , Global.selector """
                @keyframes fadein {
                  0% {
                    opacity: 0;
                  }

                  100% {
                    opacity: 100%;
                  }
                }

                .noselector
                """ [ display block ]
            , Global.each [ Global.html, Global.body ]
                [ margin (px 0)
                , height (pct 100)
                ]
            , Global.body
                [ mobile
                    [ overflow auto
                    , height auto
                    ]
                ]
            , Global.selector "#App"
                [ width (pct 100)
                , height (pct 100)
                , mobile
                    [ height auto
                    ]
                ]
            , Global.a
                [ textDecoration none
                , border (px 0)
                ]
            ]
        , Views.siteHeader
            { navigate = Navigate
            , mobileNav = model.mobileNav
            , setMobileNav = SetMobileNav
            }
        , div
            [ css
                [ maxWidth (px 1000)
                , width (pct 100)
                , margin auto
                , position relative
                ]
            ]
            children
        ]
    ]
        |> List.map toUnstyled


view : State -> Browser.Document Msg
view model =
    let
        selectedProject =
            case model.nextRoute of
                Just (Project projectId) ->
                    Just projectId

                _ ->
                    Nothing
    in
    case model.route of
        Home ->
            { title = "Home"
            , body =
                [ div
                    [ css
                        [ width (pct 100)
                        , height (px 240)
                        , margin2 (px 60) (px 0)
                        , property "animation" "fadein 0.5s ease-in-out forwards"
                        ]
                    ]
                  <|
                    List.indexedMap
                        (\index project ->
                            Wing.wing
                                { order = index
                                , project = project
                                , navigate = DelayedNavigate
                                , selected = selectedProject
                                }
                        )
                        Content.projects
                ]
                    |> layout model
            }

        About ->
            { title = "About"
            , body =
                [ Views.layout
                    [ Views.static Content.about
                    , CarouselView.view
                        { data = [ ( "/maddi/cover.jpg", "Anna Cingi" ) ]
                        , state = CarouselView.init
                        , toMsg = \_ _ -> NoOp
                        }
                    ]
                ]
                    |> layout model
            }

        Project id ->
            let
                project =
                    List.filter (\prj -> prj.id == id) Content.projects
                        |> List.head
                        |> Maybe.withDefault Project.placeholder
            in
            { title = "Projects"
            , body =
                [ ProjectView.view
                    { data = project
                    , state = model.project
                    , toMsg = ChangeProjectState
                    }
                ]
                    |> layout model
            }

        NotFound ->
            { title = "Not found"
            , body =
                [ Html.Styled.text "Not found"
                ]
                    |> layout model
            }


subscriptions : State -> Sub Msg
subscriptions _ =
    Sub.batch
        []
