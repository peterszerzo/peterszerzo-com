module Maddi.Content exposing (about, groupedProjects, navLinks)

import Maddi.Data.Project as Project


navLinks : List ( String, String )
navLinks =
    [ ( "/", "home" )
    , ( "/about", "about" )
    , ( "mailto:annamcingi@gmail.com", "contact" )
    ]


about : String
about =
    """
# About

My name is Anna. I design sets for theatre pieces like [Karmafulminien](/projects/karmafulminien) and [Story of Qu](/projects/story-of-qu), and I also work in opera.

I studied at Accademia di Brera, trained at Teatro alla Scala, currently based in Reggio Emilia and Milan, traveling across Italy with brief escapades to New York, Sydney, and wherever next.
"""


groupedProjects : List Project.GroupedProject
groupedProjects =
    [ { title = "Theatre"
      , projects =
            [ { id = "visite"
              , title = "Visite"
              , institution = "Teatro Franco Parenti"
              , tags = [ "set design" ]
              , openedAt = ( 2018, 11, 20 )
              , content = """
Produced by [Teatro Franco Parenti / Teatro dei Gordi](https://www.teatrodeigordi.it/spettacolo/visite/), opening November 20th, 2018.

Directed by Riccardo Pippa, actors Cecilia Campani, Giovanni Longhin, Andrea Panigatti, Sandro Pivotti, Maria Vittoria Scarlattei, Matteo Vitanza. Dramaturg Giulia Tollis.
        """
              , imgs =
                    [ { url = "/maddi/visite-1.jpg", alt = "Visite Promo 1", credit = Nothing }
                    , { url = "/maddi/visite-2.jpg", alt = "Visite Promo 2", credit = Nothing }
                    ]
              }
            , { id = "karmafulminien"
              , title = "Karmafulminien"
              , institution = "Teatro Della Tosse"
              , tags = [ "set design", "costume design" ]
              , openedAt = ( 2014, 11, 3 )
              , content = """
Original play by Generazione Disagio (Luca Mammoli, Enrico Pittaluga, Graziano Sirressi), directed and co-written by Riccardo Pippa, produced by Fondazione Luzzati - Teatro della Tosse. First played November 3rd 2015 in, Teatro della Tosse, Genoa // [trailer](https://vimeo.com/148718410).
        """
              , imgs =
                    [ { url = "/maddi/karmafulminien-stage-1.jpg", alt = "Karmafulminien Stage 1", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-stage-2.jpg", alt = "Karmafulminien Stage 2", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-stage-3.jpg", alt = "Karmafulminien Stage 3", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-stage-4.jpg", alt = "Karmafulminien Stage 4", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-stage-5.jpg", alt = "Karmafulminien Stage 5", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-stage-6.jpg", alt = "Karmafulminien Stage 6", credit = Just "Laura Granelli, Luca Riccio" }
                    , { url = "/maddi/karmafulminien-rendering.jpg", alt = "Karmafulminien rendering", credit = Just "Laura Granelli, Luca Riccio" }
                    ]
              }
            , { id = "story-of-qu"
              , title = "Story of Qu"
              , institution = "Piccolo Teatro"
              , tags = [ "set design", "collective work" ]
              , openedAt = ( 2017, 1, 1 )
              , content = """
Original play by Dario Fo and Franca Rame, directed by Massimo Navone. Opening in September 24th 2014, Piccolo Teatro Studio Melato, Milan

Awarded Premio Salon Brera-Bicocca in 2015, displayed in the International Art Academies Exihibition (Beijing, September 2015).
        """
              , imgs =
                    [ { url = "/maddi/story-of-qu-stage-2.jpg", alt = "Story of Qu, Stage 2", credit = Just "Pino Montisci" }
                    , { url = "/maddi/story-of-qu-model-2.jpg", alt = "Story of Qu, Model 2", credit = Just "Pino Montisci" }
                    , { url = "/maddi/story-of-qu-model-3.jpg", alt = "Story of Qu, Model 3", credit = Just "Pino Montisci" }
                    , { url = "/maddi/story-of-qu-model-4.jpg", alt = "Story of Qu, Model 4", credit = Just "Pino Montisci" }
                    , { url = "/maddi/story-of-qu-stage-1.jpg", alt = "Story of Qu, Stage 1", credit = Just "Pino Montisci" }
                    ]
              }
            ]
      }
    , { title = "Opera"
      , projects =
            [ { id = "ernani"
              , title = "Ernani"
              , institution = "La Scala"
              , tags = [ "set assistant" ]
              , openedAt = ( 2018, 9, 29 )
              , content = """
[Opening September 29th, 2018](http://www.teatroallascala.org/it/stagione/2017-2018/opera/ernani.html)

Opera by Giuseppe Verdi, produced by Teatro alla Scala

Conductor Ádám Fischer, Director Sven-Eric Bechtolf, Set Designer Julian Crouch, Costume Designer Kevin Pollard
Light Designer Marco Filibeck, Video Designer Filippo Marta, Coreography Lara Montanaro
    """
              , imgs =
                    [ { url = "/maddi/ernani-billboard.jpg", alt = "Ernani Billboard", credit = Nothing }
                    ]
              }
            ]
      }
    ]
