module Main exposing (main)

import Browser
import Browser.Events as Events
import Html
import Svg as S
import Svg.Attributes as Sa
import Time



-- Entry point


main : Program () Model Msg
main =
    Browser.element
        { init =
            \_ ->
                ( { appTime = initAppTime
                  }
                , Cmd.none
                )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { appTime : AppTime
    }


type alias AppTime =
    Maybe
        { start : Time.Posix
        , current : Time.Posix
        }


initAppTime : AppTime
initAppTime =
    Nothing


playhead : AppTime -> Float
playhead maybeAppTime =
    case maybeAppTime of
        Nothing ->
            0

        Just appTime ->
            Time.posixToMillis appTime.current
                - Time.posixToMillis appTime.start
                |> toFloat



-- Update


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model
                | appTime =
                    case model.appTime of
                        Just appTime ->
                            Just { appTime | current = newTime }

                        Nothing ->
                            Just { current = newTime, start = newTime }
              }
            , Cmd.none
            )



-- View


view : Model -> Html.Html Msg
view model =
    gridDrawingBlock <| playhead model.appTime


drawPolygon :
    List (S.Attribute msg)
    ->
        { sides : Float
        , size : Float
        , center : ( Float, Float )
        , rotation : Float
        }
    -> Html.Html msg
drawPolygon attrs config =
    let
        ( centerX, centerY ) =
            config.center
    in
    S.path
        ([ polygonf config.rotation config.sides
            |> List.map (\( x, y ) -> String.fromFloat x ++ "," ++ String.fromFloat y)
            |> String.join " L"
            |> (\pts -> "M" ++ pts)
            |> Sa.d
         , Sa.transform <|
            "translate("
                ++ String.fromFloat centerX
                ++ ","
                ++ String.fromFloat centerY
                ++ ") scale("
                ++ String.fromFloat config.size
                ++ ")"
         , Sa.strokeLinecap "round"
         , Sa.strokeLinejoin "round"
         ]
            ++ attrs
        )
        []


{-| Renders the sum of two values controlled through counters, renders to `var1 + var2 == value`
-}
gridDrawingBlock : Float -> Html.Html msg
gridDrawingBlock time =
    S.svg
        [ Sa.viewBox "0 0 1000 1000"
        , Sa.width "800"
        , Sa.height "800"
        ]
        [ let
            n =
                12

            pad =
                80

            basePhase =
                time * 0.001
          in
          unitRange n
            |> List.map (\kx -> List.map (\ky -> ( kx, ky )) (unitRange n))
            |> List.foldl (++) []
            |> List.map
                (\( kx, ky ) ->
                    let
                        phase =
                            kx * 1.5 + ky * 1.5 + 1.5 * kx * ky + basePhase
                    in
                    drawPolygon
                        [ Sa.strokeWidth "0"
                        , Sa.fill "#111"
                        ]
                        { center =
                            ( pad + kx * (1000 - 2 * pad)
                            , pad + ky * (1000 - 2 * pad)
                            )
                        , size = 320 / toFloat n
                        , sides = 4 + 1.95 * sin phase
                        , rotation = pi * 0.25 + 0.1 * sin (phase * 6)
                        }
                )
            |> S.g
                []
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onAnimationFrame Tick



-- Geometry


polygon : Float -> Int -> List ( Float, Float )
polygon rotation n =
    List.range 0 n
        |> List.map
            (\i ->
                let
                    angle =
                        2 * pi * toFloat i / toFloat n + rotation
                in
                ( cos angle, sin angle )
            )


polygonf : Float -> Float -> List ( Float, Float )
polygonf rotation nf =
    let
        nfFloor =
            floor nf
    in
    if nf == toFloat nfFloor then
        polygon rotation nfFloor

    else
        let
            nfCeiling =
                ceiling nf

            nfDiff =
                nf - toFloat nfFloor

            range1 =
                unitRangeM nfCeiling

            range2 =
                unitRange (nfCeiling + 1)
        in
        List.map2
            (\k1 k2 ->
                let
                    angle1 =
                        2 * pi * k1 + rotation

                    angle2 =
                        2 * pi * k2 + rotation

                    factor =
                        cos (pi / toFloat nfFloor)
                in
                lerpFloatTuple nfDiff
                    (scaleFloatTuple
                        (if modBy 2 nfFloor == 1 && k1 == 0.5 then
                            factor

                         else
                            1
                        )
                        ( cos angle1
                        , sin angle1
                        )
                    )
                    ( cos angle2
                    , sin angle2
                    )
            )
            range1
            range2


unitRange : Int -> List Float
unitRange n =
    List.range 0 (n - 1)
        |> List.map (\i -> toFloat i / toFloat (n - 1))


unitRangeM : Int -> List Float
unitRangeM n =
    unitRange n
        |> (\lst ->
                let
                    spliceAt =
                        n // 2
                in
                List.take spliceAt lst ++ (0.5 :: List.drop spliceAt lst)
           )


lerpFloatTuple : Float -> ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
lerpFloatTuple k ( x1, y1 ) ( x2, y2 ) =
    ( (1 - k) * x1 + k * x2
    , (1 - k) * y1 + k * y2
    )


scaleFloatTuple : Float -> ( Float, Float ) -> ( Float, Float )
scaleFloatTuple k ( x, y ) =
    ( k * x
    , k * y
    )
