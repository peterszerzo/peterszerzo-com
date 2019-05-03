module Concepts.Icosahedron exposing (icosahedron, subdivide)

import Math.Vector3 as Vector3 exposing (Vec3, vec3)


subdivide : Int -> ( Vec3, Vec3, Vec3 ) -> List ( Vec3, Vec3, Vec3 )
subdivide no ( pt1, pt2, pt3 ) =
    case no of
        0 ->
            [ ( pt1, pt2, pt3 ) ]

        _ ->
            let
                r =
                    Vector3.length pt1

                m12_ =
                    Vector3.add pt1 pt2 |> Vector3.scale 0.5

                m23_ =
                    Vector3.add pt2 pt3 |> Vector3.scale 0.5

                m31_ =
                    Vector3.add pt3 pt1 |> Vector3.scale 0.5

                m12 =
                    Vector3.scale (r / Vector3.length m12_) m12_

                m23 =
                    Vector3.scale (r / Vector3.length m23_) m23_

                m31 =
                    Vector3.scale (r / Vector3.length m31_) m31_
            in
            [ subdivide (no - 1) ( pt1, m12, m31 )
            , subdivide (no - 1) ( m12, pt2, m23 )
            , subdivide (no - 1) ( m12, m23, m31 )
            , subdivide (no - 1) ( m31, m23, pt3 )
            ]
                |> List.foldl (++) []


icosahedron : List ( Vec3, Vec3, Vec3 )
icosahedron =
    [ ( vec3 -1.0 0.0 -1.618
      , vec3 -1.618 -1.0 0.0
      , vec3 -1.618 1.0 0.0
      )
    , ( vec3 -1.0 0.0 -1.618
      , vec3 -1.618 1.0 0.0
      , vec3 0.0 1.618 -1.0
      )
    , ( vec3 -1.0 0.0 -1.618
      , vec3 0.0 1.618 -1.0
      , vec3 1.0 0.0 -1.618
      )
    , ( vec3 -1.0 0.0 -1.618
      , vec3 0.0 -1.618 -1.0
      , vec3 1.0 0.0 -1.618
      )
    , ( vec3 -1.0 0.0 -1.618
      , vec3 -1.618 -1.0 0.0
      , vec3 0.0 -1.618 -1.0
      )
    , ( vec3 0.0 -1.618 -1.0
      , vec3 1.0 0.0 -1.618
      , vec3 1.618 -1.0 0.0
      )
    , ( vec3 1.0 0.0 -1.618
      , vec3 0.0 1.618 -1.0
      , vec3 1.618 1.0 0.0
      )
    , ( vec3 1.618 -1.0 0.0
      , vec3 1.0 0.0 -1.618
      , vec3 1.618 1.0 0.0
      )
    , ( vec3 0.0 1.618 -1.0
      , vec3 -1.618 1.0 0.0
      , vec3 0.0 1.618 1.0
      )
    , ( vec3 1.618 1.0 0.0
      , vec3 0.0 1.618 -1.0
      , vec3 0.0 1.618 1.0
      )
    , ( vec3 1.618 1.0 0.0
      , vec3 0.0 1.618 1.0
      , vec3 1.0 0.0 1.618
      )
    , ( vec3 1.618 -1.0 0.0
      , vec3 1.618 1.0 0.0
      , vec3 1.0 0.0 1.618
      )
    , ( vec3 0.0 -1.618 -1.0
      , vec3 1.618 -1.0 0.0
      , vec3 0.0 -1.618 1.0
      )
    , ( vec3 0.0 -1.618 1.0
      , vec3 1.618 -1.0 0.0
      , vec3 1.0 0.0 1.618
      )
    , ( vec3 -1.618 -1.0 0.0
      , vec3 0.0 -1.618 -1.0
      , vec3 0.0 -1.618 1.0
      )
    , ( vec3 -1.0 0.0 1.618
      , vec3 -1.618 -1.0 0.0
      , vec3 0.0 -1.618 1.0
      )
    , ( vec3 -1.618 1.0 0.0
      , vec3 -1.618 -1.0 0.0
      , vec3 -1.0 0.0 1.618
      )
    , ( vec3 0.0 1.618 1.0
      , vec3 -1.618 1.0 0.0
      , vec3 -1.0 0.0 1.618
      )
    , ( vec3 1.0 0.0 1.618
      , vec3 0.0 1.618 1.0
      , vec3 -1.0 0.0 1.618
      )
    , ( vec3 -1.0 0.0 1.618
      , vec3 0.0 -1.618 1.0
      , vec3 1.0 0.0 1.618
      )
    ]
