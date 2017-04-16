module Views.Banner exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.Attributes exposing (class, classList, src, href, attribute, style)
import Content
import Views.Shapes exposing (logo)


view : Html msg
view =
    div
        [ class "Banner"
        ]
        [ div
            [ class "BannerLogo"
            ]
            [ logo
            , div [ class "BannerImage" ]
                []
            ]
        , h1 [] [ text Content.title ]
        , p [] [ text Content.subtitle ]
        ]
