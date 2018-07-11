module Site.Ui.Background exposing (..)

import Html exposing (Html, Attribute, div)
import Math.Vector2 exposing (Vec2, vec2)
import WebGL
import Window
import Time
import OverEasy.Concepts.SimpleWebGL as SimpleWebGL


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


view : Window.Size -> Time.Time -> Html msg
view window timeSinceStart =
    SimpleWebGL.view
        { window = window
        , styles = []
        , makeUniforms =
            (\resolution ->
                { resolution = resolution
                , time = timeSinceStart / 2000
                , horizontal = window.width > window.height
                , mobile = window.width < 600
                }
            )
        , fragmentShader = fragmentShader
        }


fragmentShader : WebGL.Shader {} Uniforms Varyings
fragmentShader =
    [glsl|
precision mediump float;

uniform vec2 resolution;
uniform float time;

float rand(float x) {
  return fract(sin(x) * 4378.5453);
}

float perlin(float x) {
  float i = floor(x);  // integer
  float f = fract(x);  // fraction
  return mix(rand(i), rand(i + 1.0), smoothstep(0.0, 1.0, f));
}

const float n = 26.0;

float gridFloor(float x) {
  return floor(n * x) / n + 0.5 / n;
}

const float pi = 3.1415926535897;
const float rotateAngle = 0.3 * pi;
const mat2 rotate = mat2(cos(rotateAngle), sin(rotateAngle), -sin(rotateAngle), cos(rotateAngle));

void main() {

  vec2 st_original = (gl_FragCoord.xy / resolution.xy - vec2(0.5, 0.5)) * rotate + vec2(0.5, 0.5);

  vec2 st = vec2(gridFloor(st_original.x), gridFloor(st_original.y));

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

  float randomArgument = sin(6.0 * angle / pi + 0.8 * time);

  float maxDistance = 0.22 + 0.18 * perlin(randomArgument);

  if (d < maxDistance) {
    discard;
  } else if (d < maxDistance + 0.08) {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.12 * (d - maxDistance) / 0.08);
  } else {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.12);
  }
}
|]
