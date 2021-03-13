module Main exposing (main)

import Browser
import Browser.Events as Events
import Html
import Html.Attributes
import Json.Decode as Decode
import Json.Encode as Encode
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3
import Math.Vector4 as Vector4
import Shared.Glsllike as Glsllike
import Shared.Icosahedron as Icosahedron
import Shared.Palette as Palette
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
            moebiusVertexShader
            moebiusFragmentShader
            moebiusMesh
            { perspective = perspective_
            , transform = Matrix4.identity
            , time = time
            , color = Palette.get 0 palette
            , opacity = 1
            }
        ]
            ++ (List.range 0 5
                    |> List.map
                        (\index ->
                            let
                                verticalOffset =
                                    0.15 * sin (time * 0.003 + pi / 6 * toFloat index)

                                opacity =
                                    Glsllike.smoothstep 0.3 0.7 (abs verticalOffset / 0.15)
                            in
                            WebGL.entity
                                ballVertexShader
                                ballFragmentShader
                                ballMesh
                                { perspective =
                                    Matrix4.makeRotate (time * 0.0025) (Vector3.vec3 0 0.2 1)
                                        |> Matrix4.mul
                                            (moebiusTransform
                                                (0.0005 * time + pi / 3 * toFloat index)
                                                0
                                                (0.15 * sin (time * 0.003 + pi / 6 * toFloat index))
                                            )
                                        |> Matrix4.mul perspective_
                                , transform = Matrix4.identity
                                , time = time
                                , color = Palette.get (index + 1) palette
                                , opacity = opacity
                                }
                        )
               )


ballMesh : WebGL.Mesh Icosahedron.Vertex
ballMesh =
    Icosahedron.mesh 3


subscriptions : Model -> Sub Msg
subscriptions model =
    Setup.subscriptions model
        |> Sub.map Setup


perspective : Float -> Matrix4.Mat4
perspective time =
    let
        theta =
            sin (time * 0.0005) * pi / 6

        phi =
            pi * 0.2

        eye =
            Vector3.vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale
                    (2.2
                        - 0
                        * ((time / 850) |> sin |> (\val -> 1 + val))
                    )
    in
    Matrix4.mul (Matrix4.makePerspective 45 1 0.01 100)
        (Matrix4.makeLookAt eye (Vector3.vec3 0 0 0) (Vector3.vec3 0 0 1))



-- Moebius


type alias Uniforms =
    { transform : Matrix4.Mat4
    , perspective : Matrix4.Mat4
    , time : Float
    , color : Vector3.Vec3
    , opacity : Float
    }


type alias MoebiusVaryings =
    { vColor : Vector4.Vec4
    }


type alias MoebiusVertex =
    { position : Vector3.Vec3
    , lateralOffset : Float
    , angle : Float
    , normal : Vector3.Vec3
    }


moebiusMesh : WebGL.Mesh MoebiusVertex
moebiusMesh =
    let
        res =
            101
    in
    List.range 0 (res + 3)
        |> List.map
            (\index ->
                let
                    angle =
                        2 * pi * toFloat index / toFloat res

                    lateralOffset =
                        if modBy 2 index == 0 then
                            -1

                        else
                            1

                    transform =
                        moebiusTransform angle lateralOffset 0

                    position =
                        Matrix4.transform transform (Vector3.vec3 0 0 0)

                    normal =
                        Matrix4.transform transform (Vector3.vec3 0 0 1)
                in
                { position = position
                , normal = normal
                , angle = angle
                , lateralOffset = lateralOffset
                }
            )
        |> WebGL.triangleStrip


moebiusRadius : Float
moebiusRadius =
    0.5


moebiusWidth : Float
moebiusWidth =
    0.35


mulMany : List Matrix4.Mat4 -> Matrix4.Mat4
mulMany =
    List.foldl
        (\current accumulator ->
            Matrix4.mul
                accumulator
                current
        )
        Matrix4.identity


moebiusTransform : Float -> Float -> Float -> Matrix4.Mat4
moebiusTransform angle lateralOffset normalOffset =
    let
        sinAngle =
            sin angle

        cosAngle =
            cos angle

        translateXY =
            Matrix4.makeTranslate
                (Vector3.vec3 (moebiusRadius * cosAngle)
                    (moebiusRadius * sinAngle)
                    0
                )

        translateZ =
            Matrix4.makeTranslate (Vector3.vec3 0 0 normalOffset)

        translateY =
            Matrix4.makeTranslate
                (Vector3.vec3
                    (-0.5 * moebiusWidth * lateralOffset * cosAngle)
                    (-0.5 * moebiusWidth * lateralOffset * sinAngle)
                    0
                )

        rotateZ =
            Matrix4.makeRotate (angle + pi / 2) (Vector3.vec3 0 0 1)

        rotateX =
            Matrix4.makeRotate angle
                (Vector3.vec3
                    -sinAngle
                    cosAngle
                    0
                )
    in
    mulMany [ translateXY, rotateX, translateY, translateZ, rotateZ ]


moebiusVertexShader : WebGL.Shader MoebiusVertex Uniforms MoebiusVaryings
moebiusVertexShader =
    [glsl|
attribute vec3 position;
uniform vec3 color;
attribute float lateralOffset;
attribute vec3 normal;
attribute float angle;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying vec4 vColor;
const vec3 lightDirection = vec3(0.0, 0.0, 1.0);
void main () {
  gl_Position = (perspective * transform) * vec4(position, 1.0);
  float brightness =
    0.60 +
    0.4 * dot(lightDirection, normalize(normal)) +
    0.2 * sin(angle * 3.0 - time * 0.0005);
  vColor = vec4(
    color.r * brightness,
    color.g * brightness,
    color.b * brightness,
    1.0
  );
}
|]


moebiusFragmentShader : WebGL.Shader {} Uniforms MoebiusVaryings
moebiusFragmentShader =
    [glsl|
precision mediump float;
varying vec4 vColor;
void main () {
  gl_FragColor = vColor;
}
|]



-- Ball


type alias BallVaryings =
    { brightness : Float
    }


ballVertexShader : WebGL.Shader Icosahedron.Vertex Uniforms BallVaryings
ballVertexShader =
    [glsl|
attribute vec3 position;
attribute vec3 normal;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying float brightness;
const vec3 lightDirection = vec3(0.0, 0.0, 1.0);
void main () {
  gl_Position = (perspective * transform) * vec4(0.03 * position + vec3(0.0, 0.0, 0.0), 1.0);
  brightness = 1.0 + (1.0 - dot(
    normalize(vec3(lightDirection)),
    normalize((transform * vec4(normal, 1.0)).xyz)
  ));
}
|]


ballFragmentShader : WebGL.Shader {} Uniforms BallVaryings
ballFragmentShader =
    [glsl|
precision mediump float;
varying float brightness;
uniform vec3 color;
void main () {
  gl_FragColor = vec4(color * brightness, 1.0);
}
|]
