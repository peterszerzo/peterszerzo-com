port module WalkWithMe exposing (Model, Msg(..), init, subscriptions, update, view)

import Browser
import Browser.Events as Events
import Concepts.SimpleWebGL as SimpleWebGL
import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (style)
import Json.Decode as Decode
import Json.Encode as Encode
import Time
import WebGL


port animate : (Encode.Value -> msg) -> Sub msg


main : Program Encode.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { time : Maybe Time.Posix
    , startTime : Maybe Time.Posix
    , isAnimating : Bool
    }


type Msg
    = Tick Time.Posix
    | Animate Bool


timeDiff : Model -> Float
timeDiff model =
    case ( model.time, model.startTime ) of
        ( Just time, Just startTime ) ->
            Time.posixToMillis time
                - Time.posixToMillis startTime
                |> toFloat

        ( _, _ ) ->
            0


init : Encode.Value -> ( Model, Cmd Msg )
init _ =
    ( { time = Nothing
      , startTime = Nothing
      , isAnimating = False
      }
    , Cmd.none
    )


w : Float
w =
    320


h : Float
h =
    320


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
        , animate
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
        , window = { width = floor w, height = floor h }
        , attrs = []
        , makeUniforms =
            \resolution ->
                { time = timeDiff model
                , resolution = resolution
                }
        }


fragmentShader : WebGL.Shader {} (SimpleWebGL.Uniforms {}) SimpleWebGL.Varyings
fragmentShader =
    [glsl|
precision mediump float;

uniform vec2 resolution;
uniform float time;

const float pi = 3.14159265;
const float n = 38.0;
const vec2 center1 = vec2(0.5, 0.38);
const vec2 center2 = vec2(0.5, 0.62);
const vec3 color1 = vec3(91.0 / 255.0, 95.0 / 255.0, 151.0 / 255.0);
const vec3 color2 = vec3(219.0 / 255.0, 84.0 / 255.0, 97.0 / 255.0);
const float transitionEvery = 4000.0;
const float transitionFor = 1500.0;
const float rotateAngle = 0.333 * pi;

const mat2 rotate = mat2(cos(rotateAngle), sin(rotateAngle), -sin(rotateAngle), cos(rotateAngle));

float rand(float x) {
  return fract(sin(x) * 4378.541);
}

float perlin(float x) {
  float i = floor(x);
  float f = fract(x);
  return mix(rand(i), rand(i + 1.0), smoothstep(0.0, 1.0, f));
}

// Snaps a coordinate to the edges of an n-by-n grid, returning ( newX, gridLine ) where
//   - newX is the grid coordinate
//   - gridLine is the index of the grid
// E.g. if n = 4, pixelate(0.3) == vec2 ( 0.25, 1.0 )
vec2 pixelate(float x) {
  return vec2(floor(n * x) / n + 0.5 / n, floor(n * x));
}

float easeInOut(float t) {
  if (t < 0.5) {
    return 2.0 * t * t;
  }
  return (4.0 - 2.0 * t) * t - 1.0;
}

vec4 getColor(vec2 st, vec2 center, vec3 color) {
  vec2 fromCenter = st - center;
  float d = length(fromCenter);
  float dotProduct = dot(fromCenter / d, vec2(1.0, 0.0));
  float angle = acos(dotProduct);
  if (fromCenter.y < 0.0) {
    angle = 2.0 * pi - angle;
  }
  float randomArgument = sin(4.0 * angle / pi + 0.8 * time / 2000.0);
  float maxDistance = 0.30 + 0.18 * perlin(randomArgument);
  float fullDistance = maxDistance - 0.15;
  if (d >= maxDistance) {
    return vec4(color, 0.0);
  } else if (d > fullDistance) {
    return vec4(color, 1.0 - (d - fullDistance) / (maxDistance - fullDistance));
  } else {
    return vec4(color, 1.0);
  }
}

vec4 addColors(vec4 color1, vec4 color2) {
  float a = 1.0 - (1.0 - color1.a) * (1.0 - color2.a);
  if (a < 0.001) {
    return vec4(0.0, 0.0, 0.0, 0.0);
  }
  float r = color1.r * color1.a / a + color2.r * color2.a * (1.0 - color1.a) / a;
  float g = color1.g * color1.a / a + color2.g * color2.a * (1.0 - color1.a) / a;
  float b = color1.b * color1.a / a + color2.b * color2.a * (1.0 - color1.a) / a;
  return vec4(r, g, b, a);
}

vec4 pickColor(bool isFirst, vec4 color1, vec4 color2) {
  if (isFirst) {
    return color1;
  }
  return color2;
}

void main() {
  const float blendsCount = 8.0;

  float workTime = 2000.0 + time;

  float transitionType = mod(workTime / transitionEvery, blendsCount);

  float transitionRatio = easeInOut(smoothstep(0.0, transitionFor, mod(workTime, transitionEvery)));

  vec2 fragmentPoint = (gl_FragCoord.xy / resolution.xy - vec2(0.5, 0.5)) * 1.3 * rotate + vec2(0.5, 0.5);

  vec2 infoX = pixelate(fragmentPoint.x);
  vec2 infoY = pixelate(fragmentPoint.y);

  vec2 pixelatedFragmentPoint = vec2(infoX.x, infoY.x);

  float iX = infoX.y;
  float iY = infoY.y;

  vec4 computedColor1 = getColor(pixelatedFragmentPoint, center1, color1);
  vec4 computedColor2 = getColor(pixelatedFragmentPoint, center2, color2);

  vec4 colorBlend1 = computedColor1 - computedColor2;
  vec4 colorBlend2 = addColors(computedColor2, computedColor1);
  vec4 colorBlend3 = pickColor(mod(iX + iY, 2.0) == 0.0, computedColor1, computedColor2);
  vec4 colorBlend4 = computedColor1 * computedColor2;
  vec4 colorBlend5 = computedColor2;
  vec4 colorBlend6 = computedColor2 - computedColor1;
  vec4 colorBlend7 = computedColor1;
  vec4 colorBlend8 = addColors(computedColor1, computedColor2);

  if (transitionType > 7.0) {
    gl_FragColor = mix(colorBlend2, colorBlend1, transitionRatio);
  } else if (transitionType > 6.0) {
    gl_FragColor = mix(colorBlend3, colorBlend2, transitionRatio);
  } else if (transitionType > 5.0) {
    gl_FragColor = mix(colorBlend4, colorBlend3, transitionRatio);
  } else if (transitionType > 4.0) {
    gl_FragColor = mix(colorBlend5, colorBlend4, transitionRatio);
  } else if (transitionType > 3.0) {
    gl_FragColor = mix(colorBlend6, colorBlend5, transitionRatio);
  } else if (transitionType > 2.0) {
    gl_FragColor = mix(colorBlend7, colorBlend6, transitionRatio);
  } else if (transitionType > 1.0) {
    gl_FragColor = mix(colorBlend8, colorBlend7, transitionRatio);
  } else {
    gl_FragColor = mix(colorBlend1, colorBlend8, transitionRatio);
  }
}
|]
