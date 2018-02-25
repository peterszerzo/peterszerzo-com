module Views.Background exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class, style, width, height)
import Data.State exposing (State)
import Data.AppTime as AppTime
import Math.Vector2 exposing (Vec2, vec2)
import WebGL


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


view : State -> Html msg
view model =
    let
        timeSinceStart =
            AppTime.sinceStart model.time

        expand =
            if (model.window.width < 800) then
                100
            else
                0

        size =
            (max model.window.width model.window.height) + 2 * expand

        top =
            (toFloat (size - model.window.height)) / 2

        left =
            (toFloat (size - model.window.width)) / 2

        isTop =
            model.window.width > model.window.height

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
                , time = timeSinceStart
                , horizontal = model.window.width > model.window.height
                , mobile = model.window.width < 600
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
precision highp float;

uniform vec2 resolution;
uniform float time;
uniform bool horizontal;
uniform bool mobile;

const float transition_every = 8000.0;
const float transition_for = 1500.0;

void main() {
  vec2 st = gl_FragCoord.xy / resolution.xy;
  st.x *= resolution.x / resolution.y;

  if (!horizontal) {
    st = vec2(st.y, st.x);
  }

  const float rotateAngle = 0.0;
  const mat2 rotate = mat2(cos(rotateAngle), -sin(rotateAngle), sin(rotateAngle), cos(rotateAngle));

  bool is_odd_transition = fract(time / transition_every / 2.0) < 0.5;
  float transition_ratio = smoothstep(0.0, transition_for, mod(time, transition_every));
  if (is_odd_transition) {
    transition_ratio = 1.0 - transition_ratio;
  }

  // Cell positions
  vec2 point[5];
  float sinTime = sin(0.3 * time / 1000.0);
  float cosTime = cos(0.3 * time / 1000.0);
  float d = mobile ? 0.035 : 0.025;
  point[0] = vec2(0.15, 0.25) + vec2(d * sinTime, d * cosTime);
  point[1] = vec2(0.1, 0.9) + vec2(d * cosTime, d * sinTime);
  point[2] = vec2(0.8, 0.75) + vec2(d * sinTime, d * cosTime);
  point[3] = vec2(0.9, 0.15) + vec2(d * cosTime, d * sinTime);
  point[4] = vec2(0.5, 0.5);

  // Cell colors
  float b = 0.8;
  vec4 base_color = vec4(45.0 / 255.0 * b, 81.0 / 255.0 * b, 135.0 / 255.0 * b, 1.0);
  vec4 colors[5];
  float r1 = 0.07 - transition_ratio * 0.05;
  float r2 = 0.03 + transition_ratio * 0.05;
  colors[0] = base_color + r1 * vec4(1.0, 1.0, 1.0, 0.0);
  colors[1] = base_color + r2 * vec4(1.0, 1.0, 1.0, 0.0);
  colors[2] = base_color + r1 * vec4(1.0, 1.0, 1.0, 0.0);
  colors[3] = base_color + r2 * vec4(1.0, 1.0, 1.0, 0.0);
  colors[4] = base_color;

  float min_dist = 1000.0;
  vec4 min_color;

  for (int i = 0; i < 5; i++) {
    vec2 diff = rotate * (st - point[i]);
    float dist = abs(diff.x) + abs(diff.y);
    if (dist < min_dist) {
      min_dist = dist;
      min_color = colors[i];
    }
  }

  gl_FragColor = min_color;
}
|]
