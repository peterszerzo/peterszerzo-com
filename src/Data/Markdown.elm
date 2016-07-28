module Data.Markdown exposing (..)

aboutConventional = """
## Hello

This is Peter, programmer, designer, language enthusiast, yogi, cook. A friendly, straightforward fellow with eager-to-pedal feet, a green thumb and a curious mind.

I make websites and web apps, spending most of my time on the front end. I work with and get very excited about Elm, React, Redux, PostCSS, Express, Meteor, Ghost, and Rails, and find my way around Heroku and AWS (though I do prefer surge.sh :) ). I much enjoy collaborating, giving talks and running workshops - I do my best to spark excitement both around and within me.

I enjoy designing my own interfaces and contributing to design processes at work. I previously studied and dabbled with algorithmic approaches to architectural design, and love to use code outside of the browser from architectural and jewelry design to animation and computational art. And to get a break of them all, I love reading, writing, yoga and gardening. All great things!

You can find me on my bike on the streets of Copenhagen, sitting around in a coffee shop, the local front end, React and Elm meetups, here and there online. Let's talk!
"""

aboutReal = """
## Oh, good!

You hit the magic switch. Let me balance out the conformist professionalism on the other page with some real Peter Szerzo.

I'm a great guy: caring, fun, passionate. That said, when I'm wrapped up in excessive anxiety or self-judgement (which is often), then I can be a bit too much. Ramble ramble ramble.

I judge myself for spending money and I am afraid of gaining weight. I have a fear that one day, due to say world politics, I will have to return to my native Romania, a place I haven't made peace with yet. German society freaks me out.

When I was 6, I hit my brother on the back with my fist so hard I felt his entire ribcage resonate through mine. I regret it to this day. Thing is, while my adult brother can forgive me, his child version is just not around. And while we're at my family: for each web project I launch, I write ‘Hi, Mom!’ in the console. Because my mother rocks!

I am often in a reflective mood. When I feel really bad, I ask myself: ‘What is wrong with this moment?’ Eventually, the answer is always nothing, and the moment of realizing that is genuine happiness to me. The amazing circus of physical sensations in my body are always available to me, and they're incredibly powerful. They are the channel to a sense of belonging. I read all of that in a book, and wonder sometimes if I truly believe these things or just lie to myself about them.

It means a lot to me that you've read this.
"""

now = """
The /now page is Derek Sivers' [brilliant idea](https://sivers.org/nowff). Cheers, Derek!

## Week of July 25th

I've just become co-organizer of the Copenhagen frontenders' meetup, starting the one on August 2nd. I'll be finishing up and testing CphRain, my codeoff challenge for the event. The teams will be competing in creating a raindrop animation by supplying animation logic only (renderer and animator provided). It has silly error messages. It'll be tons of fun.

Just finished *From Russia with Love*, feeding my latest infatuation with Super Agent 007. I'm starting *Intuitive Eating* now, in my quest to improve my relationship with food and eating.

Other great things I plan to do is repot some lilies that are growing out of their nursery, and picking some mint and lemonbalm from the garden to dry for the fall and winter. Exciting!
"""

notificationTexts =
  [ "[A really great speaker](https://medium.com/@akosma/being-a-developer-after-40-3c5dd112210c#.pjq16al88) made me realize how announcing our income in public can decrease income inequality. I make 45000dkk a month."
  ]

notificationText =
  List.head notificationTexts
    |> Maybe.withDefault ""
