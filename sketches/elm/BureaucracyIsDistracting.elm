module BureaucracyIsDistracting exposing (main)

import Browser
import Browser.Events as Events
import BureaucracyIsDistracting.Ball as Ball
import BureaucracyIsDistracting.Constants as Constants
import BureaucracyIsDistracting.Scribble as Scribble
import BureaucracyIsDistracting.Stamp as Stamp
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Json.Encode as Encode
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
    560


h : Float
h =
    560


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
    [ ( "top", "30px" )
    , ( "left", "38px" )
    , ( "transform", "rotate(" ++ String.fromFloat rot ++ "rad)" )
    , ( "transform-origin", "-8px 0px" )
    ]


ball : Float -> Ball.Ball -> Html msg
ball time { x, y, rot } =
    div
        [ style "width" "60px"
        , style "height" "60px"
        , style "border-radius" "50%"
        , style "background-color" Constants.blue
        , style "box-shadow" <| "0 0 0 8px " ++ Constants.faintBlue
        , style "position" "absolute"
        , style "left" (toPx (x * w - 15))
        , style "top" (toPx (y * h - 15))
        ]
        [ div
            ([ ( "width", "12px" )
             , ( "height", "12px" )
             , ( "background-color", "#FFF" )
             , ( "border-radius", "6px" )
             , ( "position", "absolute" )
             ]
                ++ ballTransform rot
                |> List.map (\( prop, value ) -> style prop value)
            )
            []
        ]


view : Model -> Html Msg
view model =
    let
        timeDiff_ =
            timeDiff model
    in
    case model.scribble of
        Nothing ->
            text ""

        Just scribble ->
            div
                [ style "width" (String.fromFloat w ++ "px")
                , style "height" (String.fromFloat h ++ "px")
                , style "position" "relative"
                , style "background-color" "#FFF"
                , style "overflow" "hidden"
                , style "border" "1px solid #EFEFEF"
                ]
                [ ball timeDiff_ model.ball
                , div [] <|
                    List.map2
                        (\styles red ->
                            div
                                ((( "position", "absolute" )
                                    :: styles
                                 )
                                    |> List.map (\( prop, value ) -> style prop value)
                                )
                                [ Scribble.view
                                    { time = timeDiff_
                                    , scribble = scribble
                                    , redLines = red
                                    , scale = 3
                                    }
                                ]
                        )
                        [ [ ( "top", "130px" )
                          , ( "left", "-40px" )
                          , ( "transform", "rotateZ(0)" )
                          ]
                        ]
                        [ [ 3, 4, 7 ]
                        ]
                , div
                    [ style "position" "absolute"
                    , style "top" "30px"
                    , style "right" "30px"
                    , style "transform" <| "rotateZ(" ++ String.fromFloat (timeDiff_ / 100) ++ "deg)"
                    ]
                    [ Stamp.view
                        { time = timeDiff_
                        , scale = 1.5
                        }
                    ]
                ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onAnimationFrame Tick
