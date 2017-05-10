module Views.Menu exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Models exposing (Model)
import Router
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks)
import Views.Menu.Styles exposing (CssClasses(..), localClass)


view : Model -> Html Msg
view model =
    let
        currentPath =
            Router.routeToSlug model.route
    in
        div
            [ localClass [ Root ]
            ]
            [ viewMainLinks currentPath "menuLinks" "menuLink"
            ]
