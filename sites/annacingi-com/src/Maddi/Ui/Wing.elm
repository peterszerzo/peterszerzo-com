module Maddi.Ui.Wing exposing (wing, wingHeader)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, div, h2, p, text)
import Html.Styled.Attributes exposing (css, href)
import Maddi.Data.Project as Project
import Maddi.Ui as Ui


wing : Bool -> Project.Project -> Html msg
wing flip project =
    let
        content =
            div
                [ css
                    [ height (pct 100)
                    , padding (px 10)
                    , flexDirection column
                    , displayFlex
                    , justifyContent spaceBetween
                    , textAlign left
                    ]
                ]
                [ div []
                    [ h2
                        [ css
                            [ Ui.titleType
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
                            (Ui.tag False)
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
                        |> (\( year, month, _ ) ->
                                text (String.fromInt month ++ " / " ++ String.fromInt year)
                           )
                    ]
                ]

        imageContent =
            div
                [ css
                    [ height (pct 100)
                    , width (pct 100)
                    , styles
                    ]
                ]
                children

        ( styles, children ) =
            project.imgs
                |> List.map .url
                |> (\urls -> List.filterMap identity [ project.thumbnailImg ] ++ urls)
                |> List.head
                |> Maybe.map
                    (\url ->
                        ( Css.batch
                            [ property "background-size" "cover"
                            , property "background-position" "50% 50%"
                            , property "background-image" <| "linear-gradient(45deg, rgba(255, 255, 255, 0.30), rgba(255, 255, 255, 0.15)), url(" ++ url ++ ")"
                            ]
                        , []
                        )
                    )
                |> Maybe.withDefault
                    ( Css.batch
                        [ backgroundColor (rgb 60 60 60)
                        ]
                    , Ui.logoPattern
                    )
    in
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
                    , Ui.stickoutStyles { hover = False }
                    , property "word-break" "break-all"
                    , property "transition" "all 0.1s ease-in-out"
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
                [ Global.children
                    [ Global.div
                        [ firstChild
                            [ backgroundColor (hex "F1F1F1")
                            ]
                        , lastChild
                            [ property "filter" "brightness(90%)"
                            ]
                        ]
                    ]
                ]
            ]
        , href <| "/projects/" ++ project.id
        ]
        [ div
            [ css
                [ wingTransform
                    { skewAngle = -wingSkewAngle
                    }
                , left (px 1)
                , position relative
                ]
            ]
            [ if flip then
                imageContent

              else
                content
            ]
        , div
            [ css
                [ overflow hidden
                , wingTransform
                    { skewAngle = wingSkewAngle
                    }
                ]
            ]
            [ if flip then
                content

              else
                imageContent
            ]
        ]


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
            [ Ui.titleType
            , width (px <| 2 * wingWidth)
            , property "transform" <| "skewY(" ++ String.fromFloat -wingSkewAngle ++ "rad)"
            , margin4 (px 0) auto (px 100) auto
            , backgroundColor Ui.black
            , color Ui.white
            , padding2 (px 4) (px 10)
            , textAlign center
            , Ui.stickoutStyles { hover = False }
            ]
        ]
        [ text title ]


wingTransform : { skewAngle : Float } -> Style
wingTransform { skewAngle } =
    Css.batch
        [ [ "skewY("
                ++ String.fromFloat skewAngle
                ++ "rad)"
          , "scale(1.0, 1.0)"
          ]
            |> String.join " "
            |> property "transform"
        , property "-webkit-font-smoothing" "subpixel-antialiased"
        ]
