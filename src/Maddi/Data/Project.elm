module Maddi.Data.Project exposing (GroupedProject, Project, findById, placeholder)

import Maddi.Data.Image as Image


type alias Project =
    { id : String
    , title : String
    , tags : List String
    , institution : String
    , openedAt : ( Int, Int, Int )
    , content : String
    , imgs : List Image.Image
    }


type alias GroupedProject =
    { title : String
    , projects : List Project
    }


findById : String -> List GroupedProject -> Maybe Project
findById projectId groupedProjects =
    case groupedProjects of
        [] ->
            Nothing

        groupedProjectsHead :: groupedProjectsTail ->
            case
                groupedProjectsHead.projects
                    |> List.filter (\project -> project.id == projectId)
                    |> List.head
            of
                Just project ->
                    Just project

                Nothing ->
                    findById projectId groupedProjectsTail


placeholder : Project
placeholder =
    { id = ""
    , title = ""
    , institution = ""
    , tags = []
    , openedAt = ( 2018, 1, 1 )
    , content = ""
    , imgs = []
    }
