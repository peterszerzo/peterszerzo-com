module Views.Background exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class, style)
import Svg exposing (svg)
import Svg.Attributes exposing (viewBox, points, width, height, transform)
import Models exposing (Model)
import Messages exposing (Msg)
import Views.Background.Styles exposing (CssClasses(..), localClass)


type alias Polygon =
    { coordinates : List ( Float, Float )
    , opacities : ( Float, Float )
    }


view : Model -> Html Msg
view model =
    let
        expand =
            if (model.window.width < 800) then
                200
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
                                model.transitionFactor * opacity1 + (1 - model.transitionFactor) * opacity2
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
      , opacities = ( 0.04, 0.11 )
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
      , opacities = ( 0.035, 0.09 )
      }
    , { coordinates =
            [ ( -0.0, 53.4 )
            , ( 18.98, 55.26 )
            , ( 52.24, 27.02 )
            , ( 54.86, 0.0 )
            , ( 0.0, 0.0 )
            , ( -0.0, 53.4 )
            ]
      , opacities = ( 0.08, 0.035 )
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
      , opacities = ( 0.11, 0.0325 )
      }
    ]
