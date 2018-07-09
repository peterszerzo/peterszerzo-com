module Views.Projects exposing (..)

import Json.Decode as Decode
import Html.Styled exposing (Html, div, h1, p, a, header, node, img, text, fromUnstyled)
import Html.Styled.Attributes exposing (style, href, src, css)
import Html.Styled.Events exposing (onClick, onWithOptions)
import Css exposing (..)
import Css.Foreign as Foreign
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Data.Project as Project
import Data.PackBubble as PackBubble
import Views.Shapes as Shapes
import Views.Static as Static
import Messages exposing (Msg(..))


type alias Config =
    { projects : List Project.Project
    , packBubbles : List PackBubble.PackBubble
    , activeProject : Maybe String
    }


projectLogo : String -> Html msg
projectLogo name =
    (case name of
        "elm-gameroom" ->
            Shapes.elmgameroom

        "elm-arborist" ->
            Shapes.elmArborist

        "Atlas" ->
            Shapes.newamerica

        "ripsaw" ->
            Shapes.ripsaw

        "nlx" ->
            Shapes.nlx

        "Twisty Donut Racer" ->
            Shapes.twistydonutracer

        "SplytLight" ->
            Shapes.splytlight

        "OverEasy" ->
            Shapes.overeasy

        "peterszerzo.com" ->
            Shapes.smallLogo

        _ ->
            Shapes.ripsaw
    )
        |> fromUnstyled


view : Config -> Html Msg
view { projects, packBubbles, activeProject } =
    div
        [ css
            [ position relative
            , width (pct 100)
            , height (pct 100)
            , overflow hidden
            ]
        ]
    <|
        [ div [] <|
            List.map2
                (\project { x, y, r } ->
                    a
                        [ css
                            [ position absolute
                            , borderRadius (pct 50)
                            , cursor pointer
                            , backgroundColor blue
                            , property "box-shadow" "3px 6px 16px rgba(0, 0, 0, 0.2)"
                            , property "transition" "all 0.3s"
                            , hover
                                [ property "box-shadow" "3px 6px 24px rgba(0, 0, 0, 0.5)"
                                , property "transform" "scale(1.03)"
                                ]
                            , Foreign.descendants
                                [ Foreign.svg
                                    [ width (pct 60)
                                    , height (pct 60)
                                    , marginTop (pct 20)
                                    , marginLeft (pct 0)
                                    , fill white
                                    ]
                                ]
                            ]
                        , href ("/projects/" ++ project.id)
                        , onWithOptions "click"
                            { preventDefault = True
                            , stopPropagation = False
                            }
                            (Decode.succeed <| Navigate ("/projects/" ++ project.id))
                        , style
                            [ ( "width", (floor (2 * r) |> toString) ++ "px" )
                            , ( "height", (floor (2 * r) |> toString) ++ "px" )
                            , ( "top", (floor (y - r) |> toString) ++ "px" )
                            , ( "left", (floor (x - r) |> toString) ++ "px" )
                            ]
                        ]
                        [ projectLogo project.name ]
                )
                projects
                packBubbles
        ]
            ++ (activeProject
                    |> Maybe.andThen
                        (\activeProject ->
                            projects
                                |> List.filter (\p -> p.id == activeProject)
                                |> List.head
                        )
                    |> Maybe.map
                        (\project ->
                            [ div
                                [ css
                                    [ backgroundColor white
                                    , position absolute
                                    , top (px 0)
                                    , left (px 0)
                                    , width (pct 100)
                                    , height (pct 100)
                                    , overflow auto
                                    , property "animation" "fade-in 0.2s"
                                    , property "z-index" "18"
                                    , Mixins.desktop
                                        [ overflow hidden
                                        , displayFlex
                                        ]
                                    ]
                                ]
                                [ div
                                    [ css [ overlaySectionStyles ]
                                    ]
                                    [ img
                                        [ css
                                            [ margin4 (px 20) (px 20) (px 0) (px 20)
                                            , border3 (px 1) solid (rgba 0 0 0 0.1)
                                            , property "width" "calc(100% - 40px)"
                                            ]
                                        , src project.image
                                        ]
                                        []
                                    ]
                                , div [ css [ overlaySectionStyles ] ]
                                    [ Static.view project.description
                                    ]
                                ]
                            ]
                        )
                    |> Maybe.withDefault []
               )


overlaySectionStyles =
    Css.batch
        [ padding (px 0)
        , overflowY auto
        , overflowX hidden
        , textAlign left
        , Mixins.desktop
            [ height (pct 100)
            , width (pct 50)
            ]
        ]
