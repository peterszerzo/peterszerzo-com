module Data.Navigation exposing (..)

import Models exposing (Link, Url(..))
import Router exposing (Route(..))

links : List Link
links =
  [ { label = "Recent Works"
    , url = Internal Projects
    , subLinks =
        [ ("Lettero", "http://lettero.herokuapp.com/")
        , ("Splyt Light", "http://splytlight.surge.sh")
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
        [ ("ripsaw.js", "http://pickled-plugins.github.io/ripsaw-js")
        , ("Helicopters", "http://pickled-plugins.github.io/helicopter-ride/")
        , ("Pendants", "https://www.youtube.com/watch?v=0bKI3VSdD1g")
        , ("DChisel", "http://dchisel.herokuapp.com/")
        , ("PBA", "http://pickled-plugins.github.io/pba/")
        ]
    }
  ]
