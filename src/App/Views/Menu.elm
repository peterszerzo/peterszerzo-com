module Views.Menu exposing (..)

import Html exposing (Html, nav, div)
import Html.Attributes exposing (attribute, class)
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
            [ class "menu"
            ]
            [ viewMainLinks currentPath "menu__links" "menu__link"
            ]
