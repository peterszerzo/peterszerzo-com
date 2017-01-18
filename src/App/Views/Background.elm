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
    ( (x - 100) * scale, -(y - 100) * scale )


polygons : Float -> List Collage.Form
polygons scale =
    if scale == 0 then
        []
    else
        [ [ ( 0, 0 ), ( 68, 0 ), ( 85, 103 ), ( 102, 116 ), ( 114, 200 ), ( 0, 200 ) ]
            |> List.map (transformPt scale)
            |> polygon
            |> filled (rgba 255 255 255 0.02)
        , [ ( 68, 0 ), ( 85, 103 ), ( 102, 116 ), ( 136, 78 ), ( 200, 63 ), ( 200, 0 ) ]
            |> List.map (transformPt scale)
            |> polygon
            |> filled (rgba 255 255 255 0.04)
        , [ ( 114, 200 ), ( 102, 116 ), ( 85, 103 ), ( 136, 78 ), ( 200, 63 ), ( 200, 200 ) ]
            |> List.map (transformPt scale)
            |> polygon
            |> filled (rgba 255 255 255 0)
        ]


view : Model -> Html Msg
view model =
    let
        size =
            max model.window.width model.window.height

        offset =
            (toFloat (model.window.width - model.window.height)) / 2

        scale =
            (toFloat size) / 200 |> Debug.log "scale"
    in
        div [ class "bg", style [ ( "top", "-" ++ (toString offset) ++ "px" ) ] ]
            [ Element.toHtml (collage size size (polygons scale))
            ]
