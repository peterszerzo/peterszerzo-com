module Views.Project exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Html.Attributes exposing (class, src, alt, style, href)
import Models


view : Models.Project -> Html msg
view project =
    a [ class "Project", href project.url ]
        [ div
            [ class "ProjectImage"
            , style
                [ ( "background-image", "url(" ++ project.imageUrl ++ ")" )
                ]
            ]
            []
        , h3 [] [ text project.title ]
        , p [] [ text project.description ]
        ]
