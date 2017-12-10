module Content exposing (..)

import Data.Project exposing (Project)


mainLinks : List ( String, String )
mainLinks =
    [ ( "Projects", "/projects" )
    , ( "Playground", "http://codepen.io/peterszerzo/" )
    , ( "Talks", "/talks" )
    , ( "Blog", "http://blog.peterszerzo.com" )
    , ( "CV", "https://represent.io/peterszerzo" )
    , ( "About", "/about" )
    , ( "Now", "/now" )
    , ( "Contact", "mailto:szerzo.peter@gmail.com" )
    ]


projects : List Project
projects =
    [ { name = "elm-gameroom"
      , description = "elm-gameroom is an API design experiment that allows developers to make highly custom multiplayer guessing games in less than 200 lines of code."
      , technologies = [ "Elm", "WebGL" ]
      , url = "https://elm-gameroom.firebaseapp.com"
      , roles = [ "Developer", "Designer" ]
      , size = 1200
      }
    , { name = "ripsaw"
      , description = "Design interface for creating 3d bezier shapes"
      , technologies = [ "Elm", "SVG" ]
      , url = "http://ripsaw.surge.sh"
      , roles = [ "Developer", "Designer" ]
      , size = 800
      }
    , { name = "nlx"
      , description = ""
      , technologies = [ "Elm", "WebGL" ]
      , url = "https://nlx.ai"
      , roles = [ "Frontend lead", "UX designer" ]
      , size = 600
      }
    , { name = "The Seed"
      , description = ""
      , technologies = [ "Elm" ]
      , url = "https://theseed.eu"
      , roles = []
      , size = 600
      }
    , { name = "SplytLight"
      , description = "Design interface for SplytLight, a modular lighting system."
      , technologies = [ "React", "SVG", "Three.js" ]
      , url = "http://splytlight.surge.sh"
      , roles = []
      , size = 600
      }
    , { name = "Atlas"
      , description = "Data visualization CMS"
      , technologies = [ "React", "SVG", "Leaflet.js", "Mapbox" ]
      , url = "http://atlas.newamerica.org"
      , roles = []
      , size = 600
      }
    , { name = "OverEasy"
      , description = "Fictitious webshop."
      , technologies = [ "React", "WebGL" ]
      , url = "https://overeasy.sh"
      , roles = []
      , size = 600
      }
    ]


title : String
title =
    "Hi, I’m Peter"


subtitle : String
subtitle =
    "Your friendly neighborhood creative programmer"


talks : String
talks =
    """
Speaking and workshopping I enjoy. Here are the few I was fortunate to have done so far:
* Multiplayer Games by the Boatloads (Paris, June 2017)
<iframe width="560" height="315" src="https://www.youtube.com/embed/sBCz6atTRZk" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
* [Copenhagen React Workshop](https://www.eventbrite.com/e/copenhagen-react-workshop-1-tickets-25344956447#), co-run with my good friend [Andreas](http://larsenwork.com)
* [Practical Elm. And Friends](https://peterszerzo.github.io/practical-elm-and-friends/) (June 2016, Copenhagen)
* [CSS by the Fireplace](https://peterszerzo.github.io/css-by-the-fireplace/) (April 2016, Copenhagen)
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

Data visualizations/frontend for [data science](https://contiamo.com) and [chatbots](https://nlx.ai). Started really warming up to the idea of going back to school for some added creative edge. CIID in good old Copenhagen especially.

I have also been on a long, steady streak of New Yorker articles, and wonderful books like Extremely Loud and Incredibly Close and 1Q84.

Still taking ever more frequent and longer walks, and eating more pastries.
"""


notification : String
notification =
    "Levi, your life is your story. [Make it a good one](https://www.shortoftheweek.com/2014/12/10/the-moped-diaries/)"
