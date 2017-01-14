module Views.MobileNav exposing (..)

import Html exposing (Html, div, nav)
import Html.Attributes exposing (classList, class, attribute)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks)
import Views.Shapes.Falafel as Falafel


view : Maybe String -> Bool -> Maybe (List ( String, String )) -> Html Msg
view currentPath isMobileNavActive sublinks =
    nav
        [ classList
            [ ( "mobile-nav", True )
            , ( "mobile-nav--active", isMobileNavActive )
            ]
        , attribute "role" "navigation"
        ]
        [ div
            [ class "mobile-nav__toggle"
            , onClick ToggleMobileNav
            ]
            [ Falafel.view (not isMobileNavActive)
            ]
        , div
            [ classList
                [ ( "mobile-nav__content", True )
                ]
            ]
            [ div
                [ class "mobile-nav__tab"
                ]
                [ viewMainLinks currentPath "mobile-main-links" sublinks
                ]
            ]
        ]
