module Views.Banner exposing (..)

import Html exposing (Html, div, text, h1, p, header, node)
import Html.CssHelpers
import Content
import Styles
import Views.Shapes exposing (logo)


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""


view : Html msg
view =
    div
        [ class [ Styles.Banner ]
        ]
        [ div
            [ class [ Styles.BannerLogo ]
            ]
            [ logo
            , div []
                []
            ]
        , h1 [] [ text Content.title ]
        , p [] [ text Content.subtitle ]
        ]
