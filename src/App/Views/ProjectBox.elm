module Views.ProjectBox exposing (..)

import Html exposing (Html, text, div, h2, p, img)
import Html.Attributes exposing (class, src, alt, style)
import Messages exposing (Msg)
import Models


viewProject : Models.Project -> Html Msg
viewProject project =
    div [ class "project" ]
        [ div [ class "project__image", style [ ( "background-image", "url(" ++ project.imageUrl ++ ")" ) ] ]
            []
        , h2 [] [ text project.title ]
        , p [] [ text project.description ]
        ]


view : List Models.Project -> Html Msg
view projects =
    div
        [ class "project-box" ]
        [ div [ class "project-box__content" ]
            (List.map viewProject projects)
        ]
