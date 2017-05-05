module Views.TextBox exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Views.Switch
import Views.Static
import Views.TextBox.Styles exposing (CssClasses(..), localClass, localClassList)


viewContents : String -> String -> Html Msg
viewContents c1 c2 =
    div
        [ localClass [ Contents ] ]
        [ div [ localClass [ Content ] ]
            [ Views.Static.view c1
            ]
        , div [ localClass [ Content ] ]
            [ Views.Static.view c2
            ]
        ]


viewNav : Bool -> Bool -> Html Msg
viewNav isRight isSwitchHidden =
    div
        [ localClassList
            [ ( Switch, True )
            , ( SwitchHidden, isSwitchHidden )
            ]
        ]
        [ Views.Switch.view isRight ToggleQuirky
        ]


view : ( String, Maybe String ) -> Bool -> Html Msg
view ( c1, c2 ) isQuirky =
    div
        [ localClassList
            [ ( Root, True )
            , ( DisplayPrimary, not isQuirky || c2 == Nothing )
            , ( DisplaySecondary, isQuirky && c2 /= Nothing )
            ]
        ]
        [ viewNav isQuirky (c2 == Nothing)
        , viewContents
            c1
            (c2 |> Maybe.withDefault "")
        ]
