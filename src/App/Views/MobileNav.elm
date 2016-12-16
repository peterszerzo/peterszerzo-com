module Views.MobileNav exposing (..)

import Html exposing (Html, div, nav)
import Html.Attributes exposing (classList, class, attribute)
import Html.Events exposing (onClick)
import Router exposing (Route(..))
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks, viewSublinks)
import Views.Shapes.Falafel as Falafel
import Views.Shapes.Arrow as Arrow


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
                , ( "mobile-nav__content--at-second-tab", sublinks /= Nothing )
                ]
            ]
            [ div
                [ class "mobile-nav__tab"
                ]
                [ viewMainLinks currentPath "mobile-main-links" sublinks
                ]
            , div
                [ class "mobile-nav__tab"
                ]
                [ div [ class "mobile-nav__tab-content" ]
                    [ div
                        [ class "mobile-nav__back"
                        , onClick (ChangePath "")
                        ]
                        [ Arrow.view
                        ]
                    , viewSublinks currentPath "mobile-secondary-links" sublinks
                    ]
                ]
            ]
        ]
