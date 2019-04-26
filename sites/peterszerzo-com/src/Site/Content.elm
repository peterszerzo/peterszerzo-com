module Site.Content exposing
    ( Project
    , aboutConventional
    , aboutReal
    , mainLinks
    , now
    , projects
    , subtitle
    , talks
    , talksIntro
    , title
    )


type alias Talk =
    { title : String
    , location : String
    , date : String
    , youtubeUrl : Maybe String
    , slidesUrl : Maybe String
    }


type alias Project =
    { id : String
    , name : String
    , url : String
    , description : String
    , size : Int
    , color : String
    }


mainLinks : List ( String, String )
mainLinks =
    [ ( "Projects", "/projects" )
    , ( "Talks", "/talks" )
    , ( "Blog", "http://blog.peterszerzo.com" )
    , ( "CV", "https://represent.io/peterszerzo" )
    , ( "About", "/about" )
    , ( "Twitter", "https://twitter.com/peterszerzo" )
    , ( "GitHub", "https://github.com/peterszerzo" )
    ]


elmGameroomCopy : String
elmGameroomCopy =
    """
How easily can we create multiplayer games, and how custom can these games be? (answer: under 200 lines of code, any single-step competitive guessing game, any graphics the browser can handle)

elm-gameroom is an API design experiment that balances the experience of the developer with the creative freedom of the game designer, delivering a framework that ‘clocks’ the simplest game in just under 150 lines of code. Replacing the back-end with peer-to-peer communication running on the frontend in the trusted, type-safe hands of the Elm programming language, elm-gameroom spawns a number of robust games that can be programed within the hour.

Care to play? Head to the [website](https://elm-gameroom-firebaseapp.com) for a few samples you can try out with your friends.

**Info:** Paris / 2017 / [Website](https://elm-gameroom.firebaseapp.com)

**Role:** Developer / Designer

**Made with:** Elm / WebGL

![elm-gameroom](/site/imgs/projects/elm-gameroom.png)
    """


ripsawCopy : String
ripsawCopy =
    """
Design interface for creating 3d bezier shapes.

**Info:** Brooklyn, NY / 2014 / [Website](https://codepen.io/peterszerzo/full/Wpdxyd/)

**Role:** Developer / Designer

**Made with:** Elm / SVG

![ripsaw](/site/imgs/projects/ripsaw.png)
      """


twistyCopy : String
twistyCopy =
    """
Immersing myself into [Alto's Adventure](http://altosadventure.com) in the past few months, I have discovered the tremendous calming effect the right game design can have. Twisty Donut Racer is an exploration of what the Alto's secret is. Incidentally, it also revives an old [Moebius strip fascination](https://www.youtube.com/watch?v=MAYWsyDcAPQ).

**Info:** Berlin / 2017 / [Website](https://peterszerzo.github.io/twisty-donut-racer)

**Role:** Developer / Designer

**Made with:** React / WebGL / SVG

![Twisty Donut Racer](/site/imgs/projects/twisty-donut-racer.png)
      """


annacingiCopy : String
annacingiCopy =
    """
Portfolio page for Milan-based set designer Anna Cingi.

**Info:** Berlin / 2018-2019 / [Website](http://annacingi.com)

**Role:** Developer / Designer

**Made with:** Elm / SVG

![Anna Cingi website](/site/imgs/projects/annacingi.png)
      """


arboristCopy : String
arboristCopy =
    """
A drag-and-drop tree structure visualizer and editor that is agnostic about the data structure that sits in each node. It grew out of a need to model conversation flows, but has since generalized itself a fair bit. The latest experiment in the working: write pieces of JavaScript in each node, and compose user interfaces visually - a refreshing escape from file-based IDE's.

**Info:** Berlin / 2017 / [Website](https://peterszerzo.github.io/elm-arborist/)

**Role:** Developer / Designer

**Made with:** Elm / SVG

![elm-arborist](/site/imgs/projects/elm-arborist.png)
      """


splytlightCopy : String
splytlightCopy =
    """
Design interface for the [SplytLight](http://www.splytlight.com) lighting system developed by [Scott Leinweber](http://scottleinweber.com) and [Jason Krugman](http://www.jasonkrugman.com). Scott and I teamed up for some lovely recursive geometric hacking.

**Info:** Copenhagen / 2016 / [Website](http://splytlight.surge.sh)

**Role:** Developer / UX Designer

**Made with:** React / SVG / Three.js

![Splytlight](/site/imgs/projects/splytlight.png)
      """


atlasCopy : String
atlasCopy =
    """
Atlas is a data visualization CMS made for the Education Policy Program at [New America](http://newamerica.org). It allows policy analysts to create their own custom interactive maps based on a spreadsheet template.

**Info:** Washington, DC / 2015 / [Website](http://atlas.newamerica.org)

**Role:** Full-stack Developer / UX Designer

**Made with:** React / SVG / Leaflet.js / Mapbox

![Atlas](/site/imgs/projects/atlas.png)
      """


overeasyCopy : String
overeasyCopy =
    """
A playground for my computational art experiments.

**Info:** Berlin / 2017-2018 / [Website](http://overeasy.sh)

**Made with:** Elm / WebGL

![OverEasy](/site/imgs/projects/overeasy.png)
      """


