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
                    [ ( className ++ "__link", True )
                    , ( className ++ "__link--active", currentSlug == Just slug )
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
                            (ChangePath
                                (if currentSlug == Just slug then
                                    ""
                                 else
                                    slug
                                )
                            )
                        ]
                   )
            )
            [ text label ]


viewMainLinks : Maybe String -> String -> Html Msg
viewMainLinks currentPath className =
    div
        [ class className
        ]
        (List.map (viewMainLink currentPath className) Content.mainLinks)
