module OverEasy.Pieces.BureaucracyIsDistracting.Scribble exposing (Scribble, generator, modifyOffset, single, view)

import Html exposing (Html, text)
import OverEasy.Pieces.BureaucracyIsDistracting.Constants as Constants
import Random
import Svg exposing (g, line, path, rect, svg)
import Svg.Attributes
    exposing
        ( d
        , fill
        , height
        , stroke
        , strokeLinecap
        , strokeLinejoin
        , strokeWidth
        , viewBox
        , width
        , x
        , x1
        , x2
        , y
        , y1
        , y2
        )
import Time


type alias Scribble =
    { offsets : List (List Float)
    }


generator : Random.Generator Scribble
generator =
    Random.float 1.5 2.8
        |> Random.list 8
        |> Random.map2
            (\rem offsets ->
                List.indexedMap
                    (\index no ->
                        if modBy 2 index == rem then
                            -no

                        else
                            no
                    )
                    offsets
            )
            (Random.int 0 1)
        |> Random.list 10
        |> Random.map
            (\offsets ->
                Scribble offsets
            )


modifyOffset : Int -> Int -> Float -> Float
modifyOffset rowIndex columnIndex time =
    sin (time / 240 + toFloat columnIndex * 3.5 * pi + toFloat rowIndex * 0.3)
        * (if modBy 3 columnIndex == 0 then
            0.6

           else
            0.4
          )


single : Int -> Float -> Bool -> List Float -> Html msg
single index time isRed offsets =
    let
        startY =
            toFloat index * 14 + 10
    in
    path
        [ d <|
            "M10,"
                ++ String.fromFloat startY
                ++ (offsets
                        |> List.indexedMap
                            (\columnIndex offset ->
                                let
                                    modifiedOffset =
                                        modifyOffset index columnIndex time
                                            + offset
                                in
                                "c5,4,10,-5,15,"
                                    ++ String.fromFloat modifiedOffset
                            )
                        |> String.join ""
                   )
        , fill "none"
        , strokeWidth "2px"
        , stroke
            (if isRed then
                Constants.red

             else
                "#000"
            )
        , strokeLinecap "round"
        , strokeLinejoin "round"
        ]
        []


view : Float -> Scribble -> List Int -> Html msg
view time scribble reds =
    svg [ width "160", height "240", viewBox "0 0 160 240" ]
        [ g []
            (scribble.offsets
                |> List.indexedMap
                    (\index offsets ->
                        single index time (List.member index reds) offsets
                    )
            )
        ]
