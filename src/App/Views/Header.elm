module Views.Header exposing (..)

import Html exposing (Html, header, div)
import Html.Attributes exposing (classList, attribute, class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Views.Links exposing (viewMainLinks)
import Views.Shapes.Falafel as Falafel
import Views.Shapes.SmallLogo as SmallLogo
import Models exposing (Model)
import Router


view : Model -> Html Msg
view model =
    let
        currentPath =
            Router.routeToSlug model.route

        isHome =
            model.route == Router.Home
    in
        header
            [ classList
                [ ( "header", True )
                , ( "header--discrete", isHome )
                ]
            ]
            [ div
                [ class "header__icon header__logo"
                , onClick
                    (ChangePath "")
                ]
                [ SmallLogo.view ]
            , viewMainLinks currentPath "header__desktop-links" "header__desktop-link"
            , div
                [ class "header__icon header__falafel"
                , onClick
                    (ChangePath
                        (if model.route == Router.Menu then
                            ""
                         else
                            "menu"
                        )
                    )
                ]
                [ Falafel.view True
                ]
            ]