projects : List Project
projects =
    [ { id = "elm-gameroom"
      , name = "elm-gameroom"
      , description = elmGameroomCopy
      , url = "https://elm-gameroom.firebaseapp.com"
      , size = 1000
      , color = "2D739E"
      }
    , { id = "ripsaw"
      , name = "ripsaw"
      , description = ripsawCopy
      , url = "https://codepen.io/peterszerzo/full/Wpdxyd/"
      , size = 300
      , color = "3c394d"
      }
    , { id = "annacingi"
      , name = "Anna Cingi"
      , description = annacingiCopy
      , url = "http://annacingi.com"
      , size = 1100
      , color = "000000"
      }
    , { id = "twisty-donut-racer"
      , name = "Twisty Donut Racer"
      , description = twistyCopy
      , url = "/"
      , size = 1600
      , color = "302E27"
      }
    , { id = "elm-arborist"
      , name = "elm-arborist"
      , description = arboristCopy
      , url = "/"
      , size = 1200
      , color = "037C4E"
      }
    , { id = "splytlight"
      , name = "SplytLight"
      , description = splytlightCopy
      , url = "http://splytlight.surge.sh"
      , size = 800
      , color = "4a76b2"
      }
    , { id = "atlas"
      , name = "Atlas"
      , description = atlasCopy
      , url = "http://atlas.newamerica.org"
      , size = 300
      , color = "000000"
      }
    , { id = "overeasy"
      , name = "OverEasy"
      , description = overeasyCopy
      , url = "https://overeasy.sh"
      , size = 1200
      , color = "ffc235"
      }
    ]


title : String
title =
    "Hi, I’m Peter"


subtitle : String
subtitle =
    "your friendly neighborhood creative programmer"


talks : List Talk
talks =
    [ { title = "Take your Framework Dancing"
      , location = "Berlin"
      , date = "February 2018"
      , youtubeUrl = Just "https://www.youtube.com/embed/0ASvEzfuH7g"
      , slidesUrl = Just "https://peterszerzo.github.io/talks/take-your-framework-dancing"
      }
    , { title = "Multiplayer Games by the Boatloads"
      , location = "Paris"
      , date = "June 2017"
      , youtubeUrl = Just "https://www.youtube.com/embed/sBCz6atTRZk"
      , slidesUrl = Just "http://elmeu.peterszerzo.com/#1"
      }
    , { title = "Copenhagen React Workshop"
      , location = "Copenhagen"
      , date = "April 2016"
      , youtubeUrl = Nothing
      , slidesUrl = Nothing
      }
    , { title = "Practicel Elm. And Friends"
      , location = "Copenhagen"
      , date = "June 2016"
      , youtubeUrl = Nothing
      , slidesUrl = Just "https://peterszerzo.github.io/practical-elm-and-friends/"
      }
    , { title = "CSS by the Fireplace"
      , location = "Copenhagen"
      , date = "April 2016"
      , youtubeUrl = Nothing
      , slidesUrl = Just "https://peterszerzo.github.io/css-by-the-fireplace/"
      }
    ]


talksIntro : String
talksIntro =
    """
Speaking and workshopping I enjoy. Here are the few I was fortunate to have done so far:
  """


aboutConventional : String
aboutConventional =
    """
This is Peter, programmer, designer and natural language enthusiast. A friendly, straightforward fellow with eager-to-pedal feet, a green thumb and a curious mind.

I make web apps, visualizations and games, spending most of my time on the frontend, sprinkled with some spent designing and some on the backend. I enjoy deleting code, shortening variable names and changing my mind about tools and frameworks. Even more so, I enjoy collaborating, [giving talks](https://www.youtube.com/watch?v=sBCz6atTRZk) and running workshops.

Coming to tech after exploring algorithmic/computational design strategies in architecture, I love poking around across disciplines, and use code for [architecture/product design](http://splytlight.surge.sh), jewelry, [animation](https://www.youtube.com/watch?v=mwExBCCFdZw) and computational art. And to get a break of them all, I read, write, do yoga and garden. All great things!

You can find me on my bike on the streets of Berlin and New York, sitting around in a coffee shop, various frontend, React and Elm meetups, [here](https://twitter.com/peterszerzo) and [there](https://medium.com/@peterszerzo) online. Let’s talk!
"""


aboutReal : String
aboutReal =
    """
Oh, good, you hit the magic switch. Let me balance out the somewhat conformist professionalism on the other page with some real Peter Szerzo.

I’m a great guy: caring, fun, passionate. That said, when I’m wrapped up in anxiety or self-judgement (which is often), then I can be a bit too much. Ramble ramble ramble.

I tend to overly scrutinize my spending decisions and I have a light towards moderate fear of gaining weight. I also have a fear that one day, due to say world politics, I will have to return to live in Romania - a place I grew up in but no longer have strong emotional ties to. Speaking of growing up, when I was 6, I hit my brother on his back with my fist so hard I felt his entire ribcage resonate through mine. I regret it to this day. Thing is, while my adult brother can forgive me, his child version is just not around.

Let’s see what else.. I often find myself in a reflective mood. I have a habit of asking myself: ‘What is wrong with this moment?’ Eventually, the answer is always ‘nothing’, and the moment of realizing that is genuine happiness to me. I read that in a book, and wonder sometimes if I truly believe it or if I’m just cluelessly parroting it back.

It means a lot to me that you’ve read this.
"""


now : String
now =
    """
> The /now page is Derek Sivers’ [brilliant idea](https://sivers.org/nowff). Thank you, Derek!

Data visualizations/frontend for [data science](https://contiamo.com). Started really warming up to the idea of going back to school for some added creative edge. CIID in good old Copenhagen especially.

I have also been on a long, steady streak of New Yorker articles, and wonderful books like Extremely Loud and Incredibly Close and 1Q84.

Still taking ever more frequent and longer walks, and eating more pastries.

Also, a quote:

> Levi, your life is your story. [Make it a good one](https://www.shortoftheweek.com/2014/12/10/the-moped-diaries/)
"""
