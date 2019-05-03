module Concepts.SimpleWebGL exposing (Config, Uniforms, Varyings, Vertex, view)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (style)
import Math.Vector2 exposing (Vec2, vec2)
import WebGL


type alias Vertex =
    { position : Vec2
    }


type alias Varyings =
    {}


type alias Uniforms a =
    { a
        | resolution : Vec2
        , time : Float
    }


type alias Config a msg =
    { window : { width : Int, height : Int }
    , attrs : List (Attribute msg)
    , makeUniforms : Vec2 -> Uniforms a
    , fragmentShader : WebGL.Shader {} (Uniforms a) Varyings
    }


view : Config a msg -> Html msg
view { window, makeUniforms, fragmentShader, attrs } =
    let
        size =
            max window.width window.height
    in
    WebGL.toHtml
        ([ Html.Attributes.width size
         , Html.Attributes.height size
         ]
            ++ attrs
        )
        [ WebGL.entity vertexShader
            fragmentShader
            mesh
            (makeUniforms <|
                vec2 (toFloat size) (toFloat size)
            )
        ]


mesh : WebGL.Mesh Vertex
mesh =
    [ ( vec2 -1.0 -1.0 |> Vertex, vec2 1.0 -1.0 |> Vertex, vec2 -1.0 1.0 |> Vertex )
    , ( vec2 -1.0 1.0 |> Vertex, vec2 1.0 -1.0 |> Vertex, vec2 1.0 1.0 |> Vertex )
    ]
        |> WebGL.triangles


vertexShader : WebGL.Shader Vertex (Uniforms a) Varyings
vertexShader =
    [glsl|
attribute vec2 position;
void main() {
  gl_Position = vec4(position, 0.0, 1.0);
}
|]
