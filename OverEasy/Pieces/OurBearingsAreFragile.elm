module Pieces.OurBearingsAreFragile exposing (..)

import Time
import Random
import AnimationFrame
import Html exposing (Html, Attribute, div, program)
import Html.Attributes exposing (class, style, width, height)
import Svg exposing (svg, path)
import Svg.Attributes exposing (viewBox, d, fill, transform)
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3 exposing (Vec3, vec3)
import Math.Vector4 as Vector4 exposing (Vec4, vec4)
import WebGL
import Concepts.Icosahedron as Icosahedron


type alias Model =
    { time : Time.Time
    , startTime : Time.Time
    , starPositions : List ( Float, Float )
    }


type Msg
    = Tick Time.Time
    | StarPositions (List ( Float, Float ))


init : ( Model, Cmd Msg )
init =
    ( { time = 0
      , startTime = 0
      , starPositions = []
      }
    , Cmd.batch
        [ Random.generate StarPositions generateStarPositions
        ]
    )


w : Float
w =
    800


h : Float
h =
    480


generateStarPositions : Random.Generator (List ( Float, Float ))
generateStarPositions =
    Random.list 360 (Random.pair (Random.float 0 1) (Random.float 0 1))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model
                | startTime =
                    if model.startTime == 0 then
                        time
                    else
                        model.startTime
                , time = time
              }
            , Cmd.none
            )

        StarPositions starPositions ->
            ( { model | starPositions = starPositions }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.times Tick
        ]


star : Int -> Html msg
star size =
    svg
        [ Svg.Attributes.width (toString size)
        , Svg.Attributes.height (toString size)
        , viewBox "0 0 100 100"
        ]
        [ path
            [ d "M20,50 L50,20 L80,50 L50,80 M20,20"
            , fill "#AEAEAE"
            ]
            []
        ]


view : Model -> Html Msg
view model =
    let
        zoom =
            12

        size =
            max w h + 240 |> floor

        top =
            (w - h) / 2 |> min 0
    in
        div
            [ style
                [ ( "overflow", "hidden" )
                , ( "position", "relative" )
                , ( "width", (toString w) ++ "px" )
                , ( "height", (toString h) ++ "px" )
                , ( "background-color", "#FFFFFF" )
                , ( "border", "2px solid #000" )
                ]
            ]
            (WebGL.toHtmlWith
                [ WebGL.alpha True
                , WebGL.depth 1
                , WebGL.antialias
                ]
                [ width size
                , height size
                , style
                    [ ( "position", "absolute" )
                    , ( "top", "50%" )
                    , ( "left", "50%" )
                    , ( "transform", "translate3d(-50%, -50%, 0)" )
                    , ( "width", (toString size) ++ "px" )
                    , ( "height", (toString size) ++ "px" )
                    , ( "z-index", "10" )
                    ]
                ]
                [ globeEntity (model.time - model.startTime)
                ]
                :: (List.map
                        (\( x, y ) ->
                            div
                                [ style
                                    [ ( "position", "absolute" )
                                    , ( "opacity", "0.4" )
                                    , ( "top", ((toFloat size) * x |> toString) ++ "px" )
                                    , ( "left", ((toFloat size) * y |> toString) ++ "px" )
                                    , ( "z-index", "9" )
                                    ]
                                ]
                                [ if size < 800 then
                                    star 6
                                  else
                                    star 9
                                ]
                        )
                        model.starPositions
                   )
            )



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
    }


globeEntity : Time.Time -> WebGL.Entity
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


globePerspective : Time.Time -> Matrix4.Mat4
globePerspective time =
    let
        sineTime =
            sin (time / 1800)

        theta =
            -pi / 3 + pi / 100 * sineTime

        phi =
            2 * pi / 8 + pi / 100 * sineTime

        eye =
            vec3
                (sin theta * cos phi)
                (cos theta * cos phi)
                (sin phi)
                |> Vector3.scale 9
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
        ( { normal = normal, center = center, polarCenter = toPolar center, polar = (toPolar pt1), position = pt1 }
        , { normal = normal, center = center, polarCenter = toPolar center, polar = (toPolar pt2), position = pt2 }
        , { normal = normal, center = center, polarCenter = toPolar center, polar = (toPolar pt3), position = pt3 }
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
            Basics.toPolar ( (Vector3.getX v), (Vector3.getY v) ) |> Tuple.second

        phi =
            Vector3.dot vNorm (vec3 0 0 1) |> acos |> (\angle -> pi / 2 - angle)
    in
        vec3 r theta phi


mesh : WebGL.Mesh Vertex
mesh =
    List.map
        rawTriangleToVertexTriangle
        (List.map (Icosahedron.subdivide 4) Icosahedron.icosahedron |> List.foldl (++) [])
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

float getSplitRatio(float radius, float breakRadius1, float breakRadius2) {
  if (radius > breakRadius2) {
    return 0.0;
  }
  if (radius > breakRadius1) {
    return (breakRadius2 - radius) / (breakRadius2 - breakRadius1);
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

  float breakRadius1 = 0.8 + 0.12 * (sin(thetaCenter * 3.0 - time / 1800.0)) + 0.06 * (sin(thetaCenter * 5.0 + 0.3 + time / 1800.0));

  float breakRadius2 = breakRadius1 + 0.8 + 0.04 * (sin(thetaCenter * 0.3 + time / 1800.0));

  float splitRatio = getSplitRatio(radius, breakRadius1, breakRadius2);

  float colorRatio = getColorRatio(radius, breakRadius1, breakRadius2);

  vec3 newPosition = center + (position - center) * splitRatio;

  vec4 color1 = vec4(120.0 / 255.0, 120.0 / 255.0, 120.0 / 255.0, 1.0);
  vec4 color2 = vec4(120.0 / 255.0, 120.0 / 255.0, 120.0 / 255.0, 0.3);

  baseColor = colorRatio * color1 + (1.0 - colorRatio) * color2;

  brightness = 1.0 + (1.0 - dot(
    normalize(vec3(0.3, -0.2, 1)),
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

void main() {
  float luminosity = 0.21 * baseColor.r + 0.72 * baseColor.g + 0.07 * baseColor.b;
  gl_FragColor = vec4(
    luminosity * brightness,
    luminosity * brightness,
    luminosity * brightness,
    1.0
  );
  gl_FragColor = baseColor * brightness;
}
|]


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
