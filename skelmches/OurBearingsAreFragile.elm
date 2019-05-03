port module OurBearingsAreFragile exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Events as Events
import Concepts.Icosahedron as Icosahedron
import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (class, height, style, width)
import Json.Decode as Decode
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3 exposing (Vec3, vec3)
import Math.Vector4 as Vector4 exposing (Vec4, vec4)
import Random
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, transform, viewBox)
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
    let
        zoom =
            12

        top =
            (w - h) / 2 |> min 0
    in
    WebGL.toHtmlWith
        [ WebGL.alpha True
        , WebGL.depth 1
        , WebGL.antialias
        ]
        [ width (floor w)
        , height (floor h)
        ]
        [ globeEntity (timeDiff model)
        ]



-- Icosahedron


type alias Vertex =
    { normal : Vec3
    , center : Vec3
    , polarCenter : Vec3
    , position : Vec3
    , polar : Vec3
    }


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


rawTriangleToVertexTriangle : ( Vec3, Vec3, Vec3 ) -> ( Vertex, Vertex, Vertex )
rawTriangleToVertexTriangle ( pt1, pt2, pt3 ) =
    let
        center =
            List.foldl Vector3.add (vec3 0 0 0) [ pt1, pt2, pt3 ] |> Vector3.scale (1.0 / 3.0)

        normal =
            Vector3.cross (Vector3.sub pt2 pt1) (Vector3.sub pt3 pt1) |> Vector3.normalize
    in
    ( { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt1
      , position = pt1
      }
    , { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt2
      , position = pt2
      }
    , { normal = normal
      , center = center
      , polarCenter = toPolar center
      , polar = toPolar pt3
      , position = pt3
      }
    )


{-| vec3 x y z -> vec3 radius theta phi
-}
toPolar : Vec3 -> Vec3
toPolar v =
    let
        r =
            Vector3.length v

        vNorm =
            Vector3.scale (1 / r) v

        theta =
            Basics.toPolar ( Vector3.getX v, Vector3.getY v ) |> Tuple.second

        phi =
            Vector3.dot vNorm (vec3 0 0 1) |> acos |> (\angle -> pi / 2 - angle)
    in
    vec3 r theta phi


mesh : WebGL.Mesh Vertex
mesh =
    List.map
        rawTriangleToVertexTriangle
        (List.map (Icosahedron.subdivide 5) Icosahedron.icosahedron |> List.foldl (++) [])
        |> WebGL.triangles


vertexShader : WebGL.Shader Vertex Uniforms Varyings
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
