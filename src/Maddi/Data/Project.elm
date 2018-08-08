module Maddi.Data.Project exposing (Project, placeholder)


type alias Project =
    { id : String
    , title : String
    , institution : String
    , openedAt : ( Int, Int, Int )
    , content : String
    , imgs : List ( String, String )
    }


placeholder : Project
placeholder =
    { id = ""
    , title = ""
    , institution = ""
    , openedAt = ( 2018, 1, 1 )
    , content = ""
    , imgs = []
    }
