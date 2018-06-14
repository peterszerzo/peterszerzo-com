module Content exposing (..)

import Data.Project exposing (Project)


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


projects : List Project
projects =
    [ { id = "elm-gameroom"
      , name = "elm-gameroom"
      , image = "/imgs/projects/elm-gameroom.png"
      , description = """
How easily can we create multiplayer games, and how custom can these games be? (answer: under 200 lines of code, any single-step competitive guessing game, any graphics the browser can handle)

elm-gameroom is an API design experiment that balances the experience of the developer with the creative freedom of the game designer, delivering a framework that ‘clocks’ the simplest game in just under 150 lines of code. Replacing the back-end with peer-to-peer communication running on the frontend in the trusted, type-safe hands of the Elm programming language, elm-gameroom spawns a number of robust games that can be programed within the hour.

Care to play? Head to the [website](https://elm-gameroom-firebaseapp.com) for a few samples you can try out with your friends.

**Info:** Paris / 2017 / [Website](https://elm-gameroom.firebaseapp.com)

**Role:** Developer / Designer

**Technologies:** Elm / WebGL
    """
      , url = "https://elm-gameroom.firebaseapp.com"
      , size = 1200
      }
    , { id = "ripsaw"
      , name = "ripsaw"
      , image = "/imgs/projects/ripsaw.png"
      , description = """
Design interface for creating 3d bezier shapes.

**Info:** Brooklyn, NY / 2014 / [Website](https://codepen.io/peterszerzo/full/Wpdxyd/)

**Role:** Developer / Designer

**Technologies:** Elm / SVG
      """
      , url = "https://codepen.io/peterszerzo/full/Wpdxyd/"
      , size = 400
      }
    , { id = "twisty-donut-racer"
      , name = "Twisty Donut Racer"
      , image = "/imgs/projects/twisty-donut-racer.png"
      , description = """
Immersing myself into [Alto's Adventure](http://altosadventure.com) in the past few months, I have discovered the tremendous calming effect the right game design can have. Twisty Donut Racer is an exploration of what the Alto's secret is. Incidentally, it also revives an old [Moebius strip fascination](https://www.youtube.com/watch?v=MAYWsyDcAPQ).

**Info:** Berlin / 2017 / [Website](https://peterszerzo.github.io/twisty-donut-racer)

**Role:** Developer / Designer

**Technologies:** React / WebGL / SVG
      """
      , url = "/"
      , size = 1600
      }
    , { id = "elm-arborist"
      , name = "elm-arborist"
      , image = "/imgs/projects/elm-arborist.png"
      , description = """
A drag-and-drop tree structure visualizer and editor that is agnostic about the data structure that sits in each node. It grew out of a need to model conversation flows, but has since generalized itself a fair bit. The latest experiment in the working: write pieces of JavaScript in each node, and compose user interfaces visually - a refreshing escape from file-based IDE's.

**Info:** Berlin / 2017 / [Website](https://peterszerzo.github.io/elm-arborist/)

**Role:** Developer / Designer

**Technologies:** Elm / SVG
      """
      , url = "/"
      , size = 800
      }
    , { id = "splytlight"
      , name = "SplytLight"
      , image = "/imgs/projects/splytlight.png"
      , description = """
Design interface for the [SplytLight](http://www.splytlight.com) lighting system developed by [Scott Leinweber](http://scottleinweber.com) and [Jason Krugman](http://www.jasonkrugman.com). Scott and I teamed up for some lovely recursive geometric hacking.

**Info:** Copenhagen / 2016 / [Website](http://splytlight.surge.sh)

**Role:** Developer / UX Designer

**Technologies:** React / SVG / Three.js
      """
      , url = "http://splytlight.surge.sh"
      , size = 1600
      }
    , { id = "atlas"
      , name = "Atlas"
      , image = "/imgs/projects/atlas.png"
      , description = """
Atlas is a data visualization CMS made for the Education Policy Program at [New America](http://newamerica.org). It allows policy analysts to create their own custom interactive maps based on a spreadsheet template.

**Info:** Washington, DC / 2015 / [Website](http://atlas.newamerica.org)

**Role:** Full-stack Developer / UX Designer

**Technologies:** React / SVG / Leaflet.js / Mapbox
      """
      , url = "http://atlas.newamerica.org"
      , size = 400
      }
    , { id = "overeasy"
      , name = "OverEasy"
      , image = "/imgs/projects/overeasy.png"
      , description = """
A silly playground for my computational art experiments.

**Info:** Berlin / 2017-2018 / [Website](http://overeasy.sh)

**Technologies:** React / WebGL
      """
      , url = "https://overeasy.sh"
      , size = 1200
      }
    , { id = "peterszerzo-com"
      , name = "peterszerzo.com"
      , image = "/imgs/projects/peterszerzo.png"
      , description = """
The very website you are on right now is the first personal website I feel truly good about. I always had the feeling that presenting my professional skills/background/interests should not stand in the way of the vulnerability that is often so missing in the professional world. The short film recommendation, and the two different modes of my [about page](/about) make sure you can always find a person behind the creative programmer, whatever that even means.

**Info:** Copenhagen / 2016 / [Website](http://peterszerzo.com)

**Role:** Developer / Designer

**Technologies:** React / WebGL
      """
      , url = "https://overeasy.sh"
      , size = 800
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
* Take your Framework Dancing / Berlin / February 2018 / [Slides](https://peterszerzo.github.io/talks/take-your-framework-dancing)

<div style="position: relative; padding-bottom: 56%; height: 0; overflow: hidden">
  <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%" src="https://www.youtube.com/embed/0ASvEzfuH7g" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
</div>

* Multiplayer Games by the Boatloads / Paris / June 2017 / [Slides](http://elmeu.peterszerzo.com/#1)

<div style="position: relative; padding-bottom: 56%; height: 0; overflow: hidden">
  <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%" src="https://www.youtube.com/embed/sBCz6atTRZk" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
</div>

* Copenhagen React Workshop / Copenhagen / April 2016 / [Website](https://www.eventbrite.com/e/copenhagen-react-workshop-1-tickets-25344956447#)
* Practical Elm. And Friends / Copenhagen / June 2016 / [Slides](https://peterszerzo.github.io/practical-elm-and-friends/)
* CSS by the Fireplace / Copenhagen / April 2016 / [Slides](https://peterszerzo.github.io/css-by-the-fireplace/)
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
