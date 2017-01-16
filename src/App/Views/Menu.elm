module Views.Menu exposing (..)

import Html exposing (Html, nav, div)
import Html.Attributes exposing (classList, attribute, class)
import Models exposing (Model)
import Messages exposing (Msg)
import Views.Links exposing (viewMainLinks)
import Router


view : Model -> Html Msg
view model =
    let
        currentPath =
            Router.routeToSlug model.route
    in
        div
            [ classList
                [ ( "menu", True )
                ]
            ]
            [ viewMainLinks currentPath "menu" "menu__link"
            ]
