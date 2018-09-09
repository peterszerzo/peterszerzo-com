module Maddi.Views.Wing exposing (wing, wingTransform)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, br, div, fromUnstyled, h2, header, p, text)
import Html.Styled.Attributes exposing (css, href)
import Maddi.Data.Project as Project
import Maddi.Views.Mixins exposing (..)
import Math.Matrix4 as Matrix4
import Math.Vector3 as Vector3
import String.Future


wingTransform : { skewAngle : Float, scale : Float, w : Float, offset : Int } -> Style
wingTransform { skewAngle, scale, w, offset } =
    [ "skewX(" ++ String.Future.fromFloat skewAngle ++ "rad)"
    , "rotate(" ++ String.Future.fromFloat skewAngle ++ "rad)"
    , "scale(" ++ String.Future.fromFloat scale ++ ")"
    , "translate3d("
        ++ String.Future.fromFloat (w * toFloat offset - (scale - 1) * 40)
        ++ "px, "
        ++ String.Future.fromFloat
            (if skewAngle > 0 then
                w * tan -skewAngle + (scale - 1) * 16

             else
                0
            )
        ++ "px, 0)"
    ]
        |> String.join " "
        |> property "transform"


wing :
    { navigate : String -> msg
    , order : Int
    , project : Project.Project
    , selected : Maybe String
    }
    -> Html msg
wing { navigate, order, project, selected } =
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

        skewAngle =
            -20 * pi / 180

        width_ =
            140
    in
    a
        [ css
            [ display block
            , textDecoration none
            , color inherit
            , position absolute
            , left (px ((2 * width_ * 1.06417) * toFloat order))
            , overflow visible
            , property "z-index" "100"
            , property "transition" "all 0.2s"
            , case selected of
                Just projectId ->
                    Css.batch <|
                        if projectId == project.id then
                            []

                        else
                            [ opacity (num 0.3)
                            ]

                Nothing ->
                    Css.batch []
            , Global.children
                [ Global.div
                    [ width (px width_)
                    , height (px 240)
                    , position absolute
                    , stickoutStyles { hover = False }
                    , property "word-break" "break-all"
                    , property "transition" "all 0.2s ease-in-out"
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
        [ div
            [ css
                [ wingTransform
                    (if selected == Just project.id then
                        { skewAngle = skewAngle * 0.65
                        , w = width_
                        , offset = 0
                        , scale = 1.15
                        }

                     else
                        { skewAngle = skewAngle
                        , w = width_
                        , offset = 0
                        , scale = 1
                        }
                    )
                , padding (px 10)
                , displayFlex
                , flexDirection column
                , justifyContent spaceBetween
                ]
            ]
            [ h2
                [ css
                    [ fontSize (Css.rem 1.5)
                    , textTransform uppercase
                    , margin (px 0)
                    , fontWeight normal
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
                            text (String.Future.fromInt month ++ " / " ++ String.Future.fromInt year)
                       )
                ]
            ]
        , div
            [ css
                [ padding (px 6)
                , wingTransform
                    (if selected == Just project.id then
                        { skewAngle = -skewAngle * 0.65
                        , scale = 1.15
                        , w = width_
                        , offset = 1
                        }

                     else
                        { skewAngle = -skewAngle
                        , scale = 1
                        , w = width_
                        , offset = 1
                        }
                    )
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
