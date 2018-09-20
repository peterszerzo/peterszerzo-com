module Maddi.Views.Wing exposing (wing, wingHeader)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, br, div, fromUnstyled, h2, header, p, span, text)
import Html.Styled.Attributes exposing (css, href)
import Maddi.Data.Project as Project
import Maddi.Views as Views
import Maddi.Views.Mixins exposing (..)
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
            , margin4 (px 0) auto (px 100) auto
            , backgroundColor black
            , color white
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
            ++ [ "scale(1.0, 1.0)"
               ]
          )
            |> String.join " "
            |> property "transform"
        , property "-webkit-font-smoothing" "subpixel-antialiased"
        ]


wing : Project.Project -> Html msg
wing project =
    a
        [ css
            [ display inlineBlock
            , textDecoration none
            , color inherit
            , width (px (2 * wingWidth))
            , marginBottom (px 35)
            , position relative

            -- Offsets the fact that the first wing is pushed 1px to the right, so that
            -- adjacent wings can line up.
            , marginRight (px -2)
            , height (px wingHeight)
            , overflow visible
            , property "z-index" "100"
            , property "transition" "all 0.2s"
            , Global.children
                [ Global.div
                    [ width (px wingWidth)
                    , height (px wingHeight)
                    , display inlineFlex
                    , verticalAlign middle
                    , fontSize (px 0)
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
                , position relative
                , left (px 1)
                , flexDirection column
                , justifyContent spaceBetween
                , textAlign left
                ]
            ]
            [ div []
                [ h2
                    [ css
                        [ titleType
                        , margin (px 0)
                        ]
                    ]
                    [ text project.title ]
                , div
                    [ css
                        [ marginTop (px 8)
                        ]
                    ]
                  <|
                    List.map
                        (Views.tag False)
                        project.tags
                ]
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
                , property "background-image"
                    (project.imgs
                        |> List.head
                        |> Maybe.map (\{ url, alt, credit } -> "linear-gradient(45deg, rgba(255, 255, 255, 0.30), rgba(255, 255, 255, 0.15)), url(" ++ url ++ ")")
                        |> Maybe.withDefault ""
                    )
                ]
            ]
            []
        ]
