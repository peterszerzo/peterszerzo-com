module Views.Background exposing (..)

import Html exposing (Html, div)
import Svg exposing (svg)
import Svg.Attributes exposing (viewBox, points)
import Html.Attributes exposing (class, style)
import Color exposing (rgba)
import Collage exposing (group, polygon, filled, collage)
import Element exposing (toHtml)
import Models exposing (Model)
import Messages exposing (Msg)


transformPt : Float -> ( Float, Float ) -> ( Float, Float )
transformPt scale ( x, y ) =
    ( (x - 50) * scale, (y - 50) * scale )


opacity : Int -> Int -> Float
opacity index ticks =
    if index == 0 then
        0
    else
        0.06 + 0.02 * (sin ((toFloat (ticks + 525 * index)) / 300))


polygons : Float -> Int -> List Collage.Form
polygons scale animationTicks =
    if scale == 0 then
        []
    else
        p
            |> List.indexedMap
                (\i ->
                    ((filled (rgba 255 255 255 (opacity i animationTicks)))
                        << polygon
                        << List.map (transformPt scale)
                    )
                )


svgView : List (List ( Float, Float )) -> Html Msg
svgView polygons =
    svg
        [ viewBox "0 0 100 100"
        ]
        (List.map
            (\pts ->
                Svg.polygon
                    [ points
                        (pts
                            |> List.map (\( x, y ) -> (toString x) ++ "," ++ (toString y))
                            |> String.join " "
                        )
                    ]
                    []
            )
            polygons
        )


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
            [ class "bg"
            , style
                [ ( "top", "-" ++ (toString top) ++ "px" )
                , ( "left", "-" ++ (toString left) ++ "px" )
                ]
            ]
            [ Element.toHtml (collage size size (polygons scale model.animationTicks))
            , svgView p
            ]


p : List (List ( Float, Float ))
p =
    [ [ ( 24.56, 50.52 )
      , ( 28.67, 50.92 )
      , ( 46.53, 72.32 )
      , ( 60.66, 61.27 )
      , ( 74.35, 62.62 )
      , ( 75.09, 55.01 )
      , ( 52.24, 27.02 )
      , ( 24.56, 50.52 )
      ]
    , [ ( -0.0, 53.4 )
      , ( 18.98, 55.26 )
      , ( 24.56, 50.52 )
      , ( 28.67, 50.92 )
      , ( 46.53, 72.32 )
      , ( 38.19, 78.85 )
      , ( 36.11, 100.0 )
      , ( 0.0, 100.0 )
      , ( -0.0, 53.4 )
      ]
    , [ ( -0.0, 53.4 )
      , ( 18.98, 55.26 )
      , ( 52.24, 27.02 )
      , ( 54.86, 0.0 )
      , ( 0.0, 0.0 )
      , ( -0.0, 53.4 )
      ]
    , [ ( 36.11, 100.0 )
      , ( 100.0, 100.0 )
      , ( 100.0, 66.97 )
      , ( 76.15, 64.63 )
      , ( 74.35, 62.62 )
      , ( 60.66, 61.27 )
      , ( 38.19, 78.85 )
      , ( 36.11, 100.0 )
      ]
    , [ ( 100.0, 66.97 )
      , ( 76.15, 64.63 )
      , ( 74.35, 62.62 )
      , ( 75.09, 55.01 )
      , ( 52.24, 27.02 )
      , ( 54.86, 0.0 )
      , ( 100.0, 0.0 )
      , ( 100.0, 66.97 )
      ]
    ]
