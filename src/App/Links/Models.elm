module Links.Models exposing (..)

import Routes.Models exposing (Route(..))

type alias SubLink = (String, String)

type Url = Internal Route | External String

type alias Link =
  { label : String
  , url : Url
  , subLinks : List SubLink
  }

getActiveSubLinks : (List Link) -> Route -> (List SubLink)
getActiveSubLinks links currentRoute =
  links
    |> List.filter (\lnk -> lnk.url == Internal currentRoute)
    |> List.head
    |> Maybe.map .subLinks
    |> Maybe.withDefault []

links : List Link
links =
  [ { label = "Recent Works"
    , url = Internal Projects
    , subLinks =
      [ ("Splyt Light", "http://splytlight.surge.sh")
      , ("ripsaw.js", "http://pickled-plugins.github.io/ripsaw-js")
      , ("CphRain", "http://cphrain.surge.sh")
      , ("Albatross", "http://albatross.surge.sh")
      , ("Liquid Lab", "http://pickled-plugins.github.io/liquidlab/#home")
      ]
    }
  , { label = "Blog"
    , url = External "http://blog.peterszerzo.com"
    , subLinks = []
    }
  , { label = "CV"
    , url = External "https://represent.io/peterszerzo"
    , subLinks = []
    }
  , { label = "Talks"
    , url = Internal Talks
    , subLinks =
      [ ("CSS@fireplace", "https://pickled-plugins.github.io/css-by-the-fireplace/")
      , ("Elm+friends", "https://pickled-plugins.github.io/practical-elm-and-friends/")
      ]
    }
  , { label = "About"
    , url = Internal About
    , subLinks = []
    }
  , { label = "Now"
    , url = Internal Now
    , subLinks = []
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
