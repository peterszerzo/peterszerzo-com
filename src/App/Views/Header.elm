module Views.Header exposing (..)

import Html exposing (Html, header, div)
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
        header
            [ classList
                [ ( "header", True )
                , ( "header--discrete", isDiscrete )
                ]
            ]
            [ viewMainLinks currentPath "header__desktop-links" "header__desktop-link"
            , div
                [ class "header__falafel"
                , onClick (ChangePath "/menu")
                ]
                [ Falafel.view True
                ]
            ]
