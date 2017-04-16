module Views.ProjectBox exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Html.Attributes exposing (class, src, alt, style, href)
import Messages exposing (Msg)
import Models
import Views.Project


view : List Models.Project -> Html Msg
view projects =
    div
        [ class "ProjectBox" ]
        [ div [ class "ProjectBoxContent" ]
            (List.map Views.Project.view projects)
        ]