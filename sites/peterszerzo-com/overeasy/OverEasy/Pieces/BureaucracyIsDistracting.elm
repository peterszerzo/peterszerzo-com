module OverEasy.Pieces.BureaucracyIsDistracting exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Events as Events
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Json.Encode as Encode
import OverEasy.Pieces.BureaucracyIsDistracting.Ball as Ball
import OverEasy.Pieces.BureaucracyIsDistracting.Constants as Constants
import OverEasy.Pieces.BureaucracyIsDistracting.Scribble as Scribble
import OverEasy.Pieces.BureaucracyIsDistracting.Stamp as Stamp
import Random
import Time


type alias Model =
    { ball : Ball.Ball
    , scribble : Maybe Scribble.Scribble
    , time : Maybe Time.Posix
    , startTime : Maybe Time.Posix
    }


main : Program Encode.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Encode.Value -> ( Model, Cmd Msg )
init _ =
    ( { ball = Ball.init
      , scribble = Nothing
      , time = Nothing
      , startTime = Nothing
      }
    , Random.generate GenerateScribble Scribble.generator
    )


type Msg
    = Tick Time.Posix
    | GenerateScribble Scribble.Scribble
    | RepositionBall Ball.Ball


w : Float
w =
    800


h : Float
h =
    480


timeDiff : Model -> Float
timeDiff model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model
                | ball = Ball.tick (timeDiff model) model.ball
                , time = Just time
                , startTime =
                    if model.startTime == Nothing then
                        Just time

                    else
                        model.startTime
              }
            , if Ball.shouldReposition model.ball then
                Ball.reposition RepositionBall model.ball

              else
                Cmd.none
            )

        RepositionBall newBall ->
            ( { model | ball = newBall }
            , Cmd.none
            )

        GenerateScribble scribble ->
            ( { model | scribble = Just scribble }
            , Cmd.none
            )


toPx : Float -> String
toPx no =
    String.fromFloat no ++ "px"


ballTransform : Float -> List ( String, String )
ballTransform rot =
    [ ( "top", "0px" )
    , ( "left", "0px" )
    , ( "transform"
      , "translate3d("
            ++ toPx (15 + cos rot * 6 - 3)
            ++ ","
            ++ toPx (15 + sin rot * 6 - 3)
            ++ ", 0px)"
      )
    ]


ballTransform2 : Float -> List ( String, String )
ballTransform2 rot =
    [ ( "top", "15px" )
    , ( "left", "19px" )
    , ( "transform", "rotate(" ++ String.fromFloat rot ++ "rad)" )
    , ( "transform-origin", "-4px 0px" )
    ]


ball : Float -> Ball.Ball -> Html msg
ball time { x, y, rot } =
    div
        [ style "width" "30px"
        , style "height" "30px"
        , style "border-radius" "50%"
        , style "background-color" Constants.blue
        , style "position" "absolute"
        , style "left" (toPx (x * w - 15))
        , style "top" (toPx (y * h - 15))
        ]
        [ div
            ([ ( "width", "6px" )
             , ( "height", "6px" )
             , ( "background-color", "#FFF" )
             , ( "border-radius", "3px" )
             , ( "position", "absolute" )
             ]
                ++ ballTransform2 rot
                |> List.map (\( prop, value ) -> style prop value)
            )
            []
        ]


view : Model -> Html Msg
view model =
    case model.scribble of
        Nothing ->
            text ""

        Just scribble ->
            let
                makeScribble =
                    Scribble.view (timeDiff model) scribble
            in
            div
                [ style "width" (String.fromFloat w ++ "px")
                , style "height" (String.fromFloat h ++ "px")
                , style "position" "relative"
                , style "background-color" "#FFF"
                , style "overflow" "hidden"
                ]
                [ ball (timeDiff model) model.ball
                , div [] <|
                    List.map2
                        (\styles red ->
                            div
                                ([ ( "position", "absolute" )
                                 , ( "top", "40px" )
                                 , ( "left", "140px" )
                                 ]
                                    ++ styles
                                    |> List.map (\( prop, value ) -> style prop value)
                                )
                                [ makeScribble red
                                ]
                        )
                        [ [ ( "top", "40px" )
                          , ( "left", "140px" )
                          , ( "transform", "rotateZ(-30deg)" )
                          ]
                        , [ ( "top", "280px" )
                          , ( "left", "420px" )
                          , ( "transform", "rotateZ(30deg)" )
                          ]
                        , [ ( "top", "60px" )
                          , ( "left", "600px" )
                          , ( "transform", "rotateZ(-45deg)" )
                          ]
                        ]
                        [ [ 3, 4 ]
                        , [ 2, 6, 7 ]
                        , [ 1, 5 ]
                        ]
                , div
                    [ style "width" "160px"
                    , style "height" "160px"
                    , style "position" "absolute"
                    , style "top" "260px"
                    , style "left" "160px"
                    , style "transform" "rotateZ(45deg)"
                    ]
                    [ Stamp.view { time = timeDiff model, singleSnake = True } ]
                , div
                    [ style "width" "160px"
                    , style "height" "160px"
                    , style "position" "absolute"
                    , style "top" "80px"
                    , style "left" "320px"
                    , style "transform" "rotateZ(210deg)"
                    ]
                    [ Stamp.view { time = timeDiff model, singleSnake = False } ]
                ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Events.onAnimationFrame Tick
