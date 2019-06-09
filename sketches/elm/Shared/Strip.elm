module Shared.Strip exposing (Vertex, mesh)

import Math.Vector2 as Vector2
import Math.Vector3 as Vector3
import WebGL


mesh : WebGL.Mesh Vertex
mesh =
    triangleStripPoints
        |> List.map toVertex
        |> WebGL.triangleStrip


type alias VertexGeometry =
    { position : ( Float, Float, Float )
    , normal : ( Float, Float, Float )
    , uv : ( Float, Float )
    }


toVertex : VertexGeometry -> Vertex
toVertex geo =
    { position = tupleToVec3 geo.position
    , normal = tupleToVec3 geo.normal
    , uv = tupleToVec2 geo.uv
    }


tupleToVec3 : ( Float, Float, Float ) -> Vector3.Vec3
tupleToVec3 ( x, y, z ) =
    Vector3.vec3 x y z


tupleToVec2 : ( Float, Float ) -> Vector2.Vec2
tupleToVec2 ( x, y ) =
    Vector2.vec2 x y


triangleStripPoints : List VertexGeometry
triangleStripPoints =
    List.range 0 100
        |> List.map
            (\index ->
                let
                    fract =
                        0.08

                    x =
                        index // 2 |> toFloat |> (*) fract

                    y =
                        if modBy 2 index == 0 then
                            -0.5

                        else
                            0.5

                    z =
                        0.05
                            * sin (toFloat index * fract)
                            + 0.15
                            * sin
                                (toFloat index
                                    * fract
                                    * 2
                                    + (if modBy 2 index == 0 then
                                        0.5

                                       else
                                        0
                                      )
                                )

                    u =
                        index // 2 |> toFloat |> (*) fract

                    v =
                        if modBy 2 index == 0 then
                            1

                        else
                            0
                in
                { position = ( x, y, z )
                , normal = ( 0, 0, 1 )
                , uv = ( u, v )
                }
            )


type alias Vertex =
    { position : Vector3.Vec3
    , normal : Vector3.Vec3
    , uv : Vector2.Vec2
    }
