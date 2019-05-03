port module MarchingWindows exposing (Model, Msg(..), init, subscriptions, update, view)

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
      , isAnimating = True
      }
    , Cmd.none
    )


w : Float
w =
    640


h : Float
h =
    640


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

  float r = 0.5 + 0.5 * sin(st.x * units + time / 2000.0) * sin(st.y * units - time / 10000.0);
  float b = 0.5 + 0.5 * sin(st.x * units + time / 10000.0) * sin(st.y * units - time / 2000.0);

  r = doubleCircleSigmoid(r, 0.5);
  b = doubleCircleSigmoid(b, 0.5);

  gl_FragColor = vec4(r, mix(r, b, 0.5 + 0.5 * sin(time / 1000.0)), b, 1.0);
}
|]
