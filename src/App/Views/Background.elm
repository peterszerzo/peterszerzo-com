module Views.Background exposing (..)

import Html exposing (Html, div)
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
            ]


p : List (List ( Float, Float ))
p =
    [ [ ( 25.3, 47.68 )
      , ( 29.4, 48.09 )
      , ( 47.26, 69.49 )
      , ( 61.4, 58.44 )
      , ( 75.08, 59.78 )
      , ( 75.83, 52.18 )
      , ( 52.98, 24.18 )
      , ( 25.3, 47.68 )
      ]
    , [ ( 100.0, 64.07 )
      , ( 76.88, 61.8 )
      , ( 75.08, 59.78 )
      , ( 75.83, 52.18 )
      , ( 52.98, 24.18 )
      , ( 55.32, 0.0 )
      , ( 100.0, 0.0 )
      , ( 100.0, 64.07 )
      ]
    , [ ( -0.0, 50.49 )
      , ( 19.71, 52.42 )
      , ( 52.98, 24.18 )
      , ( 55.32, 0.0 )
      , ( 0.0, 0.0 )
      , ( -0.0, 50.49 )
      ]
    , [ ( 36.57, 100.0 )
      , ( 100.0, 100.0 )
      , ( 100.0, 64.07 )
      , ( 76.88, 61.8 )
      , ( 75.08, 59.78 )
      , ( 61.4, 58.44 )
      , ( 38.92, 76.01 )
      , ( 36.57, 100.0 )
      ]
    , [ ( -0.0, 50.49 )
      , ( 19.71, 52.42 )
      , ( 25.3, 47.68 )
      , ( 29.4, 48.09 )
      , ( 47.26, 69.49 )
      , ( 38.92, 76.01 )
      , ( 36.57, 100.0 )
      , ( 0.0, 100.0 )
      , ( -0.0, 50.49 )
      ]
    ]
