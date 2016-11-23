module Views.DesktopNav exposing (..)

import Html exposing (Html, nav)
import Html.Attributes exposing (classList, attribute)
import Models
import Messages exposing (Msg)
import Views.Links exposing (viewMainLinks, viewSecondaryLinks)
import Models
import Content.Pages exposing (pages)


view : Models.Model -> Html Msg
view model =
    nav
        [ attribute "role" "navigation"
        , classList
            [ ( "desktop-nav", True )
            , ( "desktop-nav--expanded", List.length (Models.getActivePage pages model.route |> .subLinks) > 0 )
            ]
        ]
        [ viewMainLinks "main-links" model.route
        , viewSecondaryLinks "link-box" model.route
        ]
