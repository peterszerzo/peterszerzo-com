module Links.Models exposing (..)

import Routes.Models exposing (Route(..))

type alias SubLink = (String, String)

type Url = Internal Route | External String

type alias Link =
  { label : String
  , url : Url
  , subLinks : List SubLink
  }

getActiveSubLinks links model =
  links
  |> List.filter (\lnk -> lnk.url == Internal model.route)
  |> List.head
  |> Maybe.map .subLinks
  |> Maybe.withDefault []

links : List Link
links =
  [ { label = "Projects"
    , url = Internal Projects
    , subLinks =
      [ ("Albatross", "http://albatross.surge.sh")
      , ("Slides, MD.", "https://github.com/pickled-plugins/slides-md")
      , ("ripsaw.js", "http://pickled-plugins.github.io/ripsaw-js")
      , ("Liquid Lab", "http://pickled-plugins.github.io/liquidlab/#home")
      ]
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
    , subLinks =
      [ ("CphFront 1", "https://pickled-plugins.github.io/css-by-the-fireplace/")
      , ("CphFront 2", "https://pickled-plugins.github.io/practical-elm-and-friends/")
      ]
    }
  , { label = "Archive"
    , url = Internal Archive
    , subLinks =
      [ ("Helicopters", "http://pickled-plugins.github.io/helicopter-ride/")
      , ("Pendants", "https://www.youtube.com/watch?v=0bKI3VSdD1g")
      , ("DChisel", "http://dchisel.herokuapp.com/")
      , ("PBA", "http://pickled-plugins.github.io/pba/")
      ]
    }
  ]
