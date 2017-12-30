module Views.Projects exposing (..)

import Html exposing (Html, div, h1, p, a, header, node, img)
import Html.Attributes exposing (style, href, src)
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
                        , onClick (Navigate ("/projects/" ++ project.id))
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
                                [ localClass [ Overlay ]
                                ]
                                [ div
                                    [ localClass [ OverlaySection ]
                                    ]
                                    [ img
                                        [ localClass [ Image ]
                                        , Html.Attributes.src project.image
                                        ]
                                        []
                                    ]
                                , div [ localClass [ OverlaySection ] ]
                                    [ Static.view project.description
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
    | OverlaySection
    | Link
    | Image


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
        , property "box-shadow" "3px 6px 16px rgba(0, 0, 0, 0.2)"
        , property "transition" "all 0.3s"
        , hover
            [ property "box-shadow" "3px 6px 24px rgba(0, 0, 0, 0.5)"
            , property "transform" "scale(1.03)"
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
        [ backgroundColor white
        , position absolute
        , top (px 0)
        , left (px 0)
        , width (pct 100)
        , height (pct 100)
        , overflow auto
        , property "animation" "fade-in 0.2s"
        , property "z-index" "18"
        ]
    , class OverlaySection
        [ padding (px 0)
        , overflowY auto
        , overflowX hidden
        , textAlign left
        ]
    , mediaQuery desktop
        [ class Overlay
            [ overflow hidden
            , displayFlex
            ]
        , class OverlaySection
            [ height (pct 100)
            , width (pct 50)
            ]
        ]
    , class Image
        [ margin4 (px 20) (px 20) (px 0) (px 20)
        , border3 (px 1) solid (rgba 0 0 0 0.1)
        , property "width" "calc(100% - 40px)"
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
