module Views.DesktopNav exposing (..)

import Html exposing (Html, nav)
import Html.Attributes exposing (classList, attribute)
import Messages exposing (Msg)
import Views.Links exposing (viewMainLinks)


view : Maybe String -> Html Msg
view currentPath =
    nav
        [ attribute "role" "navigation"
        , classList
            [ ( "desktop-nav", True )
            ]
        ]
        [ viewMainLinks currentPath "main-links"
        ]
