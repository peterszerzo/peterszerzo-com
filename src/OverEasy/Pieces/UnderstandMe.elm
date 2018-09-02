module OverEasy.Pieces.UnderstandMe exposing (..)

import String.Future
import Time
import AnimationFrame
import Html exposing (Html, Attribute, div, program, text)
import Html.Attributes exposing (style)
import Random
import Svg exposing (svg, line, path)
import Svg.Attributes exposing (viewBox, width, height, x1, x2, y1, y2, stroke, strokeWidth, strokeLinecap, strokeLinejoin, opacity, d, fill)


type alias Line =
    { x : Float
    , y : Float
    , len : Float
    , opacity : Float
    }


type alias LineGeneratorData =
    { len : Float
    , opacity : Float
    }


type alias Model =
    { time : Time.Time
    , startTime : Time.Time
    , lines : List Line
    }


type Msg
    = Tick Time.Time
    | GenerateLines (List LineGeneratorData)


init : ( Model, Cmd Msg )
init =
    ( { time = 0
      , startTime = 0
      , lines = []
      }
    , Random.map2 LineGeneratorData (Random.float 0.02 0.1) (Random.float 0.4 1)
        |> Random.list 200
        |> Random.generate GenerateLines
    )


w : Float
w =
    800


h : Float
h =
    480


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model
                | startTime =
                    if model.startTime == 0 then
                        time
                    else
                        model.startTime
                , time = time
              }
            , Cmd.none
            )

        GenerateLines numbers ->
            ( { model
                | lines =
                    numbers
                        |> createLines
              }
            , Cmd.none
            )


createLines : List LineGeneratorData -> List Line
createLines =
    createLinesHelper { x = 0, y = 0, len = 0, opacity = 0 }


createLinesHelper : Line -> List LineGeneratorData -> List Line
createLinesHelper prevLine lineData =
    case lineData of
        [] ->
            []

        lineDatum :: lineDataTail ->
            let
                nextLine =
                    if prevLine.x > 1 then
                        { x = 0
                        , y = prevLine.y + 0.06
                        , len = lineDatum.len
                        , opacity = lineDatum.opacity
                        }
                    else
                        { x = prevLine.x + prevLine.len + 0.028
                        , y = prevLine.y
                        , len = lineDatum.len
                        , opacity = lineDatum.opacity
                        }
            in
                nextLine :: createLinesHelper nextLine lineDataTail


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.times Tick
        ]


svgPtPair : Float -> Float -> String
svgPtPair x y =
    (x |> floor |> String.Future.fromInt) ++ "," ++ (y |> floor |> String.Future.fromInt)


geometryAttrs : Float -> Line -> List (Attribute msg)
geometryAttrs animationFactor lineData =
    let
        x1Coord =
            lineData.x * w

        x2Coord =
            (lineData.x + lineData.len) * w

        y1Coord =
            lineData.y * h

        y2Coord =
            y1Coord

        xmCoord =
            (lineData.x + lineData.len / 2) * w

        ymCoord =
            y1Coord

        x0Coord =
            x1Coord - 10 * animationFactor

        y0Coord =
            y1Coord - 10 * animationFactor

        x3Coord =
            x2Coord + 10 * animationFactor

        y3Coord =
            y2Coord + 10 * animationFactor
    in
        [ d <|
            "M"
                ++ svgPtPair x0Coord y0Coord
                ++ " "
                ++ "C"
                ++ svgPtPair x1Coord y1Coord
                ++ " "
                ++ svgPtPair x1Coord y1Coord
                ++ " "
                ++ svgPtPair xmCoord ymCoord
                ++ " "
                ++ "C"
                ++ svgPtPair x2Coord y2Coord
                ++ " "
                ++ svgPtPair x2Coord y2Coord
                ++ " "
                ++ svgPtPair x3Coord y3Coord
        ]


lineValue : Time.Time -> Line -> Float
lineValue time { x, y, len } =
    let
        timeFactor =
            time / 1000 |> sin

        ( refY1, refY2 ) =
            case
                List.sort
                    [ x * (1 - 0.3 * timeFactor) + 0.2
                    , (1.5 + 0.2 * timeFactor) * x - (0.1 + 0.2 * timeFactor)
                    ]
            of
                v1 :: v2 :: _ ->
                    ( v1, v2 )

                _ ->
                    ( 0, 0 )
    in
        if refY1 == refY2 || y < refY1 || y > refY2 then
            0
        else
            (y - (refY1 + refY2) / 2) / (refY2 - refY1) * 2 |> abs |> (\f -> 1 - f)


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "width", "800px" )
            , ( "height", "480px" )
            , ( "overflow", "hidden" )
            , ( "background-color", "#1A2A44" )
            , ( "position", "relative" )
            ]
        ]
        [ svg
            [ width "800"
            , height "480"
            , viewBox "0 0 800 480"
            ]
          <|
            List.map
                (\lineData ->
                    let
                        val =
                            lineValue (model.time - model.startTime) lineData
                    in
                        path
                            (geometryAttrs
                                val
                                lineData
                                ++ [ stroke "#FFFFFF"
                                   , strokeWidth "8"
                                   , strokeLinecap "round"
                                   , strokeLinejoin "round"
                                   , fill "none"
                                   , (lineData.opacity + (1 - lineData.opacity) * val) |> String.Future.fromFloat |> opacity
                                   ]
                            )
                            []
                )
                model.lines
        ]
