module Links.Models exposing (..)

import Main.Models exposing (Route(..))
import Data.Links exposing (projects, talks)

type alias SubLink = (String, String)

type Url = Internal Route | External String

type alias Link =
  { label : String
  , url : Url
  , subLinks : List SubLink
  }

links : List Link
links =
  [ { label = "Projects"
    , url = Internal Projects
    , subLinks = projects
    }
  , { label = "Blog"
    , url = External "http://blog.peterszerzo.com"
    , subLinks = []
    }
  , { label = "About"
    , url = Internal About
    , subLinks = []
    }
  , { label = "Now"
    , url = Internal Now
    , subLinks = []
    }
  , { label = "Talks"
    , url = Internal Talks
    , subLinks = talks
    }
  ]
