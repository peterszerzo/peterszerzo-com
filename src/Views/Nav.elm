module Views.Nav exposing (..)

import Json.Decode as Decode
import Html exposing (Html, div, h1, p, nav, node, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Html.CssHelpers
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins
import Messages exposing (Msg(..))
import Content


viewMainLink : ( String, String ) -> Html Msg
viewMainLink ( label, url ) =
    let
        isExternalLink =
            String.slice 0 4 url == "http" || String.slice 0 6 url == "mailto"

        slug =
            String.dropLeft 1 url
    in
        a
            ([ localClass [ DesktopLink ]
             , href url
             ]
                ++ (if isExternalLink then
                        []
                    else
                        [ onWithOptions "click"
                            { preventDefault = True, stopPropagation = False }
                            (Navigate slug |> Decode.succeed)
                        ]
                   )
            )
            [ Html.text label ]


view : Html Msg
view =
    nav
        [ localClass
            [ Root
            ]
        ]
        [ div
            [ localClass [ DesktopLinks ]
            ]
            (List.map viewMainLink Content.mainLinks)
        ]


cssNamespace : String
cssNamespace =
    "Nav"


type CssClasses
    = Root
    | DesktopLinks
    | DesktopLink


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ width (pct 100)
        , padding2 (px 0) (px 20)
        , maxWidth (px 420)
        , marginTop (px -55)
        , Mixins.zIndex 9
        , color white
        ]
    , class DesktopLinks
        [ width (pct 100)
        , textAlign center
        ]
    , class DesktopLink
        [ color white
        , display inlineBlock
        , cursor pointer
        , position relative
        , padding2 (px 4) (px 12)
        , borderRadius (px 3)
        , opacity (num 0.9)
        , fontSize (Css.rem 1)
        , letterSpacing (Css.rem 0.05)
        , property "font-kerning" "normal"
        , property "background-color" "rgba(255, 255, 255, .23)"
        , margin (px 8)
        , property "transition" "all .2s"
        , hover
            [ color blue
            , opacity (num 1)
            , property "background-color" "rgba(255, 255, 255, 1)"
            ]
        , focus
            [ outline none
            , property "box-shadow" "0 0 0 3px rgba(255, 255, 255, 0.5)"
            ]
        ]
    ]
        |> namespace cssNamespace
