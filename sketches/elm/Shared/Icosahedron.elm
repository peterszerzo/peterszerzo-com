module Shared.Icosahedron exposing (Vertex, icosahedron, mesh, subdivide)

import Math.Vector3 as Vector3 exposing (Vec3, vec3)
import WebGL


mesh : Int -> WebGL.Mesh Vertex
mesh divisions =
    List.map
        rawTriangleToVertexTriangle
        (List.map (subdivide divisions) icosahedron |> List.foldl (++) [])
        |> WebGL.triangles


type alias Vertex =
    { normal : Vec3
    , center : Vec3
    , polarCenter : Vec3
    , position : Vec3
    , polar : Vec3
    }


rawTriangleToVertexTriangle : ( Vec3, Vec3, Vec3 ) -> ( Vertex, Vertex, Vertex )
rawTriangleToVertexTriangle ( pt1, pt2, pt3 ) =
    let
        center =
            List.foldl Vector3.add (vec3 0 0 0) [ pt1, pt2, pt3 ] |> Vector3.scale (1.0 / 3.0)

        normal =
            Vector3.cross (Vector3.sub pt2 pt1) (Vector3.sub pt3 pt1) |> Vector3.normalize
    in
    ( { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt1
      , position = pt1
      }
    , { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt2
      , position = pt2
      }
    , { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt3
      , position = pt3
      }
    )


{-| vec3 x y z -> vec3 radius theta phi
-}
toPolar : Vec3 -> Vec3
toPolar v =
    let
        r =
            Vector3.length v

        vNorm =
            Vector3.scale (1 / r) v

        theta =
            Basics.toPolar ( Vector3.getX v, Vector3.getY v ) |> Tuple.second

        phi =
            Vector3.dot vNorm (vec3 0 0 1) |> acos |> (\angle -> pi / 2 - angle)
    in
    vec3 r theta phi


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
