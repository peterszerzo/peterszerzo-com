module OverEasy exposing (..)

import Time
import Task
import Process
import AnimationFrame
import Css exposing (..)
import Css.Foreign as Foreign
import Html exposing (Html)
import Html.Styled exposing (fromUnstyled, toUnstyled, text, div, img)
import Html.Styled.Attributes exposing (css)
import OverEasy.Pieces as Pieces
import Navigation
import Window
import UrlParser exposing (..)
import OverEasy.Views.Home
import OverEasy.Views.Nav


type Route
    = Home Int
    | Pieces Pieces.Route
    | NotFound


parse : Navigation.Location -> Route
parse location =
    location
        |> parsePath matchers
        |> Maybe.withDefault (Home 0)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "" <?> intParam "p" |> map (Maybe.withDefault 0 >> Home)
        , Pieces.matchers |> map Pieces
        ]


links : List ( String, String )
links =
    [ ( "/more-simple-less-simple", "1. more-simple-less-simple" )
    , ( "/our-bearings-are-fragile", "2. our-bearings-are-fragile" )
    , ( "/bureaucracy-is-distracting", "3. bureaucracy-is-distracting" )
    , ( "/walk-with-me", "4. walk-with-me" )
    ]


type NavState
    = Rest
    | Outbound
    | Inbound


type Msg
    = ChangeRoute Route
    | Navigate String
    | RestRoute
    | DelayedNavigate String
    | PieceMsg Pieces.Msg
    | Resize Window.Size
    | Tick Time.Time
    | StartTime Time.Time


type alias Model =
    { route : Route
    , navState : NavState
    , window : Window.Size
    , startTime : Time.Time
    , time : Time.Time
    , lastHomePage : Int
    }


routeInitCmd : Route -> Cmd Msg
routeInitCmd route =
    case route of
        Pieces piece ->
            Pieces.routeInitCmd piece |> Cmd.map PieceMsg

        _ ->
            Cmd.none


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            parse location
    in
        ( { route = route
          , navState = Rest
          , window =
                { width = 0
                , height = 0
                }
          , startTime = 0
          , time = 0
          , lastHomePage = 0
          }
        , Cmd.batch
            [ routeInitCmd route
            , Window.size |> Task.perform Resize
            , Time.now |> Task.perform StartTime
            ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate newPath ->
            ( model
            , Navigation.newUrl newPath
            )

        DelayedNavigate newPath ->
            ( { model | navState = Outbound }
            , Process.sleep (200 * Time.millisecond)
                |> Task.attempt (\res -> Navigate newPath)
            )

        ChangeRoute route ->
            ( { model
                | route = route
                , navState =
                    if model.navState == Outbound then
                        Inbound
                    else
                        model.navState
                , lastHomePage =
                    case route of
                        Home page ->
                            page

                        _ ->
                            model.lastHomePage
              }
            , Cmd.batch
                [ routeInitCmd route
                , if model.navState == Outbound then
                    Process.sleep (0 * Time.millisecond) |> Task.attempt (\res -> RestRoute)
                  else
                    Cmd.none
                ]
            )

        RestRoute ->
            ( { model | navState = Rest }, Cmd.none )

        Resize window ->
            ( { model | window = window }, Cmd.none )

        Tick time ->
            ( { model | time = time }, Cmd.none )

        StartTime time ->
            ( { model | startTime = time }, Cmd.none )

        PieceMsg pageMsg ->
            case model.route of
                Pieces pieces ->
                    Pieces.update pageMsg pieces
                        |> (\( route, cmd ) ->
                                ( { model | route = Pieces route }
                                , Cmd.map PieceMsg cmd
                                )
                           )

                _ ->
                    ( model, Cmd.none )


viewProject :
    { scale : Float
    , project : Html.Html msg
    , css : List Style
    }
    -> Html.Styled.Html msg
viewProject config =
    div
        [ css
            [ width (pct 100)
            , height (pct 100)
            , displayFlex
            , alignItems center
            , justifyContent center
            , Css.batch config.css
            ]
        ]
        [ div
            [ css
                [ width (px 800)
                , height (px 480)
                , property "transform" <| "scale(" ++ (toString config.scale) ++ "," ++ (toString config.scale) ++ ")"
                ]
            ]
            [ fromUnstyled config.project ]
        ]


projectScale : Window.Size -> Float
projectScale window =
    let
        w =
            800

        h =
            480

        fx =
            (window.width - 40 |> toFloat) / w

        fy =
            (window.height - 40 |> toFloat) / h
    in
        min fx fy
            |> min 1


view : Model -> Html Msg
view model =
    let
        scale =
            projectScale model.window

        transitionCss =
            [ opacity
                (if model.navState == Inbound || model.navState == Outbound then
                    (num 0)
                 else
                    (num 1)
                )
            , property "transition" "opacity 0.3s"
            ]

        viewPrj project =
            viewProject
                { project = project
                , css = transitionCss
                , scale = scale
                }
    in
        div
            [ css
                [ height (pct 100)
                ]
            ]
            [ Foreign.global
                [ Foreign.each
                    [ Foreign.body
                    , Foreign.html
                    ]
                    [ width (pct 100)
                    , height (pct 100)
                    , padding (px 0)
                    , margin (px 0)
                    ]
                , Foreign.body
                    [ backgroundColor (hex "000")
                    ]
                , Foreign.everything
                    [ property "font-family" "Moon, sans-serif"
                    ]
                ]
            , case model.route of
                Home _ ->
                    text ""

                _ ->
                    OverEasy.Views.Nav.view (DelayedNavigate <| "/?p=" ++ (toString model.lastHomePage))
            , case model.route of
                Home page ->
                    OverEasy.Views.Home.view
                        { delayedNavigate = DelayedNavigate
                        , navigate = Navigate
                        , links = links
                        , page = page
                        , window = model.window
                        , time = model.time - model.startTime
                        , css = transitionCss
                        }

                NotFound ->
                    Html.Styled.text "Not found"

                Pieces piece ->
                    Pieces.view piece
                        |> Html.map PieceMsg
                        |> viewPrj
            ]
            |> toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case model.route of
            Pieces pieces ->
                Pieces.subscriptions pieces |> Sub.map PieceMsg

            Home _ ->
                Sub.none

            NotFound ->
                Sub.none
        , Window.resizes Resize
        , AnimationFrame.times Tick
        ]


main : Program Never Model Msg
main =
    Navigation.program
        (ChangeRoute << parse)
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
