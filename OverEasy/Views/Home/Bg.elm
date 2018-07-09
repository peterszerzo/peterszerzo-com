module Views.Home.Bg exposing (..)

import Html.Styled exposing (Html, fromUnstyled)
import Time
import WebGL
import Window
import Concepts.SimpleWebGL as SimpleWebGL


view : Window.Size -> Time.Time -> Html msg
view window time =
    SimpleWebGL.view
        { fragmentShader = fragmentShader
        , window = window
        , styles =
            if window.width < 600 then
                [ ( "transform", "scale(1.25)" ) ]
            else
                []
        , makeUniforms =
            \resolution ->
                { time = time
                , resolution = resolution
                }
        }
        |> fromUnstyled


fragmentShader : WebGL.Shader {} (SimpleWebGL.Uniforms {}) SimpleWebGL.Varyings
fragmentShader =
    [glsl|
precision highp float;
uniform vec2 resolution;
uniform float time;

float polarAngle(vec2 pt) {
  if (length(pt) < 0.001) {
    return 0.0;
  }
  float cos = dot(pt / length(pt), vec2(1.0, 0.0));
  float angle = acos(cos);
  if (pt.y < 0.0) {
    return 2.0 * 3.14159 - angle;
  }
  return angle;
}

void main() {
  vec2 st = gl_FragCoord.xy / resolution.xy;
  st.x *= resolution.x / resolution.y;
  vec2 coord = st - vec2(0.5, 0.5);
  float angle = polarAngle(coord);
  vec4 color;
  float wave1 = 0.030 * sin(5.0 * angle - time * 0.00012);
  float wave2 = 0.007 * sin(2.0 * angle - time * 0.0006);
  float wave3 = 0.035 * sin(5.0 * angle + 3.14159 / 2.25 - time * 0.00012);
  float wave4 = 0.012 * sin(3.0 * angle + time * 0.0003);
  if (length(coord) < 0.36 + wave1 + wave2) {
    color = vec4(0.0, 0.0, 0.0, 0.0);
  } else if (length(coord) < 0.38 + wave3 + wave4) {
    color = vec4(0.0, 0.0, 0.0, 0.32);
  } else {
    color = vec4(0.0, 0.0, 0.0, 1.0);
  }
  gl_FragColor = color;
}
|]
