module Today.Helpers exposing (..)


numberToPercentage : Float -> String
numberToPercentage n =
    (toString (n * 100)) ++ "%"


pointToString : List Float -> String
pointToString pt =
    let
        first =
            pt
                |> List.head
                |> Maybe.map numberToPercentage
                |> Maybe.withDefault "0%"

        second =
            pt
                |> List.drop 1
                |> List.head
                |> Maybe.map numberToPercentage
                |> Maybe.withDefault "0%"
    in
        first ++ " " ++ second


gapFactor : Float
gapFactor =
    0.001


offset1 : Float
offset1 =
    0.4


offset2 : Float
offset2 =
    0.2


getStartClipPath : Float -> String
getStartClipPath ratio =
    let
        clipPathCoordinates =
            [ [ 0, 0 ]
            , [ offset1 + (1 - offset1 - offset2) * ratio - gapFactor, 0 ]
            , [ offset2 + (1 - offset1 - offset2) * ratio - gapFactor, 1 ]
            , [ 0, 1 ]
            , [ 0, 0 ]
            ]
    in
        clipPathCoordinates
            |> List.map pointToString
            |> List.intersperse ", "
            |> List.foldr (++) ""


getEndClipPath : Float -> String
getEndClipPath ratio =
    let
        clipPathCoordinates =
            [ [ 1, 0 ]
            , [ offset1 + (1 - offset1 - offset2) * ratio + gapFactor, 0 ]
            , [ offset2 + (1 - offset1 - offset2) * ratio + gapFactor, 1 ]
            , [ 1, 1 ]
            , [ 1, 0 ]
            ]
    in
        clipPathCoordinates
            |> List.map pointToString
            |> List.intersperse ", "
            |> List.foldr (++) ""
