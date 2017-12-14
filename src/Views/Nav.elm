module Views.Nav exposing (..)

import Html exposing (Html, div, h1, p, nav, node, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
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
             , href
                (if isExternalLink then
                    url
                 else
                    "javascript:void(0)"
                )
             ]
                ++ (if isExternalLink then
                        []
                    else
                        [ onClick
                            (ChangePath slug)
                        ]
                   )
            )
            [ Html.text label ]


viewMainLinks : Html Msg
viewMainLinks =
    div
        [ localClass [ DesktopLinks ]
        ]
        (List.map (viewMainLink) Content.mainLinks)


view : Html Msg
view =
    nav
        [ localClass
            [ Root
            ]
        ]
        [ viewMainLinks
        ]


cssNamespace : String
cssNamespace =
    "nav"


type CssClasses
    = Root
    | DesktopLinks
    | DesktopLink
    | DesktopLinkActive


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
        , displayFlex
        , position absolute
        , left (px 0)
        , bottom (px 36)
        , color blue
        , Mixins.zIndex 9
        , color white
        ]
    , class DesktopLinks
        [ width (pct 100)
        , margin2 (px 0) (px 10)
        , paddingTop (px 17)
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
        , property "background-color" "rgba(255, 255, 255, .2)"
        , margin (px 8)
        , property "transition" "all .3s"
        , hover
            [ color blue
            , opacity (num 1)
            , property "background-color" "rgba(255, 255, 255, 1)"
            ]
        ]
    ]
        |> namespace cssNamespace
