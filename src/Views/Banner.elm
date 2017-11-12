module Views.Banner exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Content
import Views.Shapes exposing (logo)
import Views.Banner.Styles exposing (CssClasses(..), localClass)
import Views.Nav
import Messages exposing (Msg)


view : Html Msg
view =
    div
        [ localClass [ Root ]
        ]
        [ div [ localClass [ Content ] ]
            [ div
                [ localClass [ Logo ]
                ]
                [ logo
                , div []
                    []
                ]
            , h1 [] [ text Content.title ]
            , p [ localClass [ Subtitle ] ] [ text Content.subtitle ]
            ]
        , Views.Nav.view
        ]
