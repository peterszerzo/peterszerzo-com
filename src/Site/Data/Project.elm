module Site.Data.Project exposing (Project)


type alias Project =
    { id : String
    , name : String
    , url : String
    , image : String
    , description : String
    , size : Int
    }
