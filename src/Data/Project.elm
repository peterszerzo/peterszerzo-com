module Data.Project exposing (..)


type alias Project =
    { name : String
    , url : String
    , description : String
    , roles : List String
    , technologies : List String
    , size : Int
    }
