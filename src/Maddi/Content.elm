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
I am a set, costume and prop designer with roots in Milan, working in theatre and opera since 2014.

I studied set design at Accademia di Brera in Milan, and I trained in stage engineering at scenic arts at Teatro alla Scala. I have a soft spot for puppetry, and for Bruno Schulz-quotes like this:

> ‘Do you understand [...] the profound meaning of that weakness, that passion for gaudy tissue-paper, papier-mâché, coloured lacquer, straw, and sawdust? It is [...] our love for matter as such, for its downiness and porousness, its unique, mystical consistency.’

Feel free to connect by [email](mailto:annamcingi@gmail.com) or [social media](https://www.instagram.com/datzkale/) if you're interested in working with me or to learn more. Looking forward!
"""


groupedProjects : List Project.GroupedProject
groupedProjects =
    [ { title = "Theatre"
      , projects =
            [ { id = "visite"
              , title = "Visite"
              , institution = "Teatro Franco Parenti"
              , tags = [ "set designer" ]
              , openedAt = ( 2018, 11, 20 )
              , content = """
**Director:** Riccardo Pippa.

**Dramaturg:** Giulia Tollis.

**Performers:** Cecilia Campani, Giovanni Longhin, Andrea Panigatti, Sandro Pivotti, Maria Vittoria Scarlattei, Matteo Vitanza.

Opening November 20th, 2018 in [Teatro Franco Parenti / Teatro dei Gordi](https://www.teatrodeigordi.it/spettacolo/visite/), 
        """
              , imgs =
                    [ { url = "/maddi/visite-1.jpg", alt = "Visite Promo 1", credit = Nothing }
                    , { url = "/maddi/visite-2.jpg", alt = "Visite Promo 2", credit = Nothing }
                    ]
              }
            , { id = "karmafulminien"
              , title = "Karmafulminien"
              , institution = "Teatro Della Tosse"
              , tags = [ "set designer", "costume designer" ]
              , openedAt = ( 2014, 11, 3 )
              , content = """
**Director:** Riccardo Pippa.

**Performers:** Luca Mammoli, Enrico Pittaluga, Graziano Sirressi.

An original show by [Generazione Disagio](https://www.facebook.com/generazionedisagio/). First played on November 3rd 2015 in Teatro della Tosse, Genoa, Italy // [trailer](https://vimeo.com/148718410).

Costumes designed together with Daniela De Blasio, light design by Danilo Deiana.

Produced by Fondazione Luzzati - Teatro della Tosse, Genoa.
        """
              , imgs =
                    [ { url = "/maddi/karmafulminien-stage-1.jpg", alt = "Karmafulminien Stage 1", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-2.jpg", alt = "Karmafulminien Stage 2", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-10.jpg", alt = "Karmafulminien Stage 10", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-3.jpg", alt = "Karmafulminien Stage 3", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-4.jpg", alt = "Karmafulminien Stage 4", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-5.jpg", alt = "Karmafulminien Stage 5", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-6.jpg", alt = "Karmafulminien Stage 6", credit = Just "Laura Granelli" }
                    , { url = "/maddi/karmafulminien-stage-11.jpg", alt = "Karmafulminien Stage 11", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-12.jpg", alt = "Karmafulminien Stage 12", credit = Nothing }
                    , { url = "/maddi/karmafulminien-rendering.jpg", alt = "Karmafulminien rendering", credit = Just "my rendering" }
                    , { url = "/maddi/karmafulminien-poster.jpg", alt = "Karmafulminien poster", credit = Just "Niccolò Masini" }
                    ]
              }
            , { id = "story-of-qu"
              , title = "Story of Qu"
              , institution = "Piccolo Teatro"
              , tags = [ "set designer", "collective work" ]
              , openedAt = ( 2017, 1, 1 )
              , content = """
**Director:** Massimo Navone. 

Original play by Dario Fo and Franca Rame.

First played on September 24th 2014 in Piccolo Teatro Studio Melato, Milan.

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
**Conductor:** Ádám Fischer

**Director:** Sven-Eric Bechtolf

**Set Designer:** Julian Crouch

Costume design by Kevin Pollard, light design by Marco Filibeck, video design by Filippo Marta, coreography by Lara Montanaro.

Opening on September 29th, 2018 in [Teatro alla Scala](http://www.teatroallascala.org/it/stagione/2017-2018/opera/ernani.html), Milan.

Produced by Teatro alla Scala.
    """
              , imgs =
                    [ { url = "/maddi/ernani-billboard.jpg", alt = "Ernani Billboard", credit = Nothing }
                    ]
              }
            ]
      }
    ]
