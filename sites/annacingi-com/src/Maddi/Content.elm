module Maddi.Content exposing (about, groupedProjects, navLinks)

import Maddi.Data.Project as Project


navLinks : List ( String, String )
navLinks =
    [ ( "/", "home" )
    , ( "/about", "about" )
    , ( "mailto:annamcingi@gmail.com", "contact" )
    , ( "/maddi/anna-cingi-cv-english.pdf", "cv" )
    ]


about : String
about =
    """
I am a set, costume and prop designer with roots in Milan, working in theatre and opera since 2014.

I studied set design at Accademia di Brera in Milan, and I trained in stage engineering and scenic arts at Teatro alla Scala. I have a soft spot for puppetry, and for Bruno Schulz-quotes like this:

> ‘Do you understand [...] the profound meaning of that weakness, that passion for gaudy tissue-paper, papier-mâché, coloured lacquer, straw, and sawdust? It is [...] our love for matter as such, for its downiness and porousness, its unique, mystical consistency.’

Feel free to connect by [email](mailto:annamcingi@gmail.com) or [social media](https://www.instagram.com/datzkale/) if you're interested in working with me or to learn more. Looking forward!
"""


visiteCopy : String
visiteCopy =
    """
**Director:** Riccardo Pippa.

**Performers:** Cecilia Campani, Giovanni Longhin, Andrea Panigatti, Sandro Pivotti, Maria Vittoria Scarlattei, Matteo Vitanza.

Costume design and masks by Ilaria Ariemme, dramaturgy by Giulia Tollis, light design by Paolo Casati, sound design by Luca De Marinis, directing assistent Daniele Cavone Felicioni.

An original show by Teatro dei Gordi. Produced by Teatro Franco Parenti and Teatro dei Gordi.

Opening November 20th, 2018 in [Teatro Franco Parenti](https://www.teatrodeigordi.it/spettacolo/visite/).
"""


karmaCopy : String
karmaCopy =
    """
**Director:** Riccardo Pippa.

**Performers:** Luca Mammoli, Enrico Pittaluga, Graziano Sirressi.

Costumes designed together with Daniela De Blasio, light design by Danilo Deiana.

An original show by [Generazione Disagio](https://www.facebook.com/generazionedisagio/). Produced by Fondazione Luzzati - Teatro della Tosse, Genoa.

First performed on November 3rd 2015 in Teatro della Tosse, Genoa, Italy // [trailer](https://vimeo.com/148718410).
"""


quCopy : String
quCopy =
    """
**Director:** Massimo Navone.

**Set, props and tech team:** Gianluca Agazzi, Cristina Baroni, Martina Carcano, myself, Andrea Colombo, Greta Gasparini, Alberto Gramegna, Francesca Meregalli, Maddalena Oriani, Clarissa Palumbo, Flavio Pezzotti, Federica Piergiacomi, Francesca Sgariboldi, Alice Simoni
 
Original play by Dario Fo and Franca Rame. Produced by Milano Teatro Scuola Paolo Grassi, Scuola di Scenografia dell’Accademia di Belle Arti di Brera, Accademia dell’Arte di Arezzo, Milano Civica Scuola di Musica Claudio Abbado, Milano Scuola di Cinema e Televisione, Laboratorio di Circo Quattrox4.

First performed on September 24th 2014 in Piccolo Teatro Studio Melato, Milan.

Awarded Premio Salon Brera-Bicocca in 2015, displayed in the International Art Academies Exihibition (Beijing, September 2015).
"""


ernaniCopy : String
ernaniCopy =
    """
**Conductor:** Ádám Fischer.

**Director:** Sven-Eric Bechtolf.

**Set designer:** Julian Crouch.

Costume design by Kevin Pollard, light design by Marco Filibeck, video design by Filippo Marta, coreography by Lara Montanaro.

Opening on September 29th, 2018 in [Teatro alla Scala](http://www.teatroallascala.org/it/stagione/2017-2018/opera/ernani.html), Milan.

Produced by Teatro alla Scala.
"""


