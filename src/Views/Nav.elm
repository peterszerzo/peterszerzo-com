module Views.Nav exposing (..)

import Html exposing (Html, div, text, h1, p, nav, node, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Content
import Views.Nav.Styles exposing (CssClasses(..), localClass, localClassList)


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
            [ text label ]


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
