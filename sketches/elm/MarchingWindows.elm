module MarchingWindows exposing (main)

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

float doubleCircleSigmoid (float x, float a) {
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 

  float y = 0.0;
  if (x<=a){
    y = a - sqrt(a * a - x * x);
  } else {
    y = a + sqrt((1.0 - a)*(1.0 - a) - (x - 1.0)*(x - 1.0));
  }
  return y;
}

void main() {
  vec2 st = gl_FragCoord.xy / resolution.xy;

  const float units = 15.0;

  float workTime = time + 1000.0;

  float r = 0.5 + 0.5 * sin(st.x * units + workTime / 2000.0) * sin(st.y * units - workTime / 10000.0);
  float b = 0.5 + 0.5 * sin(st.x * units + workTime / 10000.0) * sin(st.y * units - workTime / 2000.0);

  r = doubleCircleSigmoid(r, 0.5);
  b = doubleCircleSigmoid(b, 0.5);

  gl_FragColor = vec4(r, mix(r, b, 0.5 + 0.5 * sin(time / 1000.0)), b, 1.0);
}
|]
