module Views.Background exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Color exposing (rgba)
import Collage exposing (group, polygon, filled, collage)
import Element exposing (toHtml)
import Models exposing (Model)
import Messages exposing (Msg)


polygons : Float -> List Collage.Form
polygons scale =
    [ [ ( 0, 0 ), ( 68, 0 ), ( 85, 103 ), ( 102, 116 ), ( 114, 200 ), ( 0, 200 ) ]
        |> List.map (\( x, y ) -> ( x * scale, y * scale ))
        |> Debug.log "1"
        |> polygon
        |> filled (rgba 255 255 255 0.03)
    , [ ( 68, 0 ), ( 85, 103 ), ( 102, 116 ), ( 136, 78 ), ( 200, 63 ), ( 200, 0 ) ]
        |> List.map (\( x, y ) -> ( x * scale, y * scale ))
        |> Debug.log "2"
        |> polygon
        |> filled (rgba 255 255 255 0.05)
    , [ ( 114, 200 ), ( 102, 116 ), ( 85, 103 ), ( 136, 78 ), ( 200, 63 ), ( 200, 200 ) ]
        |> List.map (\( x, y ) -> ( x * scale, y * scale ))
        |> Debug.log "3"
        |> polygon
        |> filled (rgba 255 255 255 0.01)
    ]


view : Model -> Html Msg
view model =
    let
        size =
            max model.window.width model.window.height

        scale =
            (toFloat size) / 200
    in
        div [ class "bg" ]
            [ Element.toHtml (collage size size (polygons scale))
            ]
