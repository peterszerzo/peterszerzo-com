module Shared.SimpleWebGL exposing (Config, Uniforms, Varyings, Vertex, mesh, vertexShader, view)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (style)
import Math.Vector2 as Vector2 exposing (Vec2, vec2)
import String.Future
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

        top =
            if window.width > window.height then
                (toFloat window.height - toFloat window.width) / 2

            else
                0

        left =
            if window.height > window.width then
                (toFloat window.width - toFloat window.height) / 2

            else
                0
    in
    WebGL.toHtml
        ([ Html.Attributes.width size
         , Html.Attributes.height size
         , style "top" <| String.Future.fromFloat top ++ "px"
         , style "left" <| String.Future.fromFloat left ++ "px"
         , style "z-index" <| "1"
         , style "position" <| "absolute"
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
