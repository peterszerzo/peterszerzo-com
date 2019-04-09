module Maddi.Data.Project exposing (GroupedProject, Project, findById)

import Maddi.Data.Image as Image


type alias Project =
    { id : String
    , title : String
    , tags : List String
    , openedAt : ( Int, Int, Int )
    , content : String
    , thumbnailImg : Maybe String
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
