module Views.Projects exposing (..)

import Html exposing (Html, div, h1, p, header, node)
import Html.Attributes exposing (style)
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
                                , div [ localClass [ OverlaySection ] ]
                                    [ h1 [] [ Html.text project.name ]
                                    , p [] [ Html.text project.description ]
                                    , p [] [ Html.text ("Roles: " ++ (String.join ", " project.roles)) ]
                                    , p [] [ Html.text ("Technologies: " ++ (String.join ", " project.technologies)) ]
                                    ]
                                , div [ localClass [ OverlaySection ] ] []
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


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


styles : List Css.Snippet
styles =
    [ class Root
        [ position relative
        , width (pct 100)
        , height (pct 100)
        ]
    , class Bubble
        [ position absolute
        , borderRadius (pct 50)
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
        [ backgroundColor (rgba 255 255 255 0.92)
        , position absolute
        , top (px 0)
        , displayFlex
        , left (px 0)
        , width (pct 100)
        , height (pct 100)
        , property "z-index" "18"
        ]
    , class OverlaySection
        [ width (pct 50)
        , property "height" (Mixins.calcPctMinusPx 100 40)
        , padding (px 15)
        , margin2 (px 20) (px 0)
        , textAlign left
        ]
    , class OverlayClose
        [ width (px 60)
        , height (px 60)
        , padding (px 18)
        , position absolute
        , top (px 0)
        , left (px 0)
        , descendants
            [ Elements.svg
                [ property "stroke" "#000"
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
