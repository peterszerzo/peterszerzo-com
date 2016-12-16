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


viewNav : Models.Mode -> Html Msg
viewNav mode =
    let
        switchModel =
            if mode == Conventional then
                Left
            else
                Right

        isSwitchHidden =
            False
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


view : ( Maybe String, Maybe String ) -> Models.Mode -> Html Msg
view ( c1, c2 ) mode =
    div
        [ classList
            [ ( "text-box", True )
            , ( "text-box--hidden", (c1 == Nothing) )
            , ( "text-box--primary-displayed", mode == Conventional )
            , ( "text-box--secondary-displayed", mode == Real && (c1 /= Nothing) )
            ]
        ]
        [ viewNav mode
        , viewContents
            (c1 |> Maybe.withDefault "")
            (c2 |> Maybe.withDefault "")
        ]
