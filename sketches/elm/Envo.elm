module Envo exposing (main)

import Browser
import Browser.Events as Events
import Html
import Html.Attributes
import Json.Decode as Decode
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector2 as Vector2
import Math.Vector3 as Vector3
import Shared.Setup as Setup
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


floatRange : Int -> List Float
floatRange n =
    List.range 0 n |> List.map (\i -> toFloat i / toFloat n)


grid2 : Int -> Int -> List ( Float, Float )
grid2 n m =
    floatRange n
        |> List.map
            (\kn ->
                floatRange m
                    |> List.map (\km -> ( kn, km ))
            )
        |> List.foldl (++) []


meshes : List (WebGL.Mesh Vertex)
meshes =
    let
        n : Int
        n =
            4

        nf : Float
        nf =
            toFloat n
    in
    grid2 4 4
        |> List.map
            (\( kx, ky ) ->
                ( kx * nf * 1.12 - nf / 2, ky * nf * 1.12 - nf / 2, 0 )
            )
        |> List.indexedMap
            (\index ( x, y, z ) ->
                quad x y z
                    |> List.map
                        (toVertex
                            index
                        )
                    |> WebGL.triangleStrip
            )


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
        (meshes
            |> List.map
                (\mesh ->
                    WebGL.entity
                        vertexShader
                        fragmentShader
                        mesh
                        { perspective = perspective_
                        , transform = Matrix4.identity
                        , time = time
                        , opacity = 1
                        }
                )
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


perspective : Float -> Matrix4.Mat4
perspective time =
    let
        theta =
            pi * 0

        phi =
            pi * 0.5

        base =
            Vector3.vec3 0 0 0

        eye =
            Vector3.vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale 4
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
    , vPanel : Float
    }


vertexShader : WebGL.Shader Vertex Uniforms Varyings
vertexShader =
    [glsl|
attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;
attribute float panel;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying float brightness;
varying vec2 vUv;
varying float vPanel;
const vec3 lightDirection = vec3(0.0, 0.0, 1.0);
void main () {
  gl_Position = (perspective * transform) * vec4(0.8 * position + vec3(0.0, 0.0, 0.0), 1.0);
  brightness = 1.0 + (1.0 - dot(
    normalize(vec3(lightDirection)),
    normalize((transform * vec4(normal, 1.0)).xyz)
  ));
  vPanel = panel;
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
varying float vPanel;

void main() {
  const float units = 3.0;

  float workTime = time + 1000.0;

  float sineFactor = sin(workTime / 1000.0 + vPanel * 0.2);

  float angle = vPanel * (1.2) + 0.25 * sineFactor;
  mat2 rotationMatrix = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));

  vec2 workVUv = (vUv - 0.5) * rotationMatrix + 0.5;

  vec3 color1 = vec3(79.0, 76.0, 219.0) / 255.0;
  vec3 color2 = vec3(23.0, 26.0, 33.0) / 255.0;

  float threshold = 0.2 + 0.1 * sineFactor;
  float blur = 1.0 + 0.02 * sin(vUv.x * 101.5);

  float r = workVUv.x + workVUv.y;

  float k = smoothstep(threshold, threshold + blur, workVUv.x + workVUv.y);

  gl_FragColor = vec4(mix(color1, color2, k), 1.0);
}
|]



-- Mesh


type alias Vertex =
    { position : Vector3.Vec3
    , normal : Vector3.Vec3
    , uv : Vector2.Vec2
    , panel : Float
    }


type alias VertexGeometry =
    { position : ( Float, Float, Float )
    , normal : ( Float, Float, Float )
    , uv : ( Float, Float )
    }


toVertex : Int -> VertexGeometry -> Vertex
toVertex index geo =
    { position = tupleToVec3 geo.position
    , normal = tupleToVec3 geo.normal
    , uv = tupleToVec2 geo.uv
    , panel = toFloat (3 * index)
    }


tupleToVec3 : ( Float, Float, Float ) -> Vector3.Vec3
tupleToVec3 ( x, y, z ) =
    Vector3.vec3 x y z


tupleToVec2 : ( Float, Float ) -> Vector2.Vec2
tupleToVec2 ( x, y ) =
    Vector2.vec2 x y


quad : Float -> Float -> Float -> List VertexGeometry
quad x0 y0 z0 =
    List.range 0 3
        |> List.map
            (\index ->
                let
                    x =
                        index
                            // 2
                            |> toFloat
                            |> (\x_ -> x_ - 0.5)

                    y =
                        if modBy 2 index == 0 then
                            -0.5

                        else
                            0.5

                    z =
                        0

                    u =
                        index // 2 |> toFloat

                    v =
                        if modBy 2 index == 0 then
                            1

                        else
                            0
                in
                { position = ( x + x0, y + y0, z + z0 )
                , normal = ( 0, 0, 1 )
                , uv = ( u, v )
                }
            )
