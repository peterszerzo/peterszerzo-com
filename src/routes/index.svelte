<script lang="ts">
  import { marked } from "marked";

  import Project from "$lib/components/Project.svelte";
  import Section from "$lib/components/Section.svelte";
  import SectionTitle from "$lib/components/SectionTitle.svelte";
  import Hero from "$lib/components/Hero.svelte";

  const aboutSerious = `
This is Peter, programmer, designer and natural language enthusiast.

I make web apps, animations and games, spending most of my time on the frontend, sprinkled with some spent designing and some on the backend. I enjoy deleting code, shortening variable names and changing my mind about tools and frameworks. When I have things to say, I enjoy collaborating, giving talks and running workshops.

Coming to tech after exploring algorithmic/computational design strategies in architecture, I love poking around across disciplines, and use code for product design, animation and generative art. Sometimes, I do none of that and stare out the window.

You can find me on my bike on the streets of Berlin and New York, at various frontend/creative coding/Elm meetups, here and there online. Let’s talk!
  `;

  $: aboutSeriousHtml = marked(aboutSerious);

  const sketches = [
    {
      title: "my brain is a mush",
      image: "/thumbnails/my-brain-is-a-mush.png",
      url: "https://hic.af/o/567569",
    },
    {
      title: "shatter",
      image: "/thumbnails/shatter.png",
      url: "https://hic.af/o/363652",
    },
    {
      title: "folding cubes",
      image: "/thumbnails/folding-cubes.png",
      url: "https://hic.af/o/305858",
    },
    {
      title: "misfit planets",
      image: "/thumbnails/misfit-planets.png",
      url: "https://hic.af/o/338824",
    },
    {
      title: "eerie sunset",
      image: "/thumbnails/eerie-sunset.png",
      url: "https://hic.af/o/287273",
    },
    {
      title: "marching windows",
      image: "/thumbnails/marching-windows.png",
      url: "https://hic.af/o/283006",
    },
  ];

  const tech = [
    {
      label: "React",
      image: "/imgs/logos/react-logo.png",
      url: "https://operational-ui.netlify.com",
    },
    {
      label: "Elm",
      image: "/imgs/logos/elm-logo.png",
      url: "https://github.com/peterszerzo/elm-arborist",
    },
    {
      label: "TypeScript",
      image: "/imgs/logos/typescript-logo.png",
      url: "https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi",
    },
    {
      label: "RxJS",
      image: "/imgs/logos/rxjs-logo.png",
      url: "https://github.com/peterszerzo/splytlight/blob/master/src/state.ts",
    },
    {
      label: "HTML",
      image: "/imgs/logos/html-logo.png",
      url: "https://html.spec.whatwg.org/multipage/",
    },
    {
      label: "CSS",
      image: "/imgs/logos/css-logo.png",
      url: "https://css-tricks.com/",
    },
    {
      label: "Haskell",
      image: "/imgs/logos/haskell-logo.png",
      url: "https://gist.github.com/peterszerzo/22b063ba5b155bb0ca4baec648d4679a",
    },
    {
      label: "Processing",
      image: "/imgs/logos/processing-logo.png",
      url: "https://processing.org/",
    },
    {
      label: "Vim",
      image: "/imgs/logos/vim-logo.png",
      url: "https://github.com/peterszerzo/dotfiles/blob/master/.vimrc",
    },
  ];
</script>

<svelte:head>
  <title>Peter Szerzo</title>
</svelte:head>

<Hero title="Peter Szerzo" after="Neighborhood Creative Programmer" />

<Section>
  <SectionTitle title="Projects" />
  <div>
    <Project
      title="Browser DJ App"
      subtitle="for @hicetnunc"
      url="https://hen-dj.vercel.app"
      logo="HenDj"
    />
    <Project
      title="elm-arborist"
      subtitle="Tree Editor"
      url="https://peterszerzo.github.io/elm-arborist/"
      logo="ElmArborist"
    />
    <Project
      title="SplytLight"
      subtitle="3d Drawing"
      url="https://splytlight.surge.sh/"
      logo="SplytLight"
    />
    <Project
      title="annacingi.com"
      subtitle="Artist Portfolio"
      url="http://annacingi.com"
      logo="AnnaCingi"
    />
    <Project
      title="elm-gameroom"
      subtitle="Game Framework"
      url="https://elm-gameroom.firebaseapp.com"
      logo="ElmGameroom"
    />
  </div>
