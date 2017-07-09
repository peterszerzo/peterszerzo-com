module Content exposing (..)

import Models


mainLinks : List ( String, String )
mainLinks =
    [ ( "Recent works", "/projects" )
    , ( "Playground", "http://codepen.io/peterszerzo/" )
    , ( "Blog", "http://blog.peterszerzo.com" )
    , ( "CV", "https://represent.io/peterszerzo" )
    , ( "About", "/about" )
    , ( "Now", "/now" )
    , ( "Contact", "mailto:szerzo.peter@gmail.com" )
    ]


projects : List Models.Project
projects =
    [ { id = "elm-gameroom"
      , title = "elm-gameroom"
      , description = "Framework for custom multiplayer games"
      , url = "https://elm-gameroom.firebaseapp.com"
      , roles = [ "dev" ]
      , technologies = [ "Elm", "Google Firebase" ]
      , imageUrl = "/imgs/projects/elm-gameroom.jpg"
      , gifUrl = ""
      }
    , { id = "splytlight"
      , title = "Splyt Light"
      , description = "3d product interface"
      , url = "http://splytlight.surge.sh"
      , roles = [ "dev", "design" ]
      , technologies = [ "React", "Three.js" ]
      , imageUrl = "/imgs/projects/splytlight.jpg"
      , gifUrl = ""
      }
    , { id = "atlas"
      , title = "Atlas"
      , description = "Data visualization CMS"
      , url = "http://atlas.newamerica.org"
      , roles = [ "dev" ]
      , technologies = [ "React", "Express", "Mapbox" ]
      , imageUrl = "/imgs/projects/atlas.jpg"
      , gifUrl = ""
      }
    , { id = "ripsaw"
      , title = "ripsaw.js"
      , description = "Interactive product design for the browser"
      , url = "http://peterszerzo.github.io/ripsaw"
      , roles = [ "dev", "design" ]
      , technologies = [ "Vanilla JS", "Canvas" ]
      , imageUrl = "/imgs/projects/ripsaw.jpg"
      , gifUrl = ""
      }
    ]


title : String
title =
    "Hi, I’m Peter"


subtitle : String
subtitle =
    "Your friendly neighborhood creative programmer."


talks : String
talks =
    """
## Talks

Speaking in public I enjoy - here are the few I did so far:
* [CSS by the fireplace](https://peterszerzo.github.io/css-by-the-fireplace/)
* [Practical Elm. And friends](https://peterszerzo.github.io/practical-elm-and-friends/)
* [Copenhagen React Workshop](https://www.eventbrite.com/e/copenhagen-react-workshop-1-tickets-25344956447#)
  """


aboutConventional : String
aboutConventional =
    """
## Hello :)

This is Peter, programmer, designer and natural language enthusiast. A friendly, straightforward fellow with eager-to-pedal feet, a green thumb and a curious mind.

I make web apps, visualizations and games, spending most of my time on the frontend, sprinkled with some spent designing and some on the backend. I enjoy deleting code, shortening variable names and changing my mind about tools and frameworks. Even more so, I enjoy collaborating, giving talks and running workshops.

I previously studied and dabbled with algorithmic approaches to architectural design, and love to use code outside of the browser from architectural and jewelry design to animation and computational art. And to get a break of them all, I read, write, do yoga and garden. All great things!

You can find me on my bike on the streets of Bucharest and New York, sitting around in a coffee shop, various frontend, React and Elm meetups, [here](https://twitter.com/peterszerzo) and [there](https://medium.com/@peterszerzo) online. Let’s talk!
"""


aboutReal : String
aboutReal =
    """
## Oh, good!

You hit the magic switch. Let me balance out the somewhat conformist professionalism on the other page with some real Peter Szerzo.

I’m a great guy: caring, fun, passionate. That said, when I’m wrapped up in anxiety or self-judgement (which is often), then I can be a bit too much. Ramble ramble ramble.

I tend to overly scrutinize my spending decisions and I have a light towards moderate fear of gaining weight. I also have a fear that one day, due to say world politics, I will have to return to live in Romania - a place I grew up in but no longer have strong emotional ties to. Speaking of growing up, when I was 6, I hit my brother on his back with my fist so hard I felt his entire ribcage resonate through mine. I regret it to this day. Thing is, while my adult brother can forgive me, his child version is just not around.

Let’s see what else.. I often find myself in a reflective mood. I have a habit of asking myself: ‘What is wrong with this moment?’ Eventually, the answer is always ‘nothing’, and the moment of realizing that is genuine happiness to me. I read that in a book, and wonder sometimes if I truly believe it or if I’m just cluelessly parroting it back.

It means a lot to me that you’ve read this.
"""


now : String
now =
    """

## What am I doing now?

WebGL, [games](https://elm-gameroom.firebaseapp.com). Been fortunate to speak at [Elm-Europe](https://elmeurope.org/) not so long ago, met some amazing people, and felt at home.

I have also been on a long, steady streak of New Yorker articles, and wonderful books like Extremely Loud and Incredibly Close and 1Q84.

Still taking ever more frequent and longer walks, and eating more pastries.

> The /now page is Derek Sivers’ [brilliant idea](https://sivers.org/nowff). Cheers, Derek!
"""


notification : String
notification =
    "Levi, your life is your story. [Make it a good one](https://www.shortoftheweek.com/2014/12/10/the-moped-diaries/)"
