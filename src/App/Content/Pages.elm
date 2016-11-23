module Content.Pages exposing (..)

import Content.Text as Txt
import Models exposing (Url(..))


pages : List Models.Page
pages =
    [ { label = "Recent Works"
      , url = Internal "projects"
      , subLinks =
            [ ( "Lettero", "https://lettero.co" )
            , ( "Splyt Light", "http://splytlight.surge.sh" )
            , ( "CphRain", "http://cphrain.surge.sh" )
            , ( "Albatross", "http://albatross.surge.sh" )
            , ( "Liquid Lab", "http://pickled-plugins.github.io/liquidlab/#home" )
            ]
      , conventionalContent = Nothing
      , realContent = Nothing
      }
    , { label = "Blog"
      , url = External "http://blog.peterszerzo.com"
      , subLinks = []
      , conventionalContent = Nothing
      , realContent = Nothing
      }
    , { label = "CV"
      , url = External "https://represent.io/peterszerzo"
      , subLinks = []
      , conventionalContent = Nothing
      , realContent = Nothing
      }
    , { label = "Talks"
      , url = Internal "talks"
      , subLinks =
            [ ( "CSS@fireplace", "https://pickled-plugins.github.io/css-by-the-fireplace/" )
            , ( "Elm+friends", "https://pickled-plugins.github.io/practical-elm-and-friends/" )
            ]
      , conventionalContent = Nothing
      , realContent = Nothing
      }
    , { label = "About"
      , url = Internal "about"
      , subLinks = []
      , conventionalContent = Just Txt.aboutConventional
      , realContent = Just Txt.aboutReal
      }
    , { label = "Now"
      , url = Internal "now"
      , subLinks = []
      , conventionalContent = Just Txt.now
      , realContent = Nothing
      }
    , { label = "Archive"
      , url = Internal "archive"
      , subLinks =
            [ ( "ripsaw.js", "http://pickled-plugins.github.io/ripsaw-js" )
            , ( "Helicopters", "http://pickled-plugins.github.io/helicopter-ride/" )
            , ( "Pendants", "https://www.youtube.com/watch?v=0bKI3VSdD1g" )
            , ( "DChisel", "http://dchisel.herokuapp.com/" )
            , ( "PBA", "http://pickled-plugins.github.io/pba/" )
            ]
      , conventionalContent = Nothing
      , realContent = Nothing
      }
    ]
