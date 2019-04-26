module OverEasy.Pieces.MoreSimpleLessSimple exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Json.Encode as Encode
import Svg exposing (g, line, svg)
import Svg.Attributes exposing (height, stroke, strokeWidth, transform, viewBox, width, x1, x2, y1, y2)


main : Program Encode.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    {}


type Msg
    = NoOp


init : Encode.Value -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


toPx : Float -> String
toPx x =
    String.fromFloat x ++ "px"


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
                            [ v * 20 |> String.fromInt |> x1
                            , y1 "0"
                            , v * 20 |> String.fromInt |> x2
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
                            [ v * 20 |> String.fromInt |> y1
                            , x1 "0"
                            , v * 20 |> String.fromInt |> y2
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
        [ style "width" "800px"
        , style "position" "relative"
        , style "height" "480px"
        , style "background-color" "#FFF"
        , style "border" "2px solid #000"
        ]
        [ div
            [ style "position" "absolute"
            , style "top" "0px"
            , style "bottom" "0px"
            , style "left" "0px"
            , style "right" "0px"
            ]
            [ viewGrid
            ]
        , div
            [ style "width" "160px"
            , style "height" "160px"
            , style "border" "2px solid #000"
            , style "border-radius" "50%"
            , style "position" "absolute"
            , style "top" "80px"
            , style "left" "140px"
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
                                [ style "position" "absolute"
                                , style "top" (toPx y)
                                , style "left" (toPx x)
                                , style "transform" ("translate3d(-50%, -50%, 0) rotate(" ++ String.fromFloat (angle + pi / 2) ++ "rad)")
                                , style "opacity" "1"
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
                            [ style "position" "absolute"
                            , style "left" ((i * 45 + 80) |> toPx)
                            , style "bottom" ((i * i * 4.45 + i * -36 + 120) |> toPx)
                            , style "width" ((50 + i * 12) |> toPx)
                            , style "height" ((50 + i * 12) |> toPx)
                            , style "border-radius" "6px"
                            , style "box-sizing" "border-box"
                            , style "border" "2px solid #000"
                            , style "padding" "10px"
                            ]
                            [ span
                                [ style "position" "absolute"
                                , style "right" "8px"
                                , style "bottom" "5px"
                                , style "opacity" "1"
                                ]
                                [ Html.text (lesssimple |> String.slice (i_ - 1) (i_ + 0)) ]
                            ]
                    )
            )
        ]
