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
    ( (x - 50) * scale, -(y - 50) * scale )


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
                50

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
    [ [ ( 22.92, 55.09 )
      , ( 27.51, 55.09 )
      , ( 49.58, 76.82 )
      , ( 64.01, 63.07 )
      , ( 79.29, 63.07 )
      , ( 79.29, 54.58 )
      , ( 50.98, 26.11 )
      , ( 22.92, 55.09 )
      ]
    , [ ( 0.0, 60.94 )
      , ( 17.26, 60.94 )
      , ( 50.98, 26.11 )
      , ( 50.98, 0.0 )
      , ( 0.0, 0.0 )
      , ( 0.0, 60.94 )
      ]
    , [ ( 100.0, 65.11 )
      , ( 81.49, 65.11 )
      , ( 79.29, 63.07 )
      , ( 79.29, 54.58 )
      , ( 50.98, 26.11 )
      , ( 50.98, 0.0 )
      , ( 100.0, 0.0 )
      , ( 100.0, 65.11 )
      ]
    , [ ( 0.0, 60.94 )
      , ( 17.26, 60.94 )
      , ( 22.92, 55.09 )
      , ( 27.51, 55.09 )
      , ( 49.58, 76.82 )
      , ( 41.06, 84.94 )
      , ( 41.06, 100.0 )
      , ( 0.0, 100.0 )
      , ( 0.0, 60.94 )
      ]
    , [ ( 41.06, 100.0 )
      , ( 100.0, 100.0 )
      , ( 100.0, 65.11 )
      , ( 81.49, 65.11 )
      , ( 79.29, 63.07 )
      , ( 64.01, 63.07 )
      , ( 41.06, 84.94 )
      , ( 41.06, 100.0 )
      ]
    ]
