module Maddi.Content exposing (about, projects)

import Maddi.Data.Project as Project


about : String
about =
    """
# About

My name is Anna. I design sets for theatre pieces like [Karmafulminien](/projects/karmafulminien) and [Story of Qu](/projects/story-of-qu), and I also work in opera.

I studied at Accademia di Brera, trained at Teatro alla Scala, currently based in Reggio Emilia and Milan, traveling across Italy with brief escapades to New York, Sydney, and wherever next.
"""


projects : List Project.Project
projects =
    [ { id = "karmafulminien"
      , title = "Karmafulminien"
      , institution = "Teatro Della Tosse"
      , openedAt = ( 2014, 11, 3 )
      , content = """
# Karmafulminien

Original play by Generazione Disagio (Luca Mammoli, Enrico Pittaluga, Graziano Sirressi), directed and co-written by Riccardo Pippa, produced by Fondazione Luzzati - Teatro della Tosse. First played November 3rd 2015 in, Teatro della Tosse, Genoa // [trailer](https://vimeo.com/148718410).

**Role:** Set, costume and props designer

**Photo credits:** Laura Granelli, Luca Riccio
        """
      , imgs =
            [ ( "/maddi/karmafulminien-stage-1.jpg", "Karmafulminien Stage 1" )
            , ( "/maddi/karmafulminien-rendering.jpg", "Karmafulminien rendering" )
            , ( "/maddi/karmafulminien-stage-2.jpg", "Karmafulminien Stage 2" )
            , ( "/maddi/karmafulminien-stage-3.jpg", "Karmafulminien Stage 3" )
            , ( "/maddi/karmafulminien-stage-4.jpg", "Karmafulminien Stage 4" )
            , ( "/maddi/karmafulminien-stage-5.jpg", "Karmafulminien Stage 5" )
            , ( "/maddi/karmafulminien-stage-6.jpg", "Karmafulminien Stage 6" )
            ]
      }
    , { id = "story-of-qu"
      , title = "Story of Qu"
      , institution = "Piccolo Teatro"
      , openedAt = ( 2017, 1, 1 )
      , content = """
# Story of Qu

Original play by Dario Fo and Franca Rame, directed by Massimo Navone. Opening in September 24th 2014, Piccolo Teatro Studio Melato, Milan

**Role:** Set, costume and props designer

Awarded Premio Salon Brera-Bicocca in 2015, displayed in the International Art Academies Exihibition (Beijing, September 2015).

**Photo credits:** Pino Montisci
        """
      , imgs =
            [ ( "/maddi/story-of-qu-stage-2.jpg", "Story of Qu, Stage 2" )
            , ( "/maddi/story-of-qu-model-2.jpg", "Story of Qu, Model 2" )
            , ( "/maddi/story-of-qu-model-3.jpg", "Story of Qu, Model 3" )
            , ( "/maddi/story-of-qu-model-4.jpg", "Story of Qu, Model 4" )
            , ( "/maddi/story-of-qu-stage-1.jpg", "Story of Qu, Stage 1" )
            ]
      }
    , { id = "ernani"
      , title = "Ernani"
      , institution = "La Scala"
      , openedAt = ( 2018, 9, 29 )
      , content = """
# Ernani
    """
      , imgs =
            []
      }
    ]
