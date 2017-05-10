module Views.Header exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.Events exposing (onClick)
import Models exposing (Model)
import Router
import Messages exposing (Msg(..))
import Views.Shapes exposing (logo, smallLogo, falafel, close)
import Views.Links exposing (viewMainLinks)
import Views.Header.Styles exposing (CssClasses(..), localClass, localClassList)


view : Model -> Html Msg
view model =
    let
        currentPath =
            Router.routeToSlug model.route

        isHome =
            model.route == Router.Home
    in
        header
            [ localClassList
                [ ( Root, True )
                , ( Discrete, isHome )
                ]
            ]
            [ div
                [ localClass [ Icon, Logo ]
                , onClick
                    (ChangePath "")
                ]
                [ smallLogo ]
            , viewMainLinks currentPath "headerDesktopLinks" "headerDesktopLink"
            , div
                [ localClass [ Icon, Falafel ]
                , onClick
                    (ChangePath
                        (if model.route == Router.Menu then
                            ""
                         else
                            "menu"
                        )
                    )
                ]
                [ if (model.route == Router.Menu) then
                    close
                  else
                    falafel True
                ]
            ]
