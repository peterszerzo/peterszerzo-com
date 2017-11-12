module Views.ContentBox exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Views.Switch
import Views.Shapes
import Views.ContentBox.Styles exposing (CssClasses(..), localClass, localClassList)


view : ( List (Html Msg), Maybe (List (Html Msg)) ) -> Bool -> Html Msg
view ( c1, c2 ) isQuirky =
    div
        [ localClassList
            [ ( Root, True )
            , ( DisplayPrimary, not isQuirky || c2 == Nothing )
            , ( DisplaySecondary, isQuirky && c2 /= Nothing )
            ]
        ]
        [ div
            [ localClass [ BackLink ]
            , onClick (ChangePath "")
            ]
            [ Views.Shapes.smallLogo
            ]
        , div
            [ localClassList
                [ ( Switch, True )
                , ( SwitchHidden, (c2 == Nothing) )
                ]
            , onClick ToggleQuirky
            ]
            [ Views.Switch.view isQuirky NoOp
            ]
        , div
            [ localClass [ Contents ] ]
            [ div [ localClass [ Content ] ] c1
            , c2
                |> Maybe.map (div [ localClass [ Content ] ])
                |> Maybe.withDefault (div [ localClass [ Content ] ] [])
            ]
        ]