</Section>
<Section>
  <SectionTitle title="Blog">
    <a
      href="https://dev.to/peterszerzo"
      style="display: inline-block; width: 30px; height: 30px;"
      slot="controls"
    >
      <img
        src="https://d2fltix0v2e0sb.cloudfront.net/dev-badge.svg"
        alt="Peter Szerzo’s DEV Profile"
        height="30"
        width="30"
      />
    </a>
  </SectionTitle>
  <ul>
    <li>
      <a
        href="https://dev.to/peterszerzo/my-year-on-the-frontend-2020-edition-1fpk"
        >My year on the frontend, 2020 edition</a
      >
    </li>
    <li>
      <a href="https://dev.to/peterszerzo/generics-for-user-interfaces-hak"
        >Generics for user interfaces</a
      >
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/introducing-arborist-the-tree-editor-for-elm-49po"
        >Introducing Arborist, the Tree Editor for Elm</a
      >
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/rich-interactive-notebooks-with-elm-markup-part-1-50kb"
        >Rich Interactive Notebooks with elm-markup</a
      >
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi"
        >Safe Functional IO in TypeScript</a
      >
    </li>
  </ul>
</Section>
<Section>
  <SectionTitle title="Talks" />
  <ul>
    <li>
      <a href="https://www.kicommunity.de/"
        >Building Conversational Applications with AI</a
      >
      // Berlin, May 2021
    </li>
    <li>
      <a href="https://www.youtube.com/embed/0ASvEzfuH7g"
        >Take your Framework Dancing</a
      >
      // Berlin, February 2018
    </li>
    <li>
      <a href="https://www.youtube.com/embed/sBCz6atTRZk"
        >Multiplayer Games by the Boatloads</a
      >
      // Paris, June 2017
    </li>
    <li>Copenhagen React Workshop // Copenhagen, April 2016</li>
    <li>
      <a href="https://peterszerzo.github.io/practical-elm-and-friends/"
        >Practicel Elm. And Friends</a
      >
      // Copenhagen, June 2016
    </li>
    <li>
      <a href="https://peterszerzo.github.io/css-by-the-fireplace/"
        >CSS by the Fireplace</a
      >
      // Copenhagen, April 2016
    </li>
  </ul>
</Section>
<Section>
  <SectionTitle title="The logo salad" subtitle="Languages and tools I love" />
  {#each tech as techItem}
    <a
      title={techItem.label}
      href={techItem.url}
      class="tech"
      style={`background-image: url(${techItem.image});`}
    >
      <span>{techItem.label}</span>
    </a>
  {/each}
</Section>
<Section>
  <SectionTitle title="About" />
  <div>
    {@html aboutSeriousHtml}
  </div>
</Section>
<Section>
  <SectionTitle title="Sketches" />
  <div class="sketches">
    {#each sketches as sketch}
      <a
        href={sketch.url}
        class="sketch"
        title={sketch.title}
        style="background-image: url({sketch.image})"
      />
    {/each}
  </div>
</Section>

<style>
  .tech {
    display: inline-block;
    background-repeat: no-repeat;
    width: 36px;
    height: 36px;
    margin: 0 12px 12px 0;
    background-size: contain !important;
    background-position: 50% 50%;
    filter: brightness(100%);
  }

  .sketches > * {
    display: inline-block;
    vertical-align: top;
    margin-right: 0px;
    margin-bottom: 0px;
  }

  .tech:hover {
    filter: brightness(110%);
  }

  .tech span {
    display: none;
  }

  .sketch {
    display: inline-block;
    width: 160px;
    height: 160px;
    transition: filter 0.2s ease-in-out;
    background-size: cover;
  }

  .sketch:hover {
    filter: brightness(110%);
  }
</style>