urlandoCopy : String
urlandoCopy =
    """
**Director:** Riccardo Pippa.

**Performer:** Rita Pelusio.

**Scenic sculpture:** Simone Fersino.

An original show by Domenico Ferrari, Riccardo Piferi, Riccardo Pippa and Rita Pelusio. First played on December 12th 2017 in Teatro Verdi, Milan, Italy // [trailer](https://vimeo.com/250084156).

Light design by Paolo Casati, sound design by Luca De Marinis, direction assistant Andrea Bettaglio.
"""


barberCopy : String
barberCopy =
    """
**Conductor:** Maurizio Benini

**Stage director:** Lotte de Beer

**Set and costume designer:** Julian Crouch

Light design by Alex Brok, coreography by Zack Winokur, dramaturgy by Peter te Nuyl.

Opening on November 10th, 2018 in Dutch National Opera and Ballet, Amsterdam // [show link](https://www.operaballet.nl/en/opera/2018-2019/show/il-barbiere-siviglia).

Produced by Dutch National Opera and Ballet.
"""


hanselGretelCopy : String
hanselGretelCopy =
    """
**Conductor:** Marc Albrecht  

**Director:** Sven-Eric Bechtolf

**Set designer:** Julian Crouch

Costume design by Kevin Pollard, light design by Marco Filibeck, video design by Joshua Higgason.

Opening on September 2nd, 2017 in Teatro alla Scala, Milan // [show link](http://www.teatroallascala.org/it/stagione/2016-2017/opera/hansel-und-gretel.html).

Produced by Teatro alla Scala.
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
              , content = visiteCopy
              , imgs =
                    let
                        credit =
                            Just "Laila Pozzo"
                    in
                    [ { url = "/maddi/visite-1.jpg?1xad", alt = "Visite Promo 1", credit = credit }
                    , { url = "/maddi/visite-2.jpg?1xad", alt = "Visite Promo 2", credit = credit }
                    ]
              , thumbnailImg = Nothing
              }
            , { id = "urlando-furiosa"
              , title = "Urlando Furiosa"
              , institution = ""
              , tags = [ "costume designer" ]
              , openedAt = ( 2017, 12, 1 )
              , content = urlandoCopy
              , imgs =
                    let
                        credit1 =
                            Just "Laila Pozzo"

                        credit2 =
                            Just "Raffaella Vismara"
                    in
                    [ { url = "/maddi/urlando-furiosa-06.jpg?1xad", alt = "Urlando Furiosa 6", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-01.jpg?1xad", alt = "Urlando Furiosa 1", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-02.jpg?1xad", alt = "Urlando Furiosa 2", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-03.jpg?1xad", alt = "Urlando Furiosa 3", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-04.jpg?1xad", alt = "Urlando Furiosa 4", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-05.jpg?1xad", alt = "Urlando Furiosa 5", credit = credit1 }
                    , { url = "/maddi/urlando-furiosa-07.jpg?1xad", alt = "Urlando Furiosa 7", credit = credit2 }
                    , { url = "/maddi/urlando-furiosa-08.jpg?1xad", alt = "Urlando Furiosa 8", credit = credit2 }
                    , { url = "/maddi/urlando-furiosa-09.jpg?1xad", alt = "Urlando Furiosa 9", credit = credit2 }
                    ]
              , thumbnailImg = Nothing
              }
            , { id = "karmafulminien"
              , title = "Karmafulminien"
              , institution = "Teatro Della Tosse"
              , tags = [ "set designer", "costume designer" ]
              , openedAt = ( 2015, 11, 3 )
              , content = karmaCopy
              , imgs =
                    [ { url = "/maddi/karmafulminien-stage-1.jpg?1xad", alt = "Karmafulminien Stage 1", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-2.jpg?1xad", alt = "Karmafulminien Stage 2", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-10.jpg?1xad", alt = "Karmafulminien Stage 10", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-3.jpg?1xad", alt = "Karmafulminien Stage 3", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-4.jpg?1xad", alt = "Karmafulminien Stage 4", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-5.jpg?1xad", alt = "Karmafulminien Stage 5", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-6.jpg?1xad", alt = "Karmafulminien Stage 6", credit = Just "Laura Granelli" }
                    , { url = "/maddi/karmafulminien-stage-11.jpg?1xad", alt = "Karmafulminien Stage 11", credit = Nothing }
                    , { url = "/maddi/karmafulminien-stage-12.jpg?1xad", alt = "Karmafulminien Stage 12", credit = Nothing }
                    , { url = "/maddi/karmafulminien-rendering.jpg?1xad", alt = "Karmafulminien rendering", credit = Just "my rendering" }
                    , { url = "/maddi/karmafulminien-poster.jpg?1xad", alt = "Karmafulminien poster", credit = Just "Niccolò Masini" }
                    ]
              , thumbnailImg = Nothing
              }
            , { id = "story-of-qu"
              , title = "Story of Qu"
              , institution = "Piccolo Teatro"
              , tags = [ "set designer", "collective work" ]
              , openedAt = ( 2014, 9, 1 )
              , content = quCopy
              , imgs =
                    [ { url = "/maddi/story-of-qu-01.jpg?1xad", alt = "Story of Qu 1", credit = Nothing }
                    , { url = "/maddi/story-of-qu-02.jpg?1xad", alt = "Story of Qu 2", credit = Nothing }
                    , { url = "/maddi/story-of-qu-03.jpg?1xad", alt = "Story of Qu 3", credit = Just "Pino Montisci" }
                    , { url = "/maddi/story-of-qu-04.jpg?1xad", alt = "Story of Qu 4", credit = Nothing }
                    , { url = "/maddi/story-of-qu-05.jpg?1xad", alt = "Story of Qu 5", credit = Just "Enzo Mologni" }
                    , { url = "/maddi/story-of-qu-06.jpg?1xad", alt = "Story of Qu 6", credit = Nothing }
                    , { url = "/maddi/story-of-qu-07.jpg?1xad", alt = "Story of Qu 7", credit = Just "Enzo Mologni" }
                    , { url = "/maddi/story-of-qu-08.jpg?1xad", alt = "Story of Qu 8", credit = Nothing }
                    , { url = "/maddi/story-of-qu-09.jpg?1xad", alt = "Story of Qu 9", credit = Just "Enzo Mologni" }
                    , { url = "/maddi/story-of-qu-10.jpg?1xad", alt = "Story of Qu 10", credit = Just "Enzo Mologni" }
                    , { url = "/maddi/story-of-qu-11.jpg?1xad", alt = "Story of Qu 11", credit = Nothing }
                    , { url = "/maddi/story-of-qu-12.jpg?1xad", alt = "Story of Qu 12", credit = Just "Enzo Mologni" }
                    , { url = "/maddi/story-of-qu-13.jpg?1xad", alt = "Story of Qu 13", credit = Just "Pino Montisci" }
                    ]
              , thumbnailImg = Nothing
              }
            ]
      }
    , { title = "Opera"
      , projects =
            [ { id = "barber-of-seville"
              , title = "Barber of Seville"
              , institution = ""
              , tags = [ "set assistant" ]
              , openedAt = ( 2018, 11, 10 )
              , content = barberCopy
              , imgs =
                    let
                        credit =
                            Just "Marco Borggreve"
                    in
                    [ { url = "/maddi/barber-of-seville-01.jpg?1xad", alt = "Barber of Seville 1", credit = credit }
                    , { url = "/maddi/barber-of-seville-02.jpg?1xad", alt = "Barber of Seville 2", credit = credit }
                    , { url = "/maddi/barber-of-seville-03.jpg?1xad", alt = "Barber of Seville 3", credit = credit }
                    , { url = "/maddi/barber-of-seville-04.jpg?1xad", alt = "Barber of Seville 4", credit = credit }
                    , { url = "/maddi/barber-of-seville-05.jpg?1xad", alt = "Barber of Seville 5", credit = credit }
                    , { url = "/maddi/barber-of-seville-06.jpg?1xad", alt = "Barber of Seville 6", credit = credit }
                    , { url = "/maddi/barber-of-seville-07.jpg?1xad", alt = "Barber of Seville 7", credit = credit }
                    , { url = "/maddi/barber-of-seville-08.jpg?1xad", alt = "Barber of Seville 8", credit = credit }
                    , { url = "/maddi/barber-of-seville-09.jpg?1xad", alt = "Barber of Seville 9", credit = credit }
                    , { url = "/maddi/barber-of-seville-10.jpg?1xad", alt = "Barber of Seville 10", credit = credit }
                    , { url = "/maddi/barber-of-seville-11.jpg?1xad", alt = "Barber of Seville 11", credit = credit }
                    , { url = "/maddi/barber-of-seville-12.jpg?1xad", alt = "Barber of Seville 12", credit = credit }
                    ]
              , thumbnailImg = Nothing
              }
            , { id = "ernani"
              , title = "Ernani"
              , institution = "La Scala"
              , tags = [ "set assistant" ]
              , openedAt = ( 2018, 9, 29 )
              , content = ernaniCopy
              , imgs =
                    let
                        credit =
                            Just "Brescia, Amisano © Teatro Alla Scala"
                    in
                    [ { url = "/maddi/ernani-01.jpg?1xad", alt = "Ernani stage 1", credit = credit }
                    , { url = "/maddi/ernani-02.jpg?1xad", alt = "Ernani stage 2", credit = credit }
                    , { url = "/maddi/ernani-03.jpg?1xad", alt = "Ernani stage 3", credit = credit }
                    , { url = "/maddi/ernani-04.jpg?1xad", alt = "Ernani stage 4", credit = credit }
                    , { url = "/maddi/ernani-05.jpg?1xad", alt = "Ernani stage 5", credit = credit }
                    , { url = "/maddi/ernani-06.jpg?1xad", alt = "Ernani stage 6", credit = credit }
                    , { url = "/maddi/ernani-07.jpg?1xad", alt = "Ernani stage 7", credit = credit }
                    , { url = "/maddi/ernani-08.jpg?1xad", alt = "Ernani stage 8", credit = credit }
                    , { url = "/maddi/ernani-09.jpg?1xad", alt = "Ernani stage 9", credit = credit }
                    , { url = "/maddi/ernani-10.jpg?1xad", alt = "Ernani stage 10", credit = credit }
                    , { url = "/maddi/ernani-11.jpg?1xad", alt = "Ernani stage 11", credit = credit }
                    , { url = "/maddi/ernani-12.jpg?1xad", alt = "Ernani stage 12", credit = credit }
                    , { url = "/maddi/ernani-13.jpg?1xad", alt = "Ernani stage 13", credit = credit }
                    , { url = "/maddi/ernani-14.jpg?1xad", alt = "Ernani stage 14", credit = credit }
                    , { url = "/maddi/ernani-15.jpg?1xad", alt = "Ernani stage 15", credit = credit }
                    ]
              , thumbnailImg = Nothing
              }
            , { id = "hansel-gretel"
              , title = "Hänsel und Gretel"
              , institution = ""
              , tags = [ "set assistant" ]
              , openedAt = ( 2017, 9, 2 )
              , content = hanselGretelCopy
              , imgs =
                    [ { url = "/maddi/haensel-gretel-01.jpg?1xad", alt = "Hänsel und Gretel Stage 1", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-02.jpg?1xad", alt = "Hänsel und Gretel Stage 2", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-03.jpg?1xad", alt = "Hänsel und Gretel Stage 3", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-04.jpg?1xad", alt = "Hänsel und Gretel Stage 4", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-05.jpg?1xad", alt = "Hänsel und Gretel Stage 5", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-06.jpg?1xad", alt = "Hänsel und Gretel Stage 6", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-07.jpg?1xad", alt = "Hänsel und Gretel Stage 7", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-08.jpg?1xad", alt = "Hänsel und Gretel Stage 8", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-09.jpg?1xad", alt = "Hänsel und Gretel Stage 9", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-10.jpg?1xad", alt = "Hänsel und Gretel Stage 10", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-11.jpg?1xad", alt = "Hänsel und Gretel Stage 11", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-12.jpg?1xad", alt = "Hänsel und Gretel Stage 12", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-13.jpg?1xad", alt = "Hänsel und Gretel Stage 13", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    , { url = "/maddi/haensel-gretel-14.jpg?1xad", alt = "Hänsel und Gretel Stage 14", credit = Just "Brescia, Amisano © Teatro Alla Scala" }
                    ]
              , thumbnailImg = Nothing
              }
            ]
      }
    ]