module Views.ProjectBox exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Html.Attributes exposing (class, src, alt, style, href)
import Messages exposing (Msg)
import Models


viewProject : Models.Project -> Html Msg
viewProject project =
    a [ class "project", href project.url ]
        [ div [ class "project__image", style [ ( "background-image", "url(" ++ project.imageUrl ++ ")" ) ] ]
            []
        , h3 [] [ text project.title ]
        , p [] [ text project.description ]
        ]


view : List Models.Project -> Html Msg
view projects =
    div
        [ class "project-box" ]
        [ div [ class "project-box__content" ]
            (List.map viewProject projects)
        ]
