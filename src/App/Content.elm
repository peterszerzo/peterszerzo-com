module Content exposing (..)


mainLinks : List ( String, String )
mainLinks =
    [ ( "Works", "/projects" )
    , ( "Blog", "http://blog.peterszerzo.com" )
    , ( "CV", "https://represent.io/peterszerzo" )
    , ( "Talks", "/talks" )
    , ( "About", "/about" )
    , ( "Now", "/now" )
    ]


projectLinks : List ( String, String )
projectLinks =
    [ ( "Lettero", "https://lettero.co" )
    , ( "Albatross", "http://albatross.peterszerzo.com" )
    , ( "Splyt Light", "http://splytlight.surge.sh" )
    , ( "CphRain", "http://cphrain.surge.sh" )
    , ( "Helicopters", "http://helicopter-ride.peterszerzo.com/" )
    , ( "Pendants", "https://www.youtube.com/watch?v=0bKI3VSdD1g" )
    , ( "Rotary", "http://rotary-phone.peterszerzo.com/" )
    , ( "PBA", "http://pba.peterszerzo.com/" )
    ]


talkLinks : List ( String, String )
talkLinks =
    [ ( "CSS@fireplace", "https://pickled-plugins.github.io/css-by-the-fireplace/" )
    , ( "Elm+friends", "https://pickled-plugins.github.io/practical-elm-and-friends/" )
    ]


title : String
title =
    "Hi, I’m Peter"


subtitle : String
subtitle =
    "programmer, designer, writer, but mostly just person"


aboutConventional : String
aboutConventional =
    """
## Hello :)

This is Peter, programmer, designer, language enthusiast, yogi, cook. A friendly, straightforward fellow with eager-to-pedal feet, a green thumb and a curious mind.

I make websites and web apps, spending most of my time on the frontend, sprinkled with some spent designing and some on the backend. I enjoy deleting code, shortening variable names and changing my mind about tools and frameworks. Even more so, I enjoy collaborating, giving talks and running workshops.

I previously studied and dabbled with algorithmic approaches to architectural design, and love to use code outside of the browser from architectural and jewelry design to animation and computational art. And to get a break of them all, I read, write, do yoga and garden. All great things!

You can find me on my bike on the streets of Copenhagen, sitting around in a coffee shop, at the local frontend, React and Elm meetups, [here](https://twitter.com/peterszerzo) and [there](https://medium.com/@peterszerzo) online. Let’s talk!
"""


aboutReal : String
aboutReal =
    """
## Oh, good!

You hit the magic switch. Let me balance out the somewhat conformist professionalism on the other page with some real Peter Szerzo.

I’m a great guy: caring, fun, passionate. That said, when I’m wrapped up in excessive anxiety or self-judgement (which is often), then I can be a bit too much. Ramble ramble ramble.

I judge myself for spending money and I am afraid of gaining weight. I have a fear that one day, due to say world politics, I will have to return to my native Romania, a place I haven’t made peace with yet. The time I was locked up in Germany solely based on my citizenship seems to have left me with a bitterness that simply just won’t fade.

When I was 6, I hit my brother on the back with my fist so hard I felt his entire ribcage resonate through mine. I regret it to this day. Thing is, while my adult brother can forgive me, his child version is just not around. And while we’re at my family: for each web project I launch, I write ‘Hi, Mom!’ in the console. Because my mother rocks!

I am often in a reflective mood. I often ask myself: ‘What is wrong with this moment?’ Eventually, the answer is always nothing, and the moment of realizing that is genuine happiness to me. The amazing circus of physical sensations in my body are always available to me, and they’re incredibly powerful. They are the channel to a sense of belonging. I read all of that in a book, and wonder sometimes if I truly believe these things or just lie to myself about them.

It means a lot to me that you’ve read this.
"""


now : String
now =
    """
The /now page is Derek Sivers’ [brilliant idea](https://sivers.org/nowff). Cheers, Derek!

## Now

I am doing lots of ad-hoc programming and design, including [a game](https://lettero.co/) and a [lamp design tool](http://splytlight.surge.sh). I do it partly for fun, partly to shed some new light on what I like to do and what feels right to focus on, and partly to iron out my next step towards ever more fulfilling work. Reading [So good the y can’t ignore you](https://sivers.org/book/SoGood) for some extra inspiration.

Also writing some blog posts, such as [this one](http://blog.peterszerzo.com/im-depressed-and-my-coworkers-love-it/) and [this one](http://blog.peterszerzo.com/high-school-newsletter-interview/), and boy does it feel amazing to write again. What is even more astonishing is that I’m having a much easier time letting go and putting stuff up online.

Doing more yoga, taking more frequent and longer walks. Eating more pastries.
"""


notification : String
notification =
    "Your life is a story. [Make it a good one](https://www.shortoftheweek.com/2014/12/10/the-moped-diaries/)"
