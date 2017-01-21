module Views.Links exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Content exposing (mainLinks)


viewMainLink : Maybe String -> String -> ( String, String ) -> Html Msg
viewMainLink currentSlug className ( label, url ) =
    let
        isExternalLink =
            String.slice 0 4 url == "http"

        slug =
            String.dropLeft 1 url
    in
        a
            ([ (classList
                    [ ( className, True )
                    , ( className ++ "--active", currentSlug == Just slug )
                    ]
               )
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


viewMainLinks : Maybe String -> String -> String -> Html Msg
viewMainLinks currentPath containerClassName linkClassName =
    div
        [ class containerClassName
        ]
        (List.map (viewMainLink currentPath linkClassName) Content.mainLinks)
