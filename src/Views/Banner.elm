module Views.Banner exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Content
import Views.Shapes exposing (logo)
import Views.Banner.Styles exposing (CssClasses(..), localClass)


view : Html msg
view =
    div
        [ localClass [ Root ]
        ]
        [ div
            [ localClass [ Logo ]
            ]
            [ logo
            , div []
                []
            ]
        , h1 [] [ text Content.title ]
        , p [] [ text Content.subtitle ]
        ]
