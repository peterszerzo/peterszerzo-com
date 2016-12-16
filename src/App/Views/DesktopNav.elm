module Views.DesktopNav exposing (..)

import Html exposing (Html, nav)
import Html.Attributes exposing (classList, attribute)
import Models
import Messages exposing (Msg)
import Views.Links exposing (viewMainLinks, viewSublinks)
import Models


view : Maybe String -> Maybe (List ( String, String )) -> Html Msg
view currentPath sublinks =
    nav
        [ attribute "role" "navigation"
        , classList
            [ ( "desktop-nav", True )
            , ( "desktop-nav--expanded", sublinks /= Nothing )
            ]
        ]
        [ viewMainLinks currentPath "main-links" sublinks
        , viewSublinks currentPath "link-box" sublinks
        ]
