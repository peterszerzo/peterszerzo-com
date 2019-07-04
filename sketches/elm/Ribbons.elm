module Ribbons exposing (main)

import Browser
import Browser.Events as Events
import Html
import Html.Attributes
import Json.Decode as Decode
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector2 as Vector2
import Math.Vector3 as Vector3
import Math.Vector4 as Vector4
import Shared.Glsllike as Glsllike
import Shared.Palette as Palette
import Shared.Setup as Setup
import Shared.Strip as Strip
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
    = Setup Setup.Msg


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
        Setup setupMsg ->
            ( Setup.update setupMsg model
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Setup.subscriptions model
        |> Sub.map Setup


palette : Palette.Palette
palette =
    Palette.palette
        (Vector3.vec3 72 97 117)
        [ Vector3.vec3 72 97 117
        , Vector3.vec3 255 164 0
        , Vector3.vec3 72 97 117
        , Vector3.vec3 0 130 206
        , Vector3.vec3 72 97 117
        , Vector3.vec3 48 21 114
        ]


view : Model -> Html.Html msg
view model =
    let
        time =
            Setup.playhead model
                * 0.75

        perspective_ =
            perspective time
    in
    WebGL.toHtml
        [ Html.Attributes.width (floor model.size)
        , Html.Attributes.height (floor model.size)
        ]
    <|
        [ WebGL.entity
            vertexShader
            fragmentShader
            Strip.mesh
            { perspective = perspective_
            , transform = Matrix4.identity
            , time = time
            , opacity = 1
            }
        ]


perspective : Float -> Matrix4.Mat4
perspective time =
    let
        theta =
            pi * -0.25

        phi =
            pi * 0.25

        base =
            Vector3.vec3 0.6 0.8 0.9

        eye =
            Vector3.vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale 0.2
                |> Vector3.add base
    in
    Matrix4.mul (Matrix4.makePerspective 45 1 0.01 100)
        (Matrix4.makeLookAt eye base (Vector3.vec3 0 0 1))


type alias Uniforms =
    { transform : Matrix4.Mat4
    , perspective : Matrix4.Mat4
    , time : Float
    , opacity : Float
    }


type alias Varyings =
    { brightness : Float
    , vUv : Vector2.Vec2
    }


vertexShader : WebGL.Shader Strip.Vertex Uniforms Varyings
vertexShader =
    [glsl|
attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying float brightness;
varying vec2 vUv;
const vec3 lightDirection = vec3(0.0, 0.0, 1.0);
void main () {
  gl_Position = (perspective * transform) * vec4(0.8 * position + vec3(0.0, 0.0, 0.0), 1.0);
  brightness = 1.0 + (1.0 - dot(
    normalize(vec3(lightDirection)),
    normalize((transform * vec4(normal, 1.0)).xyz)
  ));
  vUv = uv;
}
|]


fragmentShader : WebGL.Shader {} Uniforms Varyings
fragmentShader =
    [glsl|
precision highp float;

uniform float time;
varying vec2 vUv;
varying float brightness;

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
  const float units = 15.0;

  float workTime = time + 1000.0;

  float r = 0.5 + 0.5 * sin(vUv.x * units + workTime / 2000.0) * sin(vUv.y * units - workTime / 10000.0);
  float b = 0.5 + 0.5 * sin(vUv.x * units + workTime / 10000.0) * sin(vUv.y * units - workTime / 2000.0);

  r = doubleCircleSigmoid(r, 0.5);
  b = doubleCircleSigmoid(b, 0.5);

  gl_FragColor = vec4(r, mix(r, b, 0.5 + 0.5 * sin(workTime / 1000.0)), b, 1.0);
}
|]
