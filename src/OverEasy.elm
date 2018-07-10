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
import OverEasy.Pieces.MoreSimpleLessSimple as MoreSimpleLessSimple
import OverEasy.Pieces.OurBearingsAreFragile as OurBearingsAreFragile
import OverEasy.Pieces.BureaucracyIsDistracting as BureaucracyIsDistracting
import OverEasy.Pieces.BordersAreLenient as BordersAreLenient
import OverEasy.Pieces.WalkWithMe as WalkWithMe
import Navigation
import Window
import UrlParser exposing (..)
import OverEasy.Views.Home
import OverEasy.Views.Nav


type Route
    = Home Int
    | OurBearingsAreFragile OurBearingsAreFragile.Model
    | MoreSimpleLessSimple MoreSimpleLessSimple.Model
    | BureaucracyIsDistracting BureaucracyIsDistracting.Model
    | BordersAreLenient BordersAreLenient.Model
    | WalkWithMe WalkWithMe.Model
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
        , s "more-simple-less-simple" |> map (MoreSimpleLessSimple.init |> Tuple.first |> MoreSimpleLessSimple)
        , s "our-bearings-are-fragile" |> map (OurBearingsAreFragile.init |> Tuple.first |> OurBearingsAreFragile)
        , s "bureaucracy-is-distracting" |> map (BureaucracyIsDistracting.init |> Tuple.first |> BureaucracyIsDistracting)
        , s "borders-are-lenient" |> map (BordersAreLenient.init |> Tuple.first |> BordersAreLenient)
        , s "walk-with-me" |> map (WalkWithMe.init |> Tuple.first |> WalkWithMe)
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
    | BearingsAreFragileMsg OurBearingsAreFragile.Msg
    | MoreSimpleLessSimpleMsg MoreSimpleLessSimple.Msg
    | BureaucracyIsDistractingMsg BureaucracyIsDistracting.Msg
    | BordersAreLenientMsg BordersAreLenient.Msg
    | WalkWithMeMsg WalkWithMe.Msg
    | Resize Window.Size
    | Tick Time.Time
    | StartTime Time.Time


type alias Model =
    { route : Route
    , navState : NavState
    , window : Window.Size
    , startTime : Time.Time
    , time : Time.Time
    }


routeInitCmd : Route -> Cmd Msg
routeInitCmd route =
    case route of
        OurBearingsAreFragile _ ->
            OurBearingsAreFragile.init |> Tuple.second |> Cmd.map BearingsAreFragileMsg

        MoreSimpleLessSimple _ ->
            MoreSimpleLessSimple.init |> Tuple.second |> Cmd.map MoreSimpleLessSimpleMsg

        BureaucracyIsDistracting _ ->
            BureaucracyIsDistracting.init |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg

        BordersAreLenient _ ->
            BordersAreLenient.init |> Tuple.second |> Cmd.map BordersAreLenientMsg

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

        MoreSimpleLessSimpleMsg msg ->
            case model.route of
                MoreSimpleLessSimple model_ ->
                    ( { model | route = MoreSimpleLessSimple (MoreSimpleLessSimple.update msg model_ |> Tuple.first) }
                    , MoreSimpleLessSimple.update msg model_ |> Tuple.second |> Cmd.map MoreSimpleLessSimpleMsg
                    )

                _ ->
                    ( model, Cmd.none )

        BearingsAreFragileMsg msg ->
            case model.route of
                OurBearingsAreFragile model_ ->
                    ( { model | route = OurBearingsAreFragile (OurBearingsAreFragile.update msg model_ |> Tuple.first) }
                    , OurBearingsAreFragile.update msg model_ |> Tuple.second |> Cmd.map BearingsAreFragileMsg
                    )

                _ ->
                    ( model, Cmd.none )

        BureaucracyIsDistractingMsg msg ->
            case model.route of
                BureaucracyIsDistracting model_ ->
                    ( { model | route = BureaucracyIsDistracting (BureaucracyIsDistracting.update msg model_ |> Tuple.first) }
                    , BureaucracyIsDistracting.update msg model_ |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg
                    )

                _ ->
                    ( model, Cmd.none )

        BordersAreLenientMsg msg ->
            case model.route of
                BordersAreLenient model_ ->
                    ( { model | route = BordersAreLenient (BordersAreLenient.update msg model_ |> Tuple.first) }
                    , BordersAreLenient.update msg model_ |> Tuple.second |> Cmd.map BordersAreLenientMsg
                    )

                _ ->
                    ( model, Cmd.none )

        WalkWithMeMsg msg ->
            case model.route of
                WalkWithMe model_ ->
                    ( { model | route = WalkWithMe (WalkWithMe.update msg model_ |> Tuple.first) }
                    , WalkWithMe.update msg model_ |> Tuple.second |> Cmd.map WalkWithMeMsg
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


w : Float
w =
    800


h : Float
h =
    480


view : Model -> Html Msg
view model =
    let
        fx =
            (model.window.width - 40 |> toFloat) / w

        fy =
            (model.window.height - 40 |> toFloat) / h

        scale =
            min fx fy
                |> min 1

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
                    OverEasy.Views.Nav.view (DelayedNavigate "/?p=0")
            , (case model.route of
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

                OurBearingsAreFragile model ->
                    OurBearingsAreFragile.view model
                        |> Html.map BearingsAreFragileMsg
                        |> viewPrj

                MoreSimpleLessSimple model ->
                    MoreSimpleLessSimple.view model
                        |> Html.map MoreSimpleLessSimpleMsg
                        |> viewPrj

                BureaucracyIsDistracting model ->
                    BureaucracyIsDistracting.view model
                        |> Html.map BureaucracyIsDistractingMsg
                        |> viewPrj

                BordersAreLenient model ->
                    BordersAreLenient.view model
                        |> Html.map BordersAreLenientMsg
                        |> viewPrj

                WalkWithMe model ->
                    WalkWithMe.view model
                        |> Html.map WalkWithMeMsg
                        |> viewPrj
              )
            ]
            |> toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case model.route of
            OurBearingsAreFragile model ->
                OurBearingsAreFragile.subscriptions model |> Sub.map BearingsAreFragileMsg

            MoreSimpleLessSimple model ->
                MoreSimpleLessSimple.subscriptions model |> Sub.map MoreSimpleLessSimpleMsg

            BureaucracyIsDistracting model ->
                BureaucracyIsDistracting.subscriptions model |> Sub.map BureaucracyIsDistractingMsg

            BordersAreLenient model ->
                BordersAreLenient.subscriptions model |> Sub.map BordersAreLenientMsg

            WalkWithMe model ->
                WalkWithMe.subscriptions model |> Sub.map WalkWithMeMsg

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
