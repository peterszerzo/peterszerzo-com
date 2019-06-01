module OurBearingsAreFragile exposing (main)

import Browser
import Browser.Events as Events
import Html exposing (Html, div)
import Html.Attributes exposing (class, height, width)
import Json.Decode as Decode
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3 exposing (Vec3, vec3)
import Math.Vector4 as Vector4 exposing (Vec4, vec4)
import Random
import Shared.Icosahedron as Icosahedron
import Shared.Setup as Setup
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, transform, viewBox)
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
    let
        zoom =
            12
    in
    WebGL.toHtmlWith
        [ WebGL.alpha True
        , WebGL.depth 1
        , WebGL.antialias
        ]
        [ width (floor model.size)
        , height (floor model.size)
        ]
        [ globeEntity (Setup.playhead model)
        ]



-- Icosahedron


type alias Uniforms =
    { time : Float
    , perspective : Matrix4.Mat4
    }


type alias Varyings =
    { brightness : Float
    , baseColor : Vec4
    , shouldRender : Float
    }


globeEntity : Float -> WebGL.Entity
globeEntity time =
    WebGL.entity vertexShader
        fragmentShader
        mesh
        { perspective = globePerspective time
        , time = time
        }


floatRem : Float -> Float -> Float
floatRem a b =
    ((a / b) - (a / b |> floor |> toFloat)) * b


type alias Polygon =
    { coordinates : List ( Float, Float )
    , opacities : ( Float, Float )
    }


globePerspective : Float -> Matrix4.Mat4
globePerspective time =
    let
        sineTime =
            sin (time / 1800)

        theta =
            -pi / 3 + pi / 40 * sineTime

        phi =
            0.47 * pi - 0.02 * pi * sineTime

        eye =
            vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale 3.75
    in
    Matrix4.mul (Matrix4.makePerspective 45 1 0.01 100)
        (Matrix4.makeLookAt eye (vec3 0 0 1.2) (vec3 0 0 1))


mesh : WebGL.Mesh Icosahedron.Vertex
mesh =
    Icosahedron.mesh 5


vertexShader : WebGL.Shader Icosahedron.Vertex Uniforms Varyings
vertexShader =
    [glsl|
precision mediump float;

attribute vec3 position;
attribute vec3 polarCenter;
attribute vec3 center;
attribute vec3 normal;
attribute vec3 polar;

uniform mat4 perspective;
uniform float time;
varying float brightness;
varying vec4 baseColor;
varying float shouldRender;

float getSplitRatio(float radius, float breakRadius1, float breakRadius2) {
  if (radius > breakRadius2) {
    return 0.0;
  }
  if (radius > breakRadius1) {
    return pow((breakRadius2 - radius) / (breakRadius2 - breakRadius1), 2.0);
  }
  return 1.0;
}

float getColorRatio(float radius, float breakRadius1, float breakRadius2) {
  if (radius > breakRadius2) {
    return 0.0;
  }
  return (breakRadius2 - radius) / breakRadius2;
}

void main() {
  float pi = 3.14159265359;

  float radius = distance(center, vec3(0.0, 0.0, 1.89));

  float thetaCenter = polarCenter.y;

  float breakRadius1 = 
    0.4 + 
    0.08 * (sin(thetaCenter * 3.0 - time / 1800.0)) + 
    0.03 * (sin(thetaCenter * 5.0 + 0.3 + time / 1800.0));

  float breakRadius2 = breakRadius1 + 0.2 + 0.01 * (sin(thetaCenter * 0.3 + time / 1800.0));

  float splitRatio = getSplitRatio(radius, breakRadius1, breakRadius2);

  shouldRender = splitRatio > 0.01 ? 1.0 : 0.0;

  float colorRatio = getColorRatio(radius, breakRadius1, breakRadius2);

  vec3 newPosition = center + (position - center) * splitRatio;

  vec4 color1 = vec4(
    37.0 / 255.0,
    57.0 / 255.0,
    119.0 / 255.0,
    1.0
  );

  vec4 color2 = vec4(
    76.0 / 255.0,
    93.0 / 255.0,
    143.0 / 255.0,
    1.0
  );

  baseColor = mix(color1, color2, colorRatio);

  brightness = 1.0 + (1.0 - dot(
    normalize(vec3(0.3, -0.4, 1)),
    normalize(vec3(normal))
  ));

  gl_Position = perspective * vec4(newPosition, 1.0);
}
|]


fragmentShader : WebGL.Shader {} Uniforms Varyings
fragmentShader =
    [glsl|
precision mediump float;

uniform float time;
varying float brightness;
varying vec4 baseColor;
varying float shouldRender;

void main() {
  float luminosity = 0.21 * baseColor.r + 0.72 * baseColor.g + 0.07 * baseColor.b;
  if (shouldRender < 0.01) {
    discard;
  }
  gl_FragColor = vec4(
    luminosity * brightness,
    luminosity * brightness,
    luminosity * brightness,
    1.0
  );
  gl_FragColor = baseColor * brightness;
}
|]
