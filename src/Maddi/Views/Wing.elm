module Maddi.Views.Wing exposing (wing, wingHeader)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, br, div, fromUnstyled, h2, header, p, text)
import Html.Styled.Attributes exposing (css, href)
import Maddi.Data.Project as Project
import Maddi.Views.Mixins exposing (..)
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3
import Svg.Styled exposing (line, svg)
import Svg.Styled.Attributes exposing (fill, stroke, viewBox, x1, x2, y1, y2)


wingSkewAngle : Float
wingSkewAngle =
    15 * pi / 180


wingWidth : Float
wingWidth =
    140


wingHeight : Float
wingHeight =
    240


wingHeader : String -> Html msg
wingHeader title =
    div
        [ css
            [ titleType
            , width (px <| 2 * wingWidth)
            , property "transform" <| "skewY(" ++ String.fromFloat -wingSkewAngle ++ "rad)"
            , margin4 (px 120) auto (px 100) auto
            , padding2 (px 4) (px 10)
            , textAlign center
            , stickoutStyles { hover = False }
            ]
        ]
        [ text title ]


wingTransform : { skewAngle : Float, scale : Float, w : Float, offset : Int } -> Style
wingTransform { skewAngle, scale, w, offset } =
    let
        translateString =
            "translate3d("
                ++ String.fromInt (floor w * offset)
                ++ "px, "
                ++ String.fromInt
                    (if skewAngle > 0 then
                        w * tan -skewAngle |> floor

                     else
                        0
                    )
                ++ "px, 0)"
    in
    Css.batch
        [ ([ "skewY(" ++ String.fromFloat skewAngle ++ "rad)" ]
            ++ (if offset == 1 then
                    [ translateString ]

                else
                    []
               )
            ++ [ "scale(1.0, 1.0)"
               ]
          )
            |> String.join " "
            |> property "transform"
        , property "-webkit-font-smoothing" "subpixel-antialiased"
        ]


wingBorders : Html msg
wingBorders =
    let
        w =
            wingWidth

        h =
            wingHeight

        s =
            10

        dy =
            w * tan wingSkewAngle

        fF =
            String.fromFloat
    in
    svg
        [ viewBox "-10 -10 180 280" ]
        [ line
            [ x1 <| fF -s
            , y1 <| fF dy
            , x2 <| fF (w + s)
            , y2 <| fF 0
            , stroke "#000"
            ]
            []
        , line
            [ x1 <| fF 0
            , y1 <| fF (dy - s)
            , x2 <| fF 0
            , y2 <| fF (dy + h + s)
            , stroke "#000"
            ]
            []
        , line
            [ x1 <| fF -s
            , y1 <| fF (h + dy)
            , x2 <| fF (w + s)
            , y2 <| fF h
            , stroke "#000"
            ]
            []
        , line
            [ x1 <| fF w
            , y1 <| fF -s
            , x2 <| fF w
            , y2 <| fF (h + s)
            , stroke "#000"
            ]
            []
        ]


wing : Project.Project -> Html msg
wing project =
    let
        translation =
            Matrix4.makeTranslate (Vector3.vec3 0 0 0)

        rotation =
            Matrix4.makeRotate 0.9 (Vector3.vec3 0 1 0)

        perspective =
            Matrix4.makeLookAt
                (Vector3.vec3 0 0.05 0.1)
                (Vector3.vec3 0 0 0)
                (Vector3.vec3 0 0 -1)

        matrix =
            rotation
                |> Matrix4.mul translation
                |> Matrix4.mul perspective
    in
    a
        [ css
            [ display inlineBlock
            , textDecoration none
            , color inherit
            , width (px (2 * wingWidth))
            , marginBottom (px 20)
            , position relative
            , height (px wingHeight)
            , overflow visible
            , property "z-index" "100"
            , property "transition" "all 0.2s"
            , Global.children
                [ Global.div
                    [ width (px wingWidth)
                    , height (px wingHeight)
                    , position absolute
                    , stickoutStyles { hover = False }
                    , property "word-break" "break-all"
                    , property "transition" "all 0.2s ease-in-out"
                    ]
                , Global.svg
                    [ position absolute
                    , top (px 0)
                    , left (px 0)
                    , width (px wingWidth)
                    , height (px wingHeight)
                    ]
                ]
            , hover
                [ property "z-index" "101"
                , Global.children
                    [ Global.div
                        [ stickoutStyles { hover = True }
                        ]
                    ]
                ]
            ]
        , href <| "/projects/" ++ project.id
        ]
        [ --wingBorders
          div
            [ css
                [ wingTransform
                    { skewAngle = -wingSkewAngle
                    , w = wingWidth
                    , scale = 1
                    , offset = 0
                    }
                , padding (px 10)
                , displayFlex
                , flexDirection column
                , justifyContent spaceBetween
                , textAlign left
                ]
            ]
            [ h2
                [ css
                    [ titleType
                    , margin (px 0)
                    ]
                ]
                [ text project.title ]
            , p
                [ css
                    [ fontSize (Css.rem 1.5)
                    , color (hex "ADADAD")
                    , margin (px 0)
                    ]
                ]
                [ project.openedAt
                    |> (\( year, month, day ) ->
                            text (String.fromInt month ++ " / " ++ String.fromInt year)
                       )
                ]
            ]
        , div
            [ css
                [ padding (px 6)
                , wingTransform
                    { skewAngle = wingSkewAngle
                    , scale = 1
                    , w = wingWidth
                    , offset = 1
                    }
                , property "background-size" "cover"
                , property "background-position" "50% 50%"
                , property "background-clip" "content-box"
                , property "background-image"
                    (project.imgs
                        |> List.head
                        |> Maybe.map (\( img, alt ) -> "linear-gradient(45deg, rgba(255, 255, 255, 0.30), rgba(255, 255, 255, 0.15)), url(" ++ img ++ ")")
                        |> Maybe.withDefault ""
                    )
                ]
            ]
            []
        ]
