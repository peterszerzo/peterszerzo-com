module Main exposing (main)

import Browser
import Html
import Html.Attributes
import Html.Events
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector2 as Vector2
import Math.Vector3 as Vector3
import Setup
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
    Setup.Model
        { shader : Int
        }


type Msg
    = Setup Setup.Msg
    | ChangeShader


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
      , shader = 0
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

        ChangeShader ->
            ( { model | shader = model.shader + 1 }
            , Cmd.none
            )


grid : Int -> List ( Float, Float )
grid n =
    List.range 0 n
        |> List.map
            (\kn ->
                List.range 0 n
                    |> List.map (\km -> ( toFloat kn - toFloat n / 2, toFloat km - toFloat n / 2 ))
            )
        |> List.foldl (++) []


meshes : List (WebGL.Mesh Vertex)
meshes =
    grid 10
        |> List.map
            (\( kx, ky ) ->
                quad
                    |> List.map
                        (toVertex kx ky)
                    |> WebGL.triangleStrip
            )


view : Model -> Html.Html Msg
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
        , Html.Events.onClick ChangeShader
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
    Setup.subscriptions model
        |> Sub.map Setup


perspective : Float -> Matrix4.Mat4
perspective _ =
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
                |> Vector3.scale 15
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
    , vKx : Float
    , vKy : Float
    }


vertexShader : WebGL.Shader Vertex Uniforms Varyings
vertexShader =
    [glsl|
attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;
attribute float kx;
attribute float ky;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying float brightness;
varying vec2 vUv;
varying float vKx;
varying float vKy;
const vec3 lightDirection = vec3(0.0, 0.0, -1.0);

mat4 rotationMatrix(vec3 axis, float angle) {
  axis = normalize(axis);
  float s = sin(angle);
  float c = cos(angle);
  float oc = 1.0 - c;
   
  return mat4(
    oc * axis.x * axis.x + c, oc * axis.x * axis.y - axis.z * s, oc * axis.z * axis.x + axis.y * s, 0.0,
    oc * axis.x * axis.y + axis.z * s, oc * axis.y * axis.y + c, oc * axis.y * axis.z - axis.x * s, 0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c, 0.0,
    0.0, 0.0, 0.0, 1.0
  );
}

void main () {
  float gutter = 0.0;

  mat4 translate = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    kx * (1.0 + gutter), ky * (1.0 + gutter), 0.0, 1.0
  );

  float rotateFact1 = (mod(3.0 * kx + 7.0 * ky, 5.0) - 2.0) / 2.0 * sin(time * 0.001 + (0.3 * kx + 0.8 * ky));
  float rotateFact2 = (mod(11.0 * kx + 9.0 * ky, 6.0) - 2.5) / 2.5 * sin(time * 0.001 + (0.9 * kx - 0.2 * ky));

  mat4 rotate1 = rotationMatrix(vec3(1.0, 0.0, 0.0), 0.62 * rotateFact1);
  mat4 rotate2 = rotationMatrix(vec3(0.0, 1.0, 0.0), 0.66 * rotateFact2);

  mat4 totalTransform = perspective * transform * translate * rotate1 * rotate2;

  gl_Position = totalTransform * vec4(position, 1.0);
  brightness = 0.7 - 0.3 * dot(
    normalize(vec3(lightDirection)),
    normalize((totalTransform * vec4(normal, 1.0)).xyz)
  );
  vKx = kx;
  vKy = ky;
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
varying float vKx;
varying float vKy;

const vec3 blue = vec3(79.0, 76.0, 219.0) / 255.0;
const vec3 red = vec3(178.0, 26.0, 41.0) / 255.0;
const vec3 black = vec3(23.0, 26.0, 33.0) / 255.0;
const vec3 lightGray = vec3(240.0) / 255.0;

void main() {
  float factor = smoothstep(0.0, 1.0, 0.2 * (0.4 * vKx - 0.4 * vKy + 2.0));
  gl_FragColor = vec4(mix(black, lightGray, factor), 1.0);
}
|]



-- Mesh


type alias Vertex =
    { position : Vector3.Vec3
    , normal : Vector3.Vec3
    , uv : Vector2.Vec2
    , kx : Float
    , ky : Float
    }


type alias VertexGeometry =
    { position : ( Float, Float, Float )
    , normal : ( Float, Float, Float )
    , uv : ( Float, Float )
    }


toVertex : Float -> Float -> VertexGeometry -> Vertex
toVertex kx ky geo =
    { position = tupleToVec3 geo.position
    , normal = tupleToVec3 geo.normal
    , uv = tupleToVec2 geo.uv
    , kx = kx
    , ky = ky
    }


tupleToVec3 : ( Float, Float, Float ) -> Vector3.Vec3
tupleToVec3 ( x, y, z ) =
    Vector3.vec3 x y z


tupleToVec2 : ( Float, Float ) -> Vector2.Vec2
tupleToVec2 ( x, y ) =
    Vector2.vec2 x y


quad : List VertexGeometry
quad =
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
                { position = ( x, y, z )
                , normal = ( 0, 0, 1 )
                , uv = ( u, v )
                }
            )
