module Views.MobileNav exposing (..)

import Html exposing (Html, div, nav)
import Html.Attributes exposing (classList, class, attribute)
import Html.Events exposing (onClick)
import Router exposing (Route(..))
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks, viewSecondaryLinks)
import Views.Shapes.Falafel as Falafel
import Views.Shapes.Arrow as Arrow


view model =
    nav
        [ classList
            [ ( "mobile-nav", True )
            , ( "mobile-nav--active", model.isMobileNavActive )
            ]
        , attribute "role" "navigation"
        ]
        [ div
            [ class "mobile-nav__toggle"
            , onClick ToggleMobileNav
            ]
            [ Falafel.view (not model.isMobileNavActive)
            ]
        , div
            [ classList
                [ ( "mobile-nav__content", True )
                , ( "mobile-nav__content--at-second-tab", List.member model.route [ Projects, Talks, Archive ] )
                ]
            ]
            [ div
                [ class "mobile-nav__tab"
                ]
                [ viewMainLinks "mobile-main-links" model.route
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
                    , viewSecondaryLinks "mobile-secondary-links" model.route
                    ]
                ]
            ]
        ]
