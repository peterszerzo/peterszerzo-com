module Views.Background exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class, style)
import Constants
import Svg exposing (svg)
import Svg.Attributes exposing (viewBox, points, width, height, transform)
import Models exposing (Model)
import Models.AppTime as AppTime
import Messages exposing (Msg)
import Views.Background.Styles exposing (CssClasses(..), localClass)


floatRem : Float -> Float -> Float
floatRem a b =
    ((a / b) - (a / b |> floor |> toFloat)) * b


type alias Polygon =
    { coordinates : List ( Float, Float )
    , opacities : ( Float, Float )
    }


view : Model -> Html Msg
view model =
    let
        timeSinceStart =
            AppTime.sinceStart model.time

        timeRem =
            floatRem timeSinceStart Constants.transitionEvery

        isOdd =
            (timeSinceStart / Constants.transitionEvery |> floor) % 2 == 1

        transitionFactor =
            (if (timeRem > Constants.transitionFor) then
                1.0
             else
                timeRem / Constants.transitionFor
            )
                |> (\f ->
                        if isOdd then
                            1 - f
                        else
                            f
                   )

        expand =
            if (model.window.width < 800) then
                240
            else
                20

        size =
            (max model.window.width model.window.height) + 2 * expand

        top =
            (toFloat (size - model.window.height)) / 2

        left =
            (toFloat (size - model.window.width)) / 2

        isTop =
            model.window.width > model.window.height

        scale =
            (toFloat size) / 100
    in
        div
            [ localClass [ Root ]
            , style
                [ ( "top", "-" ++ (toString top) ++ "px" )
                , ( "left", "-" ++ (toString left) ++ "px" )
                ]
            ]
            [ svg
                [ viewBox "0 0 100 100"
                , width (toString size)
                , height (toString size)
                ]
                (List.indexedMap
                    (\index polygon_ ->
                        let
                            ( opacity1, opacity2 ) =
                                polygon_.opacities

                            opacity_ =
                                transitionFactor * opacity1 + (1 - transitionFactor) * opacity2
                        in
                            Svg.polygon
                                [ style [ ( "opacity", opacity_ |> toString ) ]
                                , points
                                    (polygon_.coordinates
                                        |> List.map (\( x, y ) -> (toString x) ++ "," ++ (toString (100 - y)))
                                        |> String.join " "
                                    )
                                ]
                                []
                    )
                    polygons
                )
            ]


polygons : List Polygon
polygons =
    [ { coordinates =
            [ ( 24.56, 50.52 )
            , ( 28.67, 50.92 )
            , ( 46.53, 72.32 )
            , ( 60.66, 61.27 )
            , ( 74.35, 62.62 )
            , ( 75.09, 55.01 )
            , ( 52.24, 27.02 )
            , ( 24.56, 50.52 )
            ]
      , opacities = ( 0, 0 )
      }
    , { coordinates =
            [ ( -0.0, 53.4 )
            , ( 18.98, 55.26 )
            , ( 24.56, 50.52 )
            , ( 28.67, 50.92 )
            , ( 46.53, 72.32 )
            , ( 38.19, 78.85 )
            , ( 36.11, 100.0 )
            , ( 0.0, 100.0 )
            , ( -0.0, 53.4 )
            ]
      , opacities = ( 0.05, 0.15 )
      }
    , { coordinates =
            [ ( 100.0, 66.97 )
            , ( 76.15, 64.63 )
            , ( 74.35, 62.62 )
            , ( 75.09, 55.01 )
            , ( 52.24, 27.02 )
            , ( 54.86, 0.0 )
            , ( 100.0, 0.0 )
            , ( 100.0, 66.97 )
            ]
      , opacities = ( 0.045, 0.16 )
      }
    , { coordinates =
            [ ( -0.0, 53.4 )
            , ( 18.98, 55.26 )
            , ( 52.24, 27.02 )
            , ( 54.86, 0.0 )
            , ( 0.0, 0.0 )
            , ( -0.0, 53.4 )
            ]
      , opacities = ( 0.12, 0.055 )
      }
    , { coordinates =
            [ ( 36.11, 100.0 )
            , ( 100.0, 100.0 )
            , ( 100.0, 66.97 )
            , ( 76.15, 64.63 )
            , ( 74.35, 62.62 )
            , ( 60.66, 61.27 )
            , ( 38.19, 78.85 )
            , ( 36.11, 100.0 )
            ]
      , opacities = ( 0.135, 0.0425 )
      }
    ]
