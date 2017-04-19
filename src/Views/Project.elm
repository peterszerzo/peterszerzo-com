module Views.Project exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Html.Attributes exposing (src, alt, style, href)
import Html.CssHelpers
import Styles
import Models


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""


view : Models.Project -> Html msg
view project =
    a [ class [ Styles.Project ], href project.url ]
        [ div
            [ class [ Styles.ProjectImage ]
            , style
                [ ( "background-image", "url(" ++ project.imageUrl ++ ")" )
                ]
            ]
            []
        , h3 [] [ text project.title ]
        , p [] [ text project.description ]
        ]
