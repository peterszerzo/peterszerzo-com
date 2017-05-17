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
        , div []
            [ h3 [ localClass [ Title ] ] [ text project.title ]
            , text " | "
            , p [ localClass [ Body ] ] [ text project.description ]
            ]
        ]
