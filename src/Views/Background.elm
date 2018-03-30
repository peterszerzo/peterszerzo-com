module Views.Background exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class, style, width, height)
import Math.Vector2 exposing (Vec2, vec2)
import WebGL
import Window
import Time


type alias Vertex =
    { position : Vec2
    }


type alias Uniforms =
    { resolution : Vec2
    , time : Float
    , horizontal : Bool
    , mobile : Bool
    }


type alias Varyings =
    {}


type alias Polygon =
    { coordinates : List ( Float, Float )
    , opacities : ( Float, Float )
    }


floatRem : Float -> Float -> Float
floatRem a b =
    ((a / b) - (a / b |> floor |> toFloat)) * b


view : Window.Size -> Time.Time -> Html msg
view window timeSinceStart =
    let
        expand =
            if (window.width < 800) then
                100
            else
                0

        size =
            (max window.width window.height) + 2 * expand

        top =
            (toFloat (size - window.height)) / 2

        left =
            (toFloat (size - window.width)) / 2

        isTop =
            window.width > window.height

        scale =
            (toFloat size) / 100
    in
        WebGL.toHtml
            [ width size
            , height size
            , style
                [ ( "top", "-" ++ (toString top) ++ "px" )
                , ( "left", "-" ++ (toString left) ++ "px" )
                , ( "z-index", "1" )
                , ( "position", "absolute" )
                ]
            ]
            [ WebGL.entity vertexShader
                fragmentShader
                mesh
                { resolution = vec2 (toFloat size) (toFloat size)
                , time = timeSinceStart / 1000
                , horizontal = window.width > window.height
                , mobile = window.width < 600
                }
            ]


mesh : WebGL.Mesh Vertex
mesh =
    [ ( vec2 -1.0 -1.0 |> Vertex, vec2 1.0 -1.0 |> Vertex, vec2 -1.0 1.0 |> Vertex )
    , ( vec2 -1.0 1.0 |> Vertex, vec2 1.0 -1.0 |> Vertex, vec2 1.0 1.0 |> Vertex )
    ]
        |> WebGL.triangles


vertexShader : WebGL.Shader Vertex Uniforms Varyings
vertexShader =
    [glsl|
attribute vec2 position;

void main() {
  gl_Position = vec4(position, 0.0, 1.0);
}
|]


fragmentShader : WebGL.Shader {} Uniforms Varyings
fragmentShader =
    [glsl|
precision mediump float;

uniform vec2 resolution;
uniform float time;

float rand(float x) {
  return fract(sin(x) * 43758.5453123);
}

float perlin(float x) {
  float i = floor(x);  // integer
  float f = fract(x);  // fraction
  return mix(rand(i), rand(i + 1.0), smoothstep(0.,1.,f));
}

const float pi = 3.14159265358979323;

void main() {
  vec2 st = gl_FragCoord.xy / resolution.xy;

  vec2 stc = st * 10.0;
  vec2 ipos = floor(stc);
  vec2 fpos = fract(stc);

  vec2 fromCenter = st - vec2(0.5, 0.5);
  float d = length(fromCenter);

  float dot = dot(fromCenter / d, vec2(1.0, 0.0));

  float angle = acos(dot);

  if (fromCenter.y < 0.0) {
    angle = 2.0 * pi - acos(dot);
  } else {
    angle = acos(dot);
  }

  float randomArgument = sin(8.0 * angle / pi + time / 6.0);

  if (d < 0.22 + 0.12 * perlin(randomArgument)) {
    discard;
  } else {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.04);
  }
}
|]
