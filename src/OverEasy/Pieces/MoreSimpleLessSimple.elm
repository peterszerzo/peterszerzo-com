module OverEasy.Pieces.MoreSimpleLessSimple exposing (..)

import Html exposing (Html, div, text, span, program)
import Html.Attributes exposing (style)
import Svg exposing (svg, line, g)
import Svg.Attributes exposing (viewBox, x1, x2, y1, y2, stroke, strokeWidth, width, height, transform)


type alias Model =
    {}


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


toPx : Float -> String
toPx x =
    (toString x) ++ "px"


moresimple : String
moresimple =
    "MORESIMPLE"


lesssimple : String
lesssimple =
    "LESSSIMPLE"


viewGrid : Html msg
viewGrid =
    svg [ viewBox "0 0 802 482" ]
        [ g [ transform "translate(1, 0)" ]
            (List.range 0 40
                |> List.map
                    (\v ->
                        line
                            [ v * 20 |> toString |> x1
                            , y1 "0"
                            , v * 20 |> toString |> x2
                            , y2 "480"
                            , stroke "#F8F8EB"
                            , stroke "#E7EFF2"
                            , strokeWidth "1"
                            ]
                            []
                    )
            )
        , g [ transform "translate(0, 1)" ]
            (List.range 0 24
                |> List.map
                    (\v ->
                        line
                            [ v * 20 |> toString |> y1
                            , x1 "0"
                            , v * 20 |> toString |> y2
                            , x2 "800"
                            , stroke "#f1f1f1"
                            , strokeWidth "1"
                            ]
                            []
                    )
            )
        ]


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "width", "800px" )
            , ( "position", "relative" )
            , ( "height", "480px" )
            , ( "background-color", "#FFF" )
            , ( "border", "2px solid #000" )
            ]
        ]
        [ div
            [ style
                [ ( "position", "absolute" )
                , ( "top", "0px" )
                , ( "bottom", "0px" )
                , ( "left", "0px" )
                , ( "right", "0px" )
                ]
            ]
            [ viewGrid
            ]
        , div
            [ style
                [ ( "width", "160px" )
                , ( "height", "160px" )
                , ( "border", "2px solid #000" )
                , ( "border-radius", "50%" )
                , ( "position", "absolute" )
                , ( "top", "80px" )
                , ( "left", "140px" )
                ]
            ]
            [ div []
                (List.range 1 10
                    |> List.map
                        (\i ->
                            let
                                angle =
                                    -pi * 1.1 + 0.3 * 2 * pi * k

                                k =
                                    (i - 1 |> toFloat) / 9

                                x =
                                    (angle |> cos) * 95 + 80

                                y =
                                    (angle |> sin) * 95 + 80
                            in
                                div
                                    [ style
                                        [ ( "position", "absolute" )
                                        , ( "top", toPx y )
                                        , ( "left", toPx x )
                                        , ( "transform", "translate3d(-50%, -50%, 0) rotate(" ++ (toString (angle + pi / 2)) ++ "rad)" )
                                        , ( "opacity", "1" )
                                        ]
                                    ]
                                    [ Html.text (moresimple |> String.slice (i - 1) i) ]
                        )
                )
            ]
        , div []
            (List.range 1 10
                |> List.map
                    (\i_ ->
                        let
                            i =
                                toFloat i_
                        in
                            div
                                [ style
                                    [ ( "position", "absolute" )
                                    , ( "left", (i * 45 + 80) |> toPx )
                                    , ( "bottom", (i * i * 4.45 + i * -36 + 120) |> toPx )
                                    , ( "width", (50 + i * 12) |> toPx )
                                    , ( "height", (50 + i * 12) |> toPx )
                                    , ( "border-radius", "6px" )
                                    , ( "box-sizing", "border-box" )
                                    , ( "border", "2px solid #000" )
                                    , ( "padding", "10px" )
                                    ]
                                ]
                                [ span
                                    [ style
                                        [ ( "position", "absolute" )
                                        , ( "right", "8px" )
                                        , ( "bottom", "5px" )
                                        , ( "opacity", "1" )
                                        ]
                                    ]
                                    [ Html.text (lesssimple |> String.slice (i_ - 1) (i_ + 0)) ]
                                ]
                    )
            )
        ]


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
