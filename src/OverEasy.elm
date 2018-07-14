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
import Navigation
import Window
import UrlParser exposing (..)


--

import OverEasy.Views.Home
import OverEasy.Pieces as Pieces
import OverEasy.Views.Nav
import OverEasy.Constants exposing (..)


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
    | Clear


type Msg
    = ChangeRoute Route
    | Navigate String
    | RestRoute
    | DelayedNavigate String
    | DelayedNavigate2 String
    | DelayedNavigate3 String
    | PieceMsg Pieces.Msg
    | Resize Window.Size
    | Tick Time.Time
    | StartTime Time.Time
    | NoOp


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
          , navState = Inbound
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
            , Process.sleep (50 * Time.millisecond) |> Task.attempt (\res -> RestRoute)
            ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Navigate newPath ->
            ( model
            , Navigation.newUrl newPath
            )

        DelayedNavigate newPath ->
            ( { model | navState = Outbound }
            , Process.sleep (200 * Time.millisecond)
                |> Task.attempt (\res -> DelayedNavigate2 newPath)
            )

        DelayedNavigate2 newPath ->
            ( { model | navState = Clear }
            , Process.sleep (20 * Time.millisecond)
                |> Task.attempt (\res -> DelayedNavigate3 newPath)
            )

        DelayedNavigate3 newPath ->
            ( model
            , Navigation.newUrl newPath
            )

        ChangeRoute route ->
            ( { model
                | route = route
                , navState =
                    if model.navState == Clear then
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
                , if model.navState == Clear then
                    Process.sleep (50 * Time.millisecond) |> Task.attempt (\res -> RestRoute)
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


transitionCss : NavState -> List Style
transitionCss navState =
    (case navState of
        Rest ->
            [ opacity (num 1)
            , transform (translate3d (px 0) (px 0) (px 0))
            ]

        Outbound ->
            [ opacity (num 0)
            , transform (translate3d (px 8) (px 8) (px 0))
            ]

        Inbound ->
            [ opacity (num 0)
            , transform (translate3d (px -8) (px -8) (px 0))
            ]

        Clear ->
            []
    )
        ++ ([ property "transition" "all 0.2s"
            ]
           )


view : Model -> Html Msg
view model =
    let
        scale =
            projectScale model.window

        viewPrj project =
            viewProject
                { project = project
                , css = transitionCss model.navState
                , scale = scale
                }

        transitionCss_ =
            transitionCss model.navState
    in
        if (model.window.width == 0 && model.window.height == 0) then
            text "" |> toUnstyled
        else
            div
                [ css
                    [ height (pct 100)
                    , width (pct 100)
                    , position relative
                    , overflow hidden
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
                        [ backgroundColor black
                        ]
                    , Foreign.everything
                        [ property "font-family" "Moon, sans-serif"
                        ]
                    ]
                , case model.route of
                    Home _ ->
                        text ""

                    _ ->
                        OverEasy.Views.Nav.view
                            { onClick = (DelayedNavigate <| "/?p=" ++ (toString model.lastHomePage))
                            , css = transitionCss_
                            }
                , if model.navState == Clear then
                    text ""
                  else
                    (case model.route of
                        Home page ->
                            OverEasy.Views.Home.view
                                { delayedNavigate = DelayedNavigate
                                , navigate = Navigate
                                , links = links
                                , page = page
                                , window = model.window
                                , time = model.time - model.startTime
                                , css = transitionCss_
                                }

                        NotFound ->
                            text "Not found"

                        Pieces piece ->
                            Pieces.view piece
                                |> Html.map PieceMsg
                                |> viewPrj
                    )
                ]
                |> toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case model.route of
            Pieces pieces ->
                Pieces.subscriptions pieces |> Sub.map PieceMsg

            Home _ ->
                Sub.batch
                    [ AnimationFrame.times Tick
                    , Window.resizes Resize
                    ]

            NotFound ->
                Sub.none
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
