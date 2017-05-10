module Views.ProjectBox exposing (..)

import Html exposing (Html, text, div, h3, p, img, a)
import Messages exposing (Msg)
import Models
import Views.Project
import Views.ProjectBox.Styles exposing (CssClasses(..), localClass)


view : List Models.Project -> Html Msg
view projects =
    div
        [ localClass [ Root ] ]
        [ div [ localClass [ Content ] ]
            (List.map Views.Project.view projects)
        ]
