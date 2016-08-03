module Data.Markdown exposing (..)

aboutConventional : String
aboutConventional = """
## Hello

This is Peter, programmer, designer, language enthusiast, yogi, cook. A friendly, straightforward fellow with eager-to-pedal feet, a green thumb and a curious mind.

I make websites and web apps, spending most of my time on the front end. I work with and get very excited about Elm, React, Redux, PostCSS, Express, Meteor, Ghost, and Rails, and find my way around Heroku and AWS (though I do prefer surge.sh :) ). I much enjoy collaborating, giving talks and running workshops - I do my best to spark excitement both around and within me.

I enjoy designing my own interfaces and contributing to design processes at work. I previously studied and dabbled with algorithmic approaches to architectural design, and love to use code outside of the browser from architectural and jewelry design to animation and computational art. And to get a break of them all, I love reading, writing, yoga and gardening. All great things!

You can find me on my bike on the streets of Copenhagen, sitting around in a coffee shop, the local front end, React and Elm meetups, here and there online. Let's talk!
"""

aboutReal : String
aboutReal = """
## Oh, good!

You hit the magic switch. Let me balance out the conformist professionalism on the other page with some real Peter Szerzo.

I'm a great guy: caring, fun, passionate. That said, when I'm wrapped up in excessive anxiety or self-judgement (which is often), then I can be a bit too much. Ramble ramble ramble.

I judge myself for spending money and I am afraid of gaining weight. I have a fear that one day, due to say world politics, I will have to return to my native Romania, a place I haven't made peace with yet. German society freaks me out.

When I was 6, I hit my brother on the back with my fist so hard I felt his entire ribcage resonate through mine. I regret it to this day. Thing is, while my adult brother can forgive me, his child version is just not around. And while we're at my family: for each web project I launch, I write ‘Hi, Mom!’ in the console. Because my mother rocks!

I am often in a reflective mood. When I feel really bad, I ask myself: ‘What is wrong with this moment?’ Eventually, the answer is always nothing, and the moment of realizing that is genuine happiness to me. The amazing circus of physical sensations in my body are always available to me, and they're incredibly powerful. They are the channel to a sense of belonging. I read all of that in a book, and wonder sometimes if I truly believe these things or just lie to myself about them.

It means a lot to me that you've read this.
"""

now : String
now = """
The /now page is Derek Sivers' [brilliant idea](https://sivers.org/nowff). Cheers, Derek!

## Week of August 1st

* Copenhagen frontenders' meetup (it's going to be great!)
* Building my first ever shopping cart
* Reading **Intuitive eating**
* Jump in water from 15 feet and up, as many times as possible
"""

notificationTexts : List String
notificationTexts =
  [ "Respect the hedgehog."
  ]

notificationText : String
notificationText =
  List.head notificationTexts
    |> Maybe.withDefault ""
