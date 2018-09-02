module Maddi exposing (..)

import Time
import Process
import Task
import Navigation exposing (Location, program)
import UrlParser exposing (..)
import Css exposing (..)
import Css.Foreign as Foreign
import Html exposing (Html)
import Html.Styled exposing (div, toUnstyled, h1, text)
import Html.Styled.Attributes exposing (css)


--

import Maddi.Views.Carousel as CarouselView
import Maddi.Views.Project as ProjectView
import Maddi.Views as Views
import Maddi.Content as Content
import Maddi.Data.Project as Project


type alias State =
    { route : Route
    , prevRoute : Maybe Route
    , nextRoute : Maybe Route
    , project : ProjectView.State
    , home : Maybe Int
    , mobileNav : Bool
    }


init : Location -> ( State, Cmd Msg )
init location =
    ( { route = parse location
      , prevRoute = Nothing
      , nextRoute = Nothing
      , project = ProjectView.init
      , home = Nothing
      , mobileNav = False
      }
    , Cmd.none
    )


main : Program Never State Msg
main =
    program
        (ChangeRoute << parse)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Route
    = Home
    | About
    | Project String
    | NotFound


parse : Navigation.Location -> Route
parse location =
    location
        |> parsePath matchers
        |> Maybe.withDefault NotFound


parseRawPath : String -> Route
parseRawPath path =
    parse
        { href = ""
        , host = ""
        , hostname = ""
        , protocol = ""
        , origin = ""
        , port_ = ""
        , pathname = path
        , search = ""
        , hash = ""
        , username = ""
        , password = ""
        }


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "" |> map Home
        , s "projects" </> string |> map Project
        , s "about" |> map About
        ]


type Msg
    = NoOp
    | Navigate String
    | DelayedNavigate String
    | SetMobileNav Bool
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
            , Navigation.newUrl newPath
            )

        DelayedNavigate newPath ->
            ( { model
                | nextRoute =
                    parseRawPath newPath
                        |> Just
              }
            , Process.sleep (400 * Time.millisecond)
                |> Task.attempt (\res -> Navigate newPath)
            )

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


view : State -> Html Msg
view model =
    let
        selectedProject =
            case model.nextRoute of
                Just (Project projectId) ->
                    Just projectId

                _ ->
                    Nothing
    in
        div
            [ css
                [ width (pct 100)
                , height (pct 100)
                , padding2 (px 60) (px 20)
                , displayFlex
                , alignItems center
                , justifyContent center
                , Views.mobile
                    [ overflow auto
                    ]
                ]
            ]
            [ Foreign.global
                [ Foreign.everything
                    [ boxSizing borderBox
                    , property "-webkit-font-smoothing" "antialiased"
                    , property "font-family" "Lato, sans-serif"
                    ]
                , Foreign.selector """
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
                , Foreign.each [ Foreign.html, Foreign.body ]
                    [ margin (px 0)
                    , height (pct 100)
                    , overflow hidden
                    ]
                , Foreign.body
                    [ Views.mobile
                        [ overflow auto
                        , height auto
                        ]
                    ]
                , Foreign.selector "#App"
                    [ width (pct 100)
                    , height (pct 100)
                    , Views.mobile
                        [ height auto
                        ]
                    ]
                , Foreign.a
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
                (case model.route of
                    Home ->
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
                                    Views.wing
                                        { order = index
                                        , project = project
                                        , navigate = DelayedNavigate
                                        , selected = selectedProject
                                        }
                                )
                                Content.projects
                        ]

                    About ->
                        [ Views.layout
                            [ Views.static Content.about
                            , CarouselView.view
                                { data = [ ( "/maddi/cover.jpg", "Anna Cingi" ) ]
                                , state = CarouselView.init
                                , toMsg = \_ _ -> NoOp
                                }
                            ]
                        ]

                    Project id ->
                        let
                            project =
                                List.filter (\prj -> prj.id == id) Content.projects
                                    |> List.head
                                    |> Maybe.withDefault Project.placeholder
                        in
                            [ ProjectView.view
                                { data = project
                                , state = model.project
                                , toMsg = ChangeProjectState
                                }
                            ]

                    NotFound ->
                        [ Html.Styled.text "Not found"
                        ]
                )
            ]
            |> toUnstyled


subscriptions : State -> Sub Msg
subscriptions _ =
    Sub.batch
        []
