module OverEasy exposing (..)

import String.Future
import Time
import Task
import AnimationFrame
import Css exposing (..)
import Css.Foreign as Foreign
import Html exposing (Html)
import Html.Styled exposing (fromUnstyled, toUnstyled, text, div, img)
import Html.Styled.Attributes exposing (css)
import Navigation
import Window
import UrlParser exposing (..)
import OverEasy.Views.Home
import OverEasy.Pieces as Pieces
import OverEasy.Views.Nav
import OverEasy.Constants exposing (..)
import Shared.SmoothNav as SmoothNav


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


type Msg
    = SmoothNav (SmoothNav.Msg Route)
    | Navigate String
    | DelayedNavigate String
    | PieceMsg Pieces.Msg
    | Resize Window.Size
    | Tick Time.Time
    | StartTime Time.Time
    | NoOp


type alias Model =
    { smoothNav : SmoothNav.Model Route
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

        ( smoothNav, smoothNavCmd ) =
            SmoothNav.init route
    in
        ( { smoothNav = smoothNav
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
            , smoothNavCmd |> Cmd.map SmoothNav
            ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Resize window ->
            ( { model | window = window }, Cmd.none )

        SmoothNav smoothNavMsg ->
            let
                ( smoothNav, smoothNavCmd ) =
                    SmoothNav.update smoothNavMsg model.smoothNav
            in
                ( { model | smoothNav = smoothNav }
                , Cmd.batch
                    [ smoothNavCmd |> Cmd.map SmoothNav
                    , case smoothNavMsg of
                        SmoothNav.ChangeRoute route ->
                            routeInitCmd route

                        _ ->
                            Cmd.none
                    ]
                )

        Tick time ->
            ( { model | time = time }, Cmd.none )

        StartTime time ->
            ( { model | startTime = time }, Cmd.none )

        PieceMsg pageMsg ->
            case SmoothNav.route model.smoothNav of
                Pieces pieces ->
                    Pieces.update pageMsg pieces
                        |> (\( route, cmd ) ->
                                ( { model | smoothNav = SmoothNav.setRoute (Pieces route) model.smoothNav }
                                , Cmd.map PieceMsg cmd
                                )
                           )

                _ ->
                    ( model, Cmd.none )

        Navigate newUrl ->
            ( model, SmoothNav.newUrl newUrl |> Cmd.map SmoothNav )

        DelayedNavigate newUrl ->
            ( model, SmoothNav.delayedNewUrl newUrl |> Cmd.map SmoothNav )


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
                , property "transform" <|
                    "scale("
                        ++ (String.Future.fromFloat config.scale)
                        ++ ","
                        ++ (String.Future.fromFloat config.scale)
                        ++ ")"
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


transitionCss : SmoothNav.NavState -> List Style
transitionCss navState =
    (case navState of
        SmoothNav.Rest ->
            [ opacity (num 1)
            , transform (translate3d (px 0) (px 0) (px 0))
            ]

        SmoothNav.Outbound ->
            [ opacity (num 0)
            , transform (translate3d (px 8) (px 8) (px 0))
            ]

        SmoothNav.Inbound ->
            [ opacity (num 0)
            , transform (translate3d (px -8) (px -8) (px 0))
            ]

        SmoothNav.Clear ->
            []
    )
        ++ ([ property "transition" "all 0.2s"
            ]
           )


view : Model -> Html Msg
view model =
    let
        navState =
            SmoothNav.navState model.smoothNav

        route =
            SmoothNav.route model.smoothNav

        scale =
            projectScale model.window

        viewPrj project =
            viewProject
                { project = project
                , css = transitionCss navState
                , scale = scale
                }

        transitionCss_ =
            transitionCss navState
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
                , case route of
                    Home _ ->
                        text ""

                    _ ->
                        OverEasy.Views.Nav.view
                            { onClick = (DelayedNavigate <| "/?p=" ++ (String.Future.fromInt model.lastHomePage))
                            , css = transitionCss_
                            }
                , if navState == SmoothNav.Clear then
                    text ""
                  else
                    (case route of
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
        [ case SmoothNav.route model.smoothNav of
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
        ((SmoothNav << SmoothNav.ChangeRoute) << parse)
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
