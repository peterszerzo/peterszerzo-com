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
            [ [ 0, 0 ]
            , [ 0.3 + 0.6 * ratio, 0 ]
            , [ 0.1 + 0.6 * ratio, 1 ]
            , [ 0, 1 ]
            , [ 0, 0 ]
            ]
    in
        clipPathCoordinates
            |> List.map pointToString
            |> List.intersperse ", "
            |> List.foldr (++) ""
