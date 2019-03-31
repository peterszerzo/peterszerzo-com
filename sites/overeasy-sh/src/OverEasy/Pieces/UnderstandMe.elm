module OverEasy.Pieces.UnderstandMe exposing (Model, Msg(..), init, subscriptions, update, view)

import Browser.Events as Events
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (style)
import Random
import Svg exposing (line, path, svg)
import Svg.Attributes exposing (d, fill, height, opacity, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox, width, x1, x2, y1, y2)
import Time


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
    { time : Maybe Time.Posix
    , startTime : Maybe Time.Posix
    , lines : List Line
    }


type Msg
    = Tick Time.Posix
    | GenerateLines (List LineGeneratorData)


timeDiff : Model -> Float
timeDiff model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0


init : ( Model, Cmd Msg )
init =
    ( { time = Nothing
      , startTime = Nothing
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
                    if model.startTime == Nothing then
                        Just time

                    else
                        model.startTime
                , time = Just time
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
        [ Events.onAnimationFrame Tick
        ]


svgPtPair : Float -> Float -> String
svgPtPair x y =
    (x |> floor |> String.fromInt) ++ "," ++ (y |> floor |> String.fromInt)


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


lineValue : Float -> Line -> Float
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
        [ style "width" "800px"
        , style "height" "480px"
        , style "overflow" "hidden"
        , style "background-color" "#1A2A44"
        , style "position" "relative"
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
                            lineValue (timeDiff model) lineData
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
                               , (lineData.opacity + (1 - lineData.opacity) * val) |> String.fromFloat |> opacity
                               ]
                        )
                        []
                )
                model.lines
        ]
