module Main exposing (main)

import Browser
import Browser.Events as Events
import Html
import Html.Attributes
import Math.Matrix4 as Matrix4
import Math.Vector2 as Vector2
import Math.Vector3 as Vector3
import Time
import WebGL



-- Entry point


main : Program () Model Msg
main =
    Browser.element
        { init =
            \_ ->
                ( { appTime = initAppTime
                  }
                , Cmd.none
                )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { appTime : AppTime
    }


type alias AppTime =
    Maybe
        { start : Time.Posix
        , current : Time.Posix
        }


initAppTime : AppTime
initAppTime =
    Nothing


playhead : AppTime -> Float
playhead maybeAppTime =
    case maybeAppTime of
        Nothing ->
            0

        Just appTime ->
            Time.posixToMillis appTime.current
                - Time.posixToMillis appTime.start
                |> toFloat



-- Update


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model
                | appTime =
                    case model.appTime of
                        Just appTime ->
                            Just
                                { appTime
                                    | current =
                                        newTime
                                }

                        Nothing ->
                            Just
                                { current = newTime
                                , start = newTime
                                }
              }
            , Cmd.none
            )



-- View


view : Model -> Html.Html Msg
view model =
    let
        arg1 =
            0.5

        arg2 =
            0.5

        playhead_ =
            playhead model.appTime

        phase =
            playhead_ * 0.00012

        sinPhase =
            sin phase

        perspective_ =
            perspective playhead_
    in
    Html.div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "align-items" "center"
        , Html.Attributes.style "justify-content" "center"
        ]
        [ WebGL.toHtmlWith
            [ WebGL.preserveDrawingBuffer
            , WebGL.alpha True
            , WebGL.antialias
            , WebGL.depth 1
            ]
            [ Html.Attributes.width 1204
            , Html.Attributes.height 404
            , Html.Attributes.style "background-color" "rgb(70, 87, 117)"
            ]
            (List.range 0 35
                |> List.map toFloat
                |> List.map
                    (\val ->
                        WebGL.entity
                            vertexShader
                            fragmentShader
                            mesh
                            { perspective = perspective_
                            , aspect = 3
                            , transform =
                                let
                                    scale_ =
                                        0.3 + 0.075 * sin (val * 12.5 + arg1 * 5)

                                    x =
                                        0.5 * sin (val * 2.8 + arg2 * 2 * sinPhase)

                                    y =
                                        0.3 * sin (val * 3.7 + arg1 * 3 * sinPhase)

                                    z =
                                        0.4 * sin (val * 9.4)
                                in
                                [ Matrix4.makeScale (Vector3.vec3 scale_ scale_ scale_)
                                , Matrix4.makeTranslate (Vector3.vec3 x y z)
                                ]
                                    |> List.foldl Matrix4.mul Matrix4.identity
                            , time =
                                playhead_
                            , opacity = 1
                            }
                    )
            )
        ]


perspective : Float -> Matrix4.Mat4
perspective _ =
    let
        theta =
            pi * 0.25

        phi =
            pi * 0.3

        base =
            Vector3.vec3 0.0 0.0 0.0

        eye =
            Vector3.vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale 1.5
                |> Vector3.add base
    in
    Matrix4.mul (Matrix4.makePerspective 45 1 0.01 100)
        (Matrix4.makeLookAt eye base (Vector3.vec3 0 0 1))


type alias Uniforms =
    { transform : Matrix4.Mat4
    , perspective : Matrix4.Mat4
    , aspect : Float
    , time : Float
    , opacity : Float
    }


type alias Varyings =
    { brightness : Float
    , vUv : Vector2.Vec2
    }


vertexShader : WebGL.Shader Vertex Uniforms Varyings
vertexShader =
    [glsl|
attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;
uniform float aspect;
uniform mat4 perspective;
uniform mat4 transform;
uniform float time;
varying float brightness;
varying vec2 vUv;
const vec3 lightDirection = vec3(0.0, 0.0, 1.0);

void main () {
  gl_Position = (perspective * transform) * vec4(0.8 * position, 1.0);
  gl_Position.xy *= 1.2;
  gl_Position.x = gl_Position.x / aspect + (aspect - 1.0) * 0.15;
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

void main() {
  vec2 vUv2 = fract(vUv * 8.0);
  if (distance(vUv2, vec2(0.5, 0.5)) < 0.49) {
    discard;
  }
  vec3 base = vec3(242.0, 197.0, 33.0) / 255.0;
  gl_FragColor = vec4(base, 1.0);
}
|]


type alias Vertex =
    { position : Vector3.Vec3
    , normal : Vector3.Vec3
    , uv : Vector2.Vec2
    }


mesh : WebGL.Mesh Vertex
mesh =
    [ { position = Vector3.vec3 -0.5 -0.5 0
      , normal = Vector3.vec3 0 0 1
      , uv = Vector2.vec2 0 0
      }
    , { position = Vector3.vec3 0.5 -0.5 0
      , normal = Vector3.vec3 0 0 1
      , uv = Vector2.vec2 0 1
      }
    , { position = Vector3.vec3 -0.5 0.5 0
      , normal = Vector3.vec3 0 0 1
      , uv = Vector2.vec2 1 0
      }
    , { position = Vector3.vec3 0.5 0.5 0
      , normal = Vector3.vec3 0 0 1
      , uv = Vector2.vec2 1 1
      }
    ]
        |> WebGL.triangleStrip



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onAnimationFrame Tick
