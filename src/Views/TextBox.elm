module Views.TextBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown exposing (toHtml)
import Messages exposing (..)
import Views.Switch


viewContents : String -> String -> Html Msg
viewContents c1 c2 =
    div
        [ class "TextBoxContents" ]
        [ div [ class "TextBoxContent" ]
            [ toHtml
                [ class "Static" ]
                c1
            ]
        , div
            [ class "TextBoxContent"
            ]
            [ toHtml
                [ class "Static"
                ]
                c2
            ]
        ]


viewNav : Bool -> Bool -> Html Msg
viewNav isRight isSwitchHidden =
    div
        [ classList
            [ ( "TextBoxSwitch", True )
            , ( "TextBoxSwitchHidden", isSwitchHidden )
            ]
        ]
        [ Views.Switch.view isRight ToggleQuirky
        ]


view : ( String, Maybe String ) -> Bool -> Html Msg
view ( c1, c2 ) isQuirky =
    div
        [ classList
            [ ( "TextBox", True )
            , ( "TextBoxDisplayPrimary", not isQuirky || c2 == Nothing )
            , ( "TextBoxDisplaySecondary", isQuirky && c2 /= Nothing )
            ]
        ]
        [ viewNav isQuirky (c2 == Nothing)
        , viewContents
            c1
            (c2 |> Maybe.withDefault "")
        ]
