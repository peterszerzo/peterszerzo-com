module Views.TextBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown exposing (toHtml)
import Messages exposing (..)
import Views.Switch


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


viewNav : Bool -> Bool -> Html Msg
viewNav isRight isSwitchHidden =
    div
        [ classList
            [ ( "text-box__switch", True )
            , ( "text-box__switch--hidden", isSwitchHidden )
            ]
        ]
        [ Views.Switch.view isRight ToggleQuirky
        ]


view : ( String, Maybe String ) -> Bool -> Html Msg
view ( c1, c2 ) isQuirky =
    div
        [ classList
            [ ( "text-box", True )
            , ( "text-box--primary-displayed", not isQuirky || c2 == Nothing )
            , ( "text-box--secondary-displayed", isQuirky && c2 /= Nothing )
            ]
        ]
        [ viewNav isQuirky (c2 == Nothing)
        , viewContents
            c1
            (c2 |> Maybe.withDefault "")
        ]
