module Today.Helpers exposing (getClipPath)


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


getClipPath : Float -> String
getClipPath ratio =
    let
        clipPathCoordinates =
            if ratio < 0.5 then
                [ [ 0, ratio * 2 ]
                , [ ratio * 2, 0 ]
                , [ 1, 0 ]
                , [ 1, 1 ]
                , [ 0, 1 ]
                , [ 0, ratio * 2 ]
                ]
            else
                [ [ 1, ratio * 2 - 1 ]
                , [ 1, 1 ]
                , [ ratio * 2 - 1, 1 ]
                ]
    in
        clipPathCoordinates
            |> List.map pointToString
            |> List.intersperse ", "
            |> List.foldr (++) ""
