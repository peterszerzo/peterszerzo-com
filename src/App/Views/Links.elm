module Views.Links exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Content exposing (mainLinks)


viewSublink : ( String, String ) -> Html Msg
viewSublink ( name, url ) =
    a
        [ href url
        ]
        [ text name
        ]


viewSublinks : Maybe String -> String -> Maybe (List ( String, String )) -> Html Msg
viewSublinks currentPath className sublinks =
    div
        [ classList
            [ ( className, True )
            , ( className ++ "--hidden", sublinks == Nothing )
            ]
        ]
        (List.map viewSublink (sublinks |> Maybe.withDefault []))


viewMainLink : Maybe String -> String -> Maybe (List ( String, String )) -> ( String, String ) -> Html Msg
viewMainLink currentSlug className sublinks ( label, url ) =
    let
        isExternalLink =
            String.slice 0 4 url == "http"

        slug =
            String.dropLeft 1 url
    in
        (if isExternalLink then
            a
         else
            div
        )
            [ (classList
                [ ( className ++ "__link", True )
                , ( className ++ "__link--active", currentSlug == Just slug )
                ]
              )
            , if isExternalLink then
                (href url)
              else
                (onClick
                    (ChangePath
                        (if currentSlug == Just slug then
                            ""
                         else
                            slug
                        )
                    )
                )
            ]
            [ text label ]


viewMainLinks : Maybe String -> String -> Maybe (List ( String, String )) -> Html Msg
viewMainLinks currentPath className sublinks =
    div
        [ class className
        ]
        (List.map (viewMainLink currentPath className sublinks) Content.mainLinks)
