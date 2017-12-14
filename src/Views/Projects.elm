module Views.Projects exposing (..)

import Html exposing (Html, div, h1, p, a, header, node)
import Html.Attributes exposing (style, href)
import Html.Events exposing (onClick)
import Html.CssHelpers
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Data.Project as Project
import Data.PackBubble as PackBubble
import Content
import Views.Shapes as Shapes
import Views.Static as Static
import Views.Nav
import Messages exposing (Msg(..))


type alias Config =
    { projects : List Project.Project
    , packBubbles : List PackBubble.PackBubble
    , activeProject : Maybe String
    }


projectLogo : String -> Html msg
projectLogo name =
    case name of
        "elm-gameroom" ->
            Shapes.elmgameroom

        "Atlas" ->
            Shapes.newamerica

        "ripsaw" ->
            Shapes.ripsaw

        "nlx" ->
            Shapes.nlx

        "The Seed" ->
            Shapes.theseed

        "SplytLight" ->
            Shapes.splytlight

        "OverEasy" ->
            Shapes.overeasy

        _ ->
            Shapes.ripsaw


view : Config -> Html Msg
view { projects, packBubbles, activeProject } =
    div
        [ localClass [ Root ]
        ]
    <|
        [ div [ localClass [ Bubbles ] ] <|
            List.map2
                (\project { x, y, r } ->
                    div
                        [ localClass [ Bubble ]
                        , onClick (SetActiveProject (Just project.name))
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
                                |> List.filter (\p -> p.name == activeProject)
                                |> List.head
                        )
                    |> Maybe.map
                        (\project ->
                            [ div
                                [ localClass [ Overlay ]
                                ]
                                [ div
                                    [ localClass [ OverlayClose ]
                                    , onClick (SetActiveProject Nothing)
                                    ]
                                    [ Shapes.close
                                    ]
                                , div
                                    [ localClass [ OverlaySection ]
                                    ]
                                    [ div
                                        [ localClass [ ImageContainer ]
                                        , style
                                            [ ( "background-image", "url(" ++ project.image ++ ")" )
                                            , ( "background-size", "cover" )
                                            , ( "background-position", "50% 50%" )
                                            , ( "background-clip", "content-box" )
                                            ]
                                        ]
                                        []
                                    ]
                                , div [ localClass [ OverlaySection ] ]
                                    [ Static.view ("# " ++ project.name ++ "\n\n" ++ project.description)
                                    ]
                                ]
                            ]
                        )
                    |> Maybe.withDefault []
               )


cssNamespace : String
cssNamespace =
    "Projects"


type CssClasses
    = Root
    | Bubble
    | Bubbles
    | Overlay
    | OverlayClose
    | OverlaySection
    | Link
    | ImageContainer


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


styles : List Css.Snippet
styles =
    [ class Root
        [ position relative
        , width (pct 100)
        , height (pct 100)
        , overflow hidden
        ]
    , class Bubble
        [ position absolute
        , borderRadius (pct 50)
        , cursor pointer
        , backgroundColor blue
        , property "box-shadow" "3px 6px 18px rgba(0, 0, 0, 0.3)"
        , property "transition" "box-shadow 0.3s"
        , hover
            [ property "box-shadow" "3px 6px 28px rgba(0, 0, 0, 0.5)"
            ]
        , descendants
            [ Elements.svg
                [ width (pct 60)
                , height (pct 60)
                , marginTop (pct 20)
                , marginLeft (pct 0)
                , fill white
                ]
            ]
        ]
    , class Overlay
        [ backgroundColor (rgba 255 255 255 0.96)
        , position absolute
        , top (px 0)
        , displayFlex
        , left (px 0)
        , overflow hidden
        , width (pct 100)
        , height (pct 100)
        , property "animation" "fade-in 0.2s"
        , property "z-index" "18"
        ]
    , class OverlaySection
        [ width (pct 50)
        , height (pct 100)
        , padding (px 0)
        , overflowY auto
        , overflowX hidden
        , textAlign left
        ]
    , class OverlayClose
        [ width (px 60)
        , height (px 60)
        , cursor pointer
        , padding (px 14)
        , top (px 20)
        , backgroundColor blue
        , borderRadius (pct 50)
        , right (px 20)
        , property "z-index" "20"
        , position absolute
        , descendants
            [ Elements.svg
                [ property "stroke" "#FFF"
                ]
            ]
        , property "box-shadow" "3px 6px 12px rgba(0, 0, 0, 0.1)"
        , property "transition" "all 0.3s"
        , hover
            [ property "box-shadow" "3px 6px 20px rgba(0, 0, 0, 0.2)"
            ]
        ]
    , class ImageContainer
        [ margin (px 20)
        , property "width" "calc(100% - 40px)"
        , property "height" "calc(100% - 40px)"
        , border3 (px 1) solid (rgba 0 0 0 0.1)
        , property "box-shadow" "0px 0px 8px rgba(0, 0, 0, 0.15)"
        ]
    , class Link
        [ backgroundColor blue
        , color white
        , textDecoration none
        , padding2 (px 8) (px 12)
        , borderRadius (px 3)
        , margin (px 20)
        , hover
            [ backgroundColor lightBlue
            ]
        ]
    ]
        |> namespace cssNamespace
