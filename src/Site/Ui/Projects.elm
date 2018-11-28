module Site.Ui.Projects exposing (Config, overlaySectionStyles, projectLogo, view)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, a, div, fromUnstyled, h1, header, img, node, p, text)
import Html.Styled.Attributes exposing (css, href, src, style)
import Html.Styled.Events exposing (onClick)
import Json.Decode as Decode
import Site.Content exposing (Project)
import Site.Data.PackBubble as PackBubble
import Site.Messages exposing (Msg(..))
import Site.Styles.Constants exposing (..)
import Site.Styles.Mixins as Mixins
import Site.Ui as Ui
import Site.Ui.Shapes as Shapes


type alias Config =
    { projects : List Project
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
                    let
                        r_ =
                            r * 1.1
                    in
                    a
                        [ css
                            [ position absolute
                            , borderRadius (px 6)
                            , cursor pointer
                            , property "box-shadow" "3px 6px 20px rgba(0, 0, 0, 0.3)"
                            , backgroundColor blue
                            , property "transition" "all 0.3s"
                            , property "z-index" (r |> floor |> String.fromInt)
                            , hover
                                [ property "box-shadow" "3px 6px 28px rgba(0, 0, 0, 0.5)"
                                , property "transform" "scale(1.03)"
                                ]
                            , Global.descendants
                                [ Global.svg
                                    [ width (pct 60)
                                    , height (pct 60)
                                    , marginTop (pct 20)
                                    , marginLeft (pct 0)
                                    , fill white
                                    ]
                                ]
                            ]
                        , style "background-color" <| "#" ++ project.color
                        , href ("/projects/" ++ project.id)
                        , style "width" <| ((floor (2 * r_) |> String.fromInt) ++ "px")
                        , style "height" <| ((floor (2 * r_) |> String.fromInt) ++ "px")
                        , style "top" <| ((floor (y - r_) |> String.fromInt) ++ "px")
                        , style "left" <| ((floor (x - r_) |> String.fromInt) ++ "px")
                        ]
                        [ projectLogo project.name ]
                )
                projects
                packBubbles
        ]
            ++ (activeProject
                    |> Maybe.andThen
                        (\justActiveProject ->
                            projects
                                |> List.filter (\project -> project.id == justActiveProject)
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
                                    , property "z-index" "1000"
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
                                    [ Ui.static { children = [], markdown = Just project.description }
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
