module Views.Projects exposing (..)

import Html exposing (Html, div, h1, p, header, node)
import Html.Attributes exposing (style)
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
import Messages exposing (Msg)


type alias Config =
    { projects : List Project.Project
    , packBubbles : List PackBubble.PackBubble
    , active : Maybe String
    }


view : Config -> Html Msg
view { projects, packBubbles, active } =
    div
        [ localClass [ Root ]
        ]
    <|
        List.map2
            (\project { x, y, r } ->
                let
                    shape =
                        case project.name of
                            "elm-gameroom" ->
                                Shapes.elmGameroom

                            "ripsaw" ->
                                Shapes.ripsaw

                            "nlx" ->
                                Shapes.nlx

                            "The Seed" ->
                                Shapes.theseed

                            _ ->
                                Shapes.ripsaw
                in
                    div
                        [ localClass [ Bubble ]
                        , style
                            [ ( "width", (floor (2 * r) |> toString) ++ "px" )
                            , ( "height", (floor (2 * r) |> toString) ++ "px" )
                            , ( "top", (floor (y - r) |> toString) ++ "px" )
                            , ( "left", (floor (x - r) |> toString) ++ "px" )
                            ]
                        ]
                        [ shape ]
            )
            projects
            packBubbles


cssNamespace : String
cssNamespace =
    "Projects"


type CssClasses
    = Root
    | Bubble


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
        , border3 (px 4) solid blue
        , backgroundColor white
        , property "box-shadow" "3px 6px 18px rgba(0, 0, 0, 0.3)"
        , property "transition" "box-shadow 0.3s"
        , hover
            [ property "box-shadow" "3px 6px 18px rgba(0, 0, 0, 0.6)"
            ]
        , descendants
            [ Elements.svg
                [ width (pct 60)
                , height (pct 60)
                , marginTop (pct 20)
                , marginLeft (pct 0)
                , fill black
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
