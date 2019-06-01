module Shared.Glsllike exposing (smoothstep)


smoothstep : Float -> Float -> Float -> Float
smoothstep edge0 edge1 x =
    if x > edge1 then
        1

    else if x > edge0 then
        (x - edge0) / (edge1 - edge0)

    else
        0
