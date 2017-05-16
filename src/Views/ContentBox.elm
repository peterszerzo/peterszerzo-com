module Views.ContentBox exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Views.Switch
import Views.ContentBox.Styles exposing (CssClasses(..), localClass, localClassList)


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


view : ( List (Html Msg), Maybe (List (Html Msg)) ) -> Bool -> Html Msg
view ( c1, c2 ) isQuirky =
    div
        [ localClassList
            [ ( Root, True )
            , ( DisplayPrimary, not isQuirky || c2 == Nothing )
            , ( DisplaySecondary, isQuirky && c2 /= Nothing )
            ]
        ]
        [ viewNav isQuirky (c2 == Nothing)
        , div
            [ localClass [ Contents ] ]
            [ div [ localClass [ Content ] ] c1
            , c2
                |> Maybe.map (div [ localClass [ Content ] ])
                |> Maybe.withDefault (div [ localClass [ Content ] ] [])
            ]
        ]
