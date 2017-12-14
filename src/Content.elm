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
    [ { id = "elm-gameroom"
      , name = "elm-gameroom"
      , image = "/imgs/projects/elm-gameroom.png"
      , description = """
How easily can we create multiplayer games, and how custom can these games be?

> (answer: 200 lines of code, any single-step competitive guessing game, any graphics the browser can handle)

elm-gameroom is an API design experiment that balances the experience of the developer with the creative freedom of the game designer, delivering a framework that clocks the simplest game in just under 150 lines of code. Replacing the back-end with peer-to-peer communication running on the frontend in the trusted, type-safe hands of the Elm programming language, elm-gameroom spawns a number of robust games that can be programed within the hour.

Care to play? Head to the [elm-gameroom website](https://elm-gameroom-firebaseapp.com) for a few samples you can try out with your friends.

**Info:** Paris // 2017 // [Website](https://elm-gameroom.firebaseapp.com)

**Role:** *`Developer`*, *`Designer`*

**Technologies:** `Elm`, `WebGL`
    """
      , url = "https://elm-gameroom.firebaseapp.com"
      , size = 1200
      }
    , { id = "ripsaw"
      , name = "ripsaw"
      , image = "/imgs/projects/ripsaw.jpg"
      , description = """
Design interface for creating 3d bezier shapes.

**Info:** Brooklyn, NY // 2014 // [Website](http://ripsaw.surge.sh)

**Role:** *`Developer`*, *`Designer`*

**Technologies:** `Elm`, `SVG`
      """
      , url = "http://ripsaw.surge.sh"
      , size = 800
      }
    , { id = "nlx"
      , name = "nlx"
      , image = "/imgs/projects/nlx.png"
      , description = """

NLX is an online design studio for custom chatbots. Users can design their very own chatbots down to the finest technical details of natural language understanding, then model the experience using a highly custom [tree structure editor](http://elm-arborist.peterszerzo.com) I made specifically for this project.

NLX is a company built with great care in collaboration with [Andrei Papancea](https://www.linkedin.com/in/andreipapancea/) and [Vlad Papancea](https://www.linkedin.com/in/vlad-papancea-613b96a6/).

**Info:** New York + Berlin // 2017 // [Website](https://nlx.ai)

**Role:** *`Co-Founder`*, *`Frontend Lead`*, *`UX Designer`*

**Technologies:** `Elm`, `d3`
      """
      , url = "https://nlx.ai"
      , size = 600
      }
    , { id = "theseed"
      , name = "The Seed"
      , image = "/imgs/projects/theseed.png"
      , description = """
A learning app aiming to make labor market entry for refugees easier.

**Info:** Copenhagen // 2017 // [Website](https://theseed.eu)

**Role:** *`Frontend Developer`*

**Technologies:** `Elm`, `Firebase`
      """
      , url = "https://theseed.eu"
      , size = 600
      }
    , { id = "splytlight"
      , name = "SplytLight"
      , image = "/imgs/projects/splytlight.png"
      , description = """
Design interface for SplytLight, a modular lighting system.

An interface made with my friend [Scott Leinweber](http://scottleinweber.com), based on a the [SplytLight]() project he developer with [Jason Krugman](http://www.jasonkrugman.com).

**Info:** Copenhagen // 2016 // [Website](http://splytlight.surge.sh)

**Role:** *`Developer`*, *`UX Designer`*.

**Technologies:** `React`, `SVG`, `Three.js`.
      """
      , url = "http://splytlight.surge.sh"
      , size = 600
      }
    , { id = "atlas"
      , name = "Atlas"
      , image = "/imgs/projects/atlas.jpg"
      , description = """
Atlas is a data visualization CMS made for the Education Policy Program at [New America](http://newamerica.org). It allows policy analysts to create their own custom interactive maps based on a spreadsheet template.

**Info:** Washington, DC // 2015 // [Website](http://atlas.newamerica.org)

**Role:** *`Full-stack Developer`*, *`UX Designer`*

**Technologies:** `React`, `SVG`, `Leaflet.js`, `Mapbox`
      """
      , url = "http://atlas.newamerica.org"
      , size = 600
      }
    , { id = "overeasy"
      , name = "OverEasy"
      , image = "/imgs/projects/overeasy.png"
      , description = """
OverEasy is my fake-it-till-you-make-it freelance webshop. It has no clients, just a website with some experimentation on how to showcase design approach, technical aptitude and character without trashing a design.

**Info:** Berlin // 2017 // [Website](https://overeasy.sh)

**Role:** *`Developer`*, *`Designer`*

**Technologies:** `React`, `WebGL`
      """
      , url = "https://overeasy.sh"
      , size = 600
      }
    , { id = "peterszerzo-com"
      , name = "peterszerzo.com"
      , image = "/imgs/projects/peterszerzo.png"
      , description = """
The very website you are on right now is the first personal website I feel truly good about. And believe me, it took me a while to get here. But why is this personal website thing so difficult?

I believe that presenting my professional skills/background/interests must never obscure a sense of kindness and vulnerability. The pop-up with my all-time-favorite short film, and the two different modes of my `/about` description make sure you can always find the person behind the creative programmer, whatever that even means.

That said, providing this underlayer should not make life harder for folks who are, and quite understandably, not interested in any of it.

**Info:** Copenhagen // 2016 // [Website](http://peterszerzo.com)

**Role:** *`Developer`*, *`Designer`*

**Technologies:** `React`, `WebGL`
      """
      , url = "https://overeasy.sh"
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
