module Views.Project exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Html.Attributes exposing (src, alt, style, href)
import Models
import Views.Project.Styles exposing (CssClasses(..), localClass)


view : Models.Project -> Html msg
view project =
    a [ localClass [ Root ], href project.url ]
        [ div
            [ localClass [ Image ]
            , style
                [ ( "background-image", "url(" ++ project.imageUrl ++ ")" )
                ]
            ]
            []
        , h3 [] [ text project.title ]
        , p [] [ text project.description ]
        ]
