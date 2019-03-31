module OverEasy exposing (main)

import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Browser.Navigation as Navigation
import Css exposing (..)
import Css.Global as Global
import Html exposing (Html)
import Html.Styled exposing (div, fromUnstyled, img, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Json.Encode as Encode
import OverEasy.Constants exposing (..)
import OverEasy.Pieces as Pieces
import OverEasy.Views.Home
import OverEasy.Views.Nav
import Shared.SmoothNav as SmoothNav
import Task
import Time
import Url
import Url.Parser exposing (..)
import Url.Parser.Query as Query


type Route
    = Home Int
    | Pieces Pieces.Route
    | NotFound


type alias Flags =
    Encode.Value


parse : Url.Url -> Route
parse location =
    location
        |> Url.Parser.parse matchers
        |> Maybe.withDefault (Home 0)


timeDiff : Model -> Float
timeDiff model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ Url.Parser.top <?> Query.int "p" |> map (Maybe.withDefault 0 >> Home)
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
    | UrlRequest Browser.UrlRequest
    | Resize Int Int
    | Tick Time.Posix
    | StartTime Time.Posix
    | NoOp


type alias Model =
    { smoothNav : SmoothNav.Model Route
    , key : Navigation.Key
    , window : { width : Int, height : Int }
    , startTime : Maybe Time.Posix
    , time : Maybe Time.Posix
    , lastHomePage : Int
    }


routeInitCmd : Route -> Cmd Msg
routeInitCmd route =
    case route of
        Pieces piece ->
            Pieces.routeInitCmd piece |> Cmd.map PieceMsg

        _ ->
            Cmd.none


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            parse url

        ( smoothNav, smoothNavCmd ) =
            SmoothNav.init route
    in
    ( { smoothNav = smoothNav
      , key = key
      , window =
            { width = 0
            , height = 0
            }
      , startTime = Nothing
      , time = Nothing
      , lastHomePage = 0
      }
    , Cmd.batch
        [ routeInitCmd route
        , Dom.getViewport |> Task.perform (\viewport -> Resize (floor viewport.viewport.width) (floor viewport.viewport.height))
        , Time.now |> Task.perform StartTime
        , smoothNavCmd |> Cmd.map SmoothNav
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Resize width height ->
            ( { model | window = { width = width, height = height } }, Cmd.none )

        SmoothNav smoothNavMsg ->
            let
                ( smoothNav, smoothNavCmd ) =
                    SmoothNav.update model.key smoothNavMsg model.smoothNav
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

        UrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    let
                        urlString =
                            Url.toString url

                        isSmooth =
                            String.contains "nosmooth" urlString
                                |> not
                    in
                    ( model
                    , if isSmooth then
                        SmoothNav.delayedNewUrl urlString
                            |> Cmd.map SmoothNav

                      else
                        Navigation.pushUrl model.key urlString
                    )

                Browser.External href ->
                    ( model, Navigation.load href )

        Tick time ->
            ( { model
                | time =
                    Just time
              }
            , Cmd.none
            )

        StartTime time ->
            ( { model | startTime = Just time }, Cmd.none )

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
                        ++ String.fromFloat config.scale
                        ++ ","
                        ++ String.fromFloat config.scale
                        ++ ")"
                ]
            ]
            [ fromUnstyled config.project ]
        ]


projectScale : { width : Int, height : Int } -> Float
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
        ++ [ property "transition" "all 0.2s"
           ]


view : Model -> Browser.Document Msg
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
    { title = "OverEasy"
    , body =
        [ if model.window.width == 0 && model.window.height == 0 then
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
                [ Global.global
                    [ Global.each
                        [ Global.body
                        , Global.html
                        ]
                        [ width (pct 100)
                        , height (pct 100)
                        , padding (px 0)
                        , margin (px 0)
                        ]
                    , Global.body
                        [ backgroundColor black
                        ]
                    , Global.everything
                        [ property "font-family" "Moon, sans-serif"
                        ]
                    ]
                , case route of
                    Home _ ->
                        text ""

                    _ ->
                        OverEasy.Views.Nav.view
                            { onClick = DelayedNavigate <| "/?p=" ++ String.fromInt model.lastHomePage
                            , css = transitionCss_
                            }
                , if navState == SmoothNav.Clear then
                    text ""

                  else
                    case route of
                        Home page ->
                            OverEasy.Views.Home.view
                                { links = links
                                , page = page
                                , window = model.window
                                , time = timeDiff model
                                , css = transitionCss_
                                }

                        NotFound ->
                            text "Not found"

                        Pieces piece ->
                            Pieces.view piece
                                |> Html.map PieceMsg
                                |> viewPrj
                ]
                |> toUnstyled
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case SmoothNav.route model.smoothNav of
            Pieces pieces ->
                Pieces.subscriptions pieces |> Sub.map PieceMsg

            Home _ ->
                Sub.batch
                    [ Events.onAnimationFrame Tick
                    , Events.onResize Resize
                    ]

            NotFound ->
                Sub.none
        ]


main : Program Flags Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = (SmoothNav << SmoothNav.ChangeRoute) << parse
        , onUrlRequest = UrlRequest
        }
