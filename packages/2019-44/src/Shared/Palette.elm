module Shared.Palette exposing (Palette, get, palette)

import Math.Vector3 as Vector3


type alias Palette =
    ( Vector3.Vec3, List Vector3.Vec3 )


palette : Vector3.Vec3 -> List Vector3.Vec3 -> Palette
palette head all =
    ( head, all )


get : Int -> Palette -> Vector3.Vec3
get index ( head, all ) =
    head
        :: all
        |> List.drop index
        |> List.head
        |> Maybe.withDefault head
        |> Vector3.scale (1 / 255)
