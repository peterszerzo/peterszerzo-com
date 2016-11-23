module Views.TextBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Router exposing (Route(..))
import Messages exposing (..)
import Models exposing (Mode(..))
import Views.Shapes.Arrow as Arrow
import Views.Switch
import Models exposing (SwitchPosition(..))
import Content.Pages exposing (pages)


viewContents : String -> String -> Html Msg
viewContents conventional real =
    div
        [ class "text-box__contents" ]
        [ div [ class "text-box__content" ]
            [ toHtml
                [ class "static" ]
                conventional
            ]
        , div
            [ class "text-box__content"
            ]
            [ toHtml
                [ class "static"
                ]
                real
            ]
        ]


viewNav : Models.Model -> Html Msg
viewNav model =
    let
        switchModel =
            if model.mode == Conventional then
                Left
            else
                Right

        isSwitchHidden =
            model.route /= About
    in
        div
            [ class "text-box-nav"
            ]
            [ div
                [ class "text-box-nav__home-link"
                , onClick (ChangePath "")
                ]
                [ Arrow.view
                ]
            , div
                [ classList
                    [ ( "text-box-nav__switch", True )
                    , ( "text-box-nav__switch--hidden", isSwitchHidden )
                    ]
                ]
                [ Views.Switch.view switchModel ToggleMode
                ]
            ]


view : Models.Model -> Html Msg
view model =
  let
    activePage = Models.getActivePage pages model.route
  in
        div
            [ classList
                [ ( "text-box", True )
                , ( "text-box--hidden", (activePage.conventionalContent == Nothing) )
                , ( "text-box--primary-displayed", model.mode == Conventional )
                , ( "text-box--secondary-displayed", model.mode == Real && (activePage.realContent /= Nothing) )
                ]
            ]
            [ viewNav model
            , viewContents
                (activePage.conventionalContent |> Maybe.withDefault "")
                (activePage.realContent |> Maybe.withDefault "")
            ]
