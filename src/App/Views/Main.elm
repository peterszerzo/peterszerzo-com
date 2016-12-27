module Views.Main exposing (..)

import Html exposing (Html, div, map)
import Html.Attributes exposing (class, src, href)
import Models exposing (Model, Mode(..), StandardPage(..), standardPage)
import Router
import Messages exposing (Msg(..))
import Views.DesktopNav
import Views.MobileNav
import Views.TextBox
import Views.Banner
import Views.Notification


view : Model -> Html Msg
view model =
    let
        currentSlug =
            Router.routeToSlug model.route

        ( textbox, sublinks ) =
            standardPage model
                |> Maybe.map
                    (\sp ->
                        case sp of
                            SublinkPage sublinks ->
                                ( ( Nothing, Nothing ), Just sublinks )

                            StaticPage content1 content2 ->
                                ( ( Just content1, content2 ), Nothing )
                    )
                |> Maybe.withDefault ( ( Nothing, Nothing ), Nothing )
    in
        div
            [ class "main"
            ]
            [ div
                [ class "main__content"
                ]
                [ Views.Banner.view
                ]
            , Views.TextBox.view textbox model.mode
            , Views.DesktopNav.view currentSlug sublinks
            , Views.Notification.view model
            , Views.MobileNav.view currentSlug model.isMobileNavActive sublinks
            ]
