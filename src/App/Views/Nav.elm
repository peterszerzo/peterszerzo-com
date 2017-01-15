module Views.Nav exposing (..)

import Html exposing (Html, nav, div)
import Html.Attributes exposing (classList, attribute, class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks)
import Views.Shapes.Falafel as Falafel
import Models exposing (Model)
import Router


view : Model -> Html Msg
view model =
    let
        currentPath =
            Router.routeToSlug model.route

        isDiscrete =
            model.route == Router.Home
    in
        nav
            [ classList
                [ ( "nav", True )
                , ( "nav--discrete", isDiscrete )
                ]
            ]
            [ viewMainLinks currentPath "nav__desktop-links" "nav__desktop-link"
            , div
                [ class "nav__falafel"
                , onClick ToggleMobileNav
                ]
                [ Falafel.view (not model.isMobileNavActive)
                ]
            , div
                [ classList
                    [ ( "mobile-nav", True )
                    , ( "mobile-nav--active", model.isMobileNavActive )
                    ]
                ]
                [ viewMainLinks currentPath "mobile-main-links" "mobile-main-links__link"
                ]
            ]
