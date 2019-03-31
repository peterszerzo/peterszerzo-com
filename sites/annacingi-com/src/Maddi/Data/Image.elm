module Maddi.Data.Image exposing (Image)


type alias Image =
    { url : String
    , alt : String
    , credit : Maybe String
    }
