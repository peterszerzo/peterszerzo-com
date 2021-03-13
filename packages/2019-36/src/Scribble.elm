module Scribble exposing
    ( Scribble
    , generator
    , view
    )

import Constants as Constants
import Html exposing (Html)
import Random
import Svg exposing (g, path, svg)
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
        )


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
    path
        [ d <|
            "M10,"
                ++ String.fromFloat (toFloat index * 14 + 10 + modifyOffset index -1 time)
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
        , strokeWidth "3"
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


view :
    { time : Float
    , scribble : Scribble
    , redLines : List Int
    , scale : Float
    }
    -> Html msg
view config =
    svg
        [ (160 * config.scale) |> String.fromFloat |> width
        , (240 * config.scale) |> String.fromFloat |> height
        , viewBox "0 0 160 240"
        ]
        (config.scribble.offsets
            |> List.indexedMap
                (\index offsets ->
                    single index config.time (List.member index config.redLines) offsets
                )
        )
