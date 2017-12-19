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
                                [ div [ localClass [ OverlaySection ] ]
                                    [ Static.view project.description
                                    ]
                                , div
                                    [ localClass [ OverlaySection ]
                                    ]
                                    [ div
                                        [ localClass [ ImageContainer ]
                                        , style
                                            [ ( "background-image", "url(" ++ project.image ++ ")" )
                                            ]
                                        ]
                                        []
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
        [ backgroundColor white
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
    , class ImageContainer
        [ margin (px 20)
        , property "width" "calc(100% - 40px)"
        , paddingTop (pct 65)
        , backgroundSize cover
        , backgroundRepeat noRepeat
        , property "background-position" "50% 50%"
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
