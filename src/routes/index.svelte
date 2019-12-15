<script context="module">
  export async function preload() {
    const res = await this.fetch(`index.data.json`);
    const data = await res.json();

    if (res.status === 200) {
      return { sketches: data };
    } else {
      this.error(res.status, data.message);
    }
  }
</script>

<script>
  import Logo from "../components/Logo.svelte";
  import Footer from "../components/Footer.svelte";
  import { onMount } from "svelte";

  export let sketches;

  onMount(async () => {
    await import("../sketches/index.js");
  });
</script>

<style>
</style>

<svelte:head>
  <title>Peter Szerzo</title>
</svelte:head>

<div class="container">
  <div class="hero">
    <div>
      <h1><span class="animated-text-shadow">Peter Szerzo</span></h1>
      <p>Neighborhood Creative Programmer</p>
    </div>
  </div>
  <div class="divider"></div>
  <section>
    <div class="section-title">
      <h2>Sketches</h2>
    </div>
    <div class="sketches">
      {#each sketches as sketch}
      <my-sketch
        sketch-name="{sketch.slug}"
        url="/sketches/{sketch.slug}"
        size="235"
      ></my-sketch>
      {/each}
    </div>
  </section>
  <section>
    <div class="section-title">
      <h2>Open Source</h2>
    </div>
    <ul>
      <li>
        <a href="https://peterszerzo.github.io/elm-arborist">elm-arborist</a>
      </li>
      <li>
        <a href="https://elm-gameroom.firebaseapp.com">elm-gameroom</a>
      </li>
      <li>
        <a href="https://github.com/contiamo/tucson">tucson</a>
      </li>
    </ul>
  </section>
  <section>
    <div class="section-title">
      <h2>Blog</h2>
      <!--
      <a href="https://dev.to/peterszerzo" style="display: inline-block; width: 30px; height: 30px;">
        <img src="https://d2fltix0v2e0sb.cloudfront.net/dev-badge.svg" alt="Peter Szerzo's DEV Profile" height="30" width="30">
      </a>
      -->
    </div>
    <ul>
      <li>
        <a href="https://dev.to/peterszerzo/introducing-arborist-the-tree-editor-for-elm-49po">Introducing Arborist, the Tree Editor for Elm</a>
      </li>
      <li>
        <a href="https://dev.to/peterszerzo/rich-interactive-notebooks-with-elm-markup-part-1-50kb">Rich Interactive Notebooks with elm-markup</a>
      </li>
      <li>
        <a href="https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi">Safe Functional IO in TypeScript</a>
      </li>
    </ul>
  </section>
  <section>
    <div class="section-title">
      <h2>Talks</h2>
    </div>
    <ul>
      <li>
        <a href="https://www.youtube.com/embed/0ASvEzfuH7g">Take your Framework Dancing</a> // Berlin, February 2018
      </li>
      <li>
        <a href="https://www.youtube.com/embed/sBCz6atTRZk">Multiplayer Games by the Boatloads</a> // Paris, June 2017
      </li>
      <li>Copenhagen React Workshop // Copenhagen, April 2016</li>
      <li>
        <a href="https://peterszerzo.github.io/practical-elm-and-friends/">Practicel Elm. And Friends</a> // Copenhagen, June 2016
      </li>
      <li>
        <a href="https://peterszerzo.github.io/css-by-the-fireplace/">CSS by the Fireplace</a> // Copenhagen, April 2016
      </li>
    </ul>
  </section>
  <section>
    <div class="section-title">
      <h2>About</h2>
      <button class="button--mono" id="about-switcher">>></button>
    </div>
    <div id="about-1">
      <p>
        This is Peter, programmer, designer and natural language enthusiast.
      </p>
      <p>
        I make web apps, animations and games, spending most of my time on
        the frontend, sprinkled with some spent designing and some on the
        backend. I enjoy deleting code, shortening variable names and
        changing my mind about tools and frameworks. When I have things to
        say, I enjoy collaborating,
        <a href="https://www.youtube.com/watch?v=sBCz6atTRZk"
          >giving talks</a
        >
        and running workshops.
      </p>
      <p>
        Coming to tech after exploring algorithmic/computational design
        strategies in architecture, I love poking around across disciplines,
        and use code for
        <a href="http://splytlight.surge.sh">product design</a
        >, animation and generative art. Sometimes, I do none of that and stare out
        the window.
      </p>
      <p>
        You can find me on my bike on the streets of Berlin and New York, at
        various frontend/creative coding/Elm meetups, here and there online.
        Let’s talk!
      </p>
    </div>

    <div id="about-2" style="display: none">
      <p>
        Oh, good, you hit the magic switch. Let me balance out the somewhat
        conformist professionalism on the other page with some real Peter
        Szerzo.
      </p>
      <p>
        I’m caring, fun and passionate, but that said, when I’m wrapped up
        in anxiety or self-judgement (often!), then I can be a bit too much.
        Ramble ramble ramble.
      </p>
      <p>
        I overly scrutinize my spending decisions and I am worried about
        gaining weight. I also have a fear that one day, due to say world
        politics, I will have to return to live in Romania - a place I grew
        up in but no longer care for too much. Speaking of growing up: when
        I was 6, I hit my brother on his back with my fist so hard I felt
        his entire ribcage resonate through mine. I regret it to this day
        for the simple fact that while my adult brother can forgive me, his
        child version is just not around.
      </p>
      <p>
        Let’s see what else.. I often find myself in a reflective mood. When
        I am having a hard time, I have a habit of asking myself: ‘What is
        wrong with this moment?’ Eventually, the answer is always ‘nothing’,
        and the moment of realizing that is genuine happiness to me. I read
        that in a book, and wonder sometimes if I truly believe it or if I’m
        just cluelessly parroting it back.
      </p>
      <p>It means a lot to me that you’ve read this.</p>
    </div>
  </section>
  <div class="divider"></div>
  <Footer />
</div>
