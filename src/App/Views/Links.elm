module Views.Links exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Router exposing (Route(..), routeDefs, parseUrlFragment)
import Models exposing (Url(..))
import Content exposing (pages)


viewSecondaryLink : ( String, String ) -> Html a
viewSecondaryLink ( name, url ) =
    a
        [ href url
        ]
        [ text name
        ]


viewSecondaryLinks : String -> Route -> Html a
viewSecondaryLinks className currentRoute =
    let
        activeSubLinks =
            Models.getActivePage pages currentRoute
              |> .subLinks

        ( isHidden, subLinks ) =
            if (List.length activeSubLinks) == 0 then
                ( True, [] )
            else
                ( False, activeSubLinks )
    in
        div
            [ classList
                [ ( className, True )
                , ( className ++ "--hidden", isHidden )
                ]
            ]
            (List.map viewSecondaryLink subLinks)


viewMainLink className currentRoute { label, url, subLinks } =
    let
        ( variableAttr, htmlTag, isActive ) =
            case url of
                Internal pth ->
                    ( [ onClick
                            ( ChangePath (if parseUrlFragment routeDefs pth == currentRoute then "" else pth) )
                      ]
                    , div
                    , currentRoute == (parseUrlFragment routeDefs pth)
                    )

                External route ->
                    ( [ href route, target "_blank" ]
                    , a
                    , False
                    )

        attr =
            (classList
                [ ( className ++ "__link", True )
                , ( className ++ "__link--active", isActive )
                ]
            )
                :: variableAttr
    in
        htmlTag attr [ text label ]


viewMainLinks : String -> Route -> Html Msg
viewMainLinks className currentRoute =
    div
        [ class className
        ]
        (List.map (viewMainLink className currentRoute) pages)
