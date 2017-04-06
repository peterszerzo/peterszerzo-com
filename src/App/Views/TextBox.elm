module Views.TextBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown exposing (toHtml)
import Messages exposing (..)
import Models exposing (Mode(..))
import Views.Switch
import Models exposing (SwitchPosition(..))


viewContents : String -> String -> Html Msg
viewContents c1 c2 =
    div
        [ class "text-box__contents" ]
        [ div [ class "text-box__content" ]
            [ toHtml
                [ class "Static" ]
                c1
            ]
        , div
            [ class "text-box__content"
            ]
            [ toHtml
                [ class "Static"
                ]
                c2
            ]
        ]


viewNav : Models.Mode -> Bool -> Html Msg
viewNav mode isSwitchHidden =
    let
        switchModel =
            if mode == Conventional then
                Left
            else
                Right
    in
        div
            [ classList
                [ ( "text-box__switch", True )
                , ( "text-box__switch--hidden", isSwitchHidden )
                ]
            ]
            [ Views.Switch.view switchModel ToggleMode
            ]


view : ( String, Maybe String ) -> Models.Mode -> Html Msg
view ( c1, c2 ) mode =
    div
        [ classList
            [ ( "text-box", True )
            , ( "text-box--primary-displayed", mode == Conventional || c2 == Nothing )
            , ( "text-box--secondary-displayed", mode == Real && c2 /= Nothing )
            ]
        ]
        [ viewNav mode (c2 == Nothing)
        , viewContents
            c1
            (c2 |> Maybe.withDefault "")
        ]
