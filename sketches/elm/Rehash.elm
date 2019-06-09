module Rehash exposing (main)

import Browser
import Browser.Events as Events
import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import Shared.Setup as Setup
import Shared.SimpleWebGL as SimpleWebGL
import Time
import WebGL


main : Program Encode.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    Setup.Model {}


type Msg
    = Tick Time.Posix
    | Animate Bool


init : Encode.Value -> ( Model, Cmd Msg )
init flagsValue =
    let
        flags =
            Setup.unsafeDecodeFlags flagsValue
    in
    ( { time = Nothing
      , startTime = Nothing
      , isAnimating = flags.animating
      , size = flags.size
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate isAnimating ->
            ( { model | isAnimating = isAnimating }
            , Cmd.none
            )

        Tick time ->
            ( { model
                | startTime =
                    if model.startTime == Nothing then
                        Just time

                    else
                        model.startTime
                , time = Just time
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ if model.isAnimating then
            Events.onAnimationFrame Tick

          else
            Sub.none
        , Setup.animate
            (\value ->
                Decode.decodeValue Decode.bool value
                    |> Result.withDefault False
                    |> Animate
            )
        ]


view : Model -> Html Msg
view model =
    SimpleWebGL.view
        { fragmentShader = fragmentShader
        , window = { width = floor model.size, height = floor model.size }
        , attrs = []
        , makeUniforms =
            \resolution ->
                { time = Setup.playhead model
                , resolution = resolution
                }
        }


fragmentShader : WebGL.Shader {} (SimpleWebGL.Uniforms {}) SimpleWebGL.Varyings
fragmentShader =
    [glsl|
precision mediump float;

uniform vec2 resolution;
uniform float time;

float random(float x) {
  return fract(sin(x * 100.00) * 100000.);
}

float random( vec2 st ) {
  return fract(sin(dot(sin(st.x * 100.0),cos(st.y * 100.0))) * 10000.00);
}

mat2 rotate(float angle) {
  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

void main() {
  float workTime = time * 0.00006;
  vec2 st = gl_FragCoord.xy / resolution.xy;
  vec2 mSt = vec2(0.0, 0.0) / resolution;

  st -= 0.5;
  st *= rotate(-workTime);
  st *= 0.5 + 0.5 * abs(sin(workTime * 0.5));
  st += 0.5;
  
  const int COUNT = 3;

  vec3 points[COUNT];    

  points[0] = vec3(0.35,0.5,0.04);
  points[1] = vec3(0.5,0.5,0.1);
  points[2] = vec3(0.65,0.5,0.04);

  points[0] += vec3(-1.0, +1.0, 0) * (0.05 + 0.00 * sin(workTime));
  points[2] += vec3(+1.0, -1.0, 0) * (0.05 + 0.00 * sin(workTime));

  float power = 1.6 + .2 * sin(workTime);

  float d = 1.0;
  vec3 p = points[0];

  for(int i = 0; i < COUNT; i++) {
    float dist = 0.0;
    vec3 point = points[i];

    dist = pow(
      pow(abs(st.x - point.x), power) +
      pow(abs(st.y - point.y), power)
    , 1.0 / power);

    dist -= point.z;

    if(d >= dist) {
      d = dist;
      p = points[i];
    }
  }

  d = pow(d, length(st - vec2(0.5)));
  d = sin(d * 16.0 + workTime * 40.0);
  d = smoothstep(0.0, 1.0, d);

  vec3 color1 = vec3(49.0, 76.0, 182.0) / 255.0;
  vec3 color2 = vec3(140.0, 26.0, 140.0) / 255.0;

  vec3 color = mix(color1, color2, 0.5 + 0.5 * cos(workTime + 3.14159));

  vec3 bgColor = vec3(0.0, 0.0, 0.0);

  gl_FragColor = mix(vec4(color, 1.0), vec4(bgColor, 1.0), 1.0 - d);
}
|]
