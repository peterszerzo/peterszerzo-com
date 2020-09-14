<script context="module">
  export async function preload() {
    const res = await this.fetch("index.data.json");
    const data = await res.json();

    if (res.status === 200) {
      return { data };
    } else {
      this.error(res.status, data.message);
    }
  }
</script>

<script>
  import marked from "marked";

  import Logo from "../components/Logo.svelte";
  import Project from "../components/Project.svelte";
  import Switch from "../components/Switch.svelte";
  import Sketch from "../components/Sketch.svelte";
  import Section from "../components/Section.svelte";
  import SectionTitle from "../components/SectionTitle.svelte";
  import Hero from "../components/Hero.svelte";
  import Button from "../components/Button.svelte";
  import { onMount } from "svelte";

  export let data;

  $ : aboutSeriousHtml = marked(data.aboutSerious);
  $ : aboutAlternativeHtml = marked(data.aboutAlternative);

  export let aboutVersion = "serious";

  const handleAboutSwitcher = detail => {
    aboutVersion = aboutVersion === "serious" ? "nonserious" : "serious";
  }

  const tech = [
    {
      label: "Elm",
      image: "/imgs/logos/elm-logo.png",
      url: "https://github.com/peterszerzo/elm-arborist"
    },
    {
      label: "TypeScript",
      image: "/imgs/logos/typescript-logo.png",
      url: "https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi"
    },
    {
      label: "RxJS",
      image: "/imgs/logos/rxjs-logo.png",
      url: "https://github.com/peterszerzo/splytlight/blob/master/src/state.ts"
    },
    {
      label: "React",
      image: "/imgs/logos/react-logo.png",
      url: "https://operational-ui.netlify.com"
    },
    {
      label: "HTML",
      image: "/imgs/logos/html-logo.png",
      url: "https://html.spec.whatwg.org/multipage/"
    },
    {
      label: "CSS",
      image: "/imgs/logos/css-logo.png",
      url: "https://css-tricks.com/"
    },
    {
      label: "Haskell",
      image: "/imgs/logos/haskell-logo.png",
      url: "https://gitlab.com/peterszerzo/ensemble-of-flesh-chat"
    },
    {
      label: "Processing",
      image: "/imgs/logos/processing-logo.png",
      url: "https://processing.org/"
    },
    {
      label: "Clojure",
      image: "/imgs/logos/clojure-logo.png",
      url: "https://gist.github.com/peterszerzo/4e35067a015b410d8021e70c03d2def0"
    },
    {
      label: "Vim",
      image: "/imgs/logos/vim-logo.png",
      url: "https://github.com/peterszerzo/dotfiles/blob/master/.vimrc"
    },
  ]

  onMount(async () => {
    await import("../sketches/index.js");
  });
</script>

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

  .tech:hover {
    filter: brightness(110%);
  }

  .tech span {
    display: none;
  }
</style>

<svelte:head>
  <title>Peter Szerzo</title>
</svelte:head>

<Hero title="Peter Szerzo" after="Neighborhood Creative Programmer" />
<Section>
  <SectionTitle title="Sketches" />
  <div class="sketches">
    {#each data.sketches as sketch, index (index)}
      <Sketch
        name="{sketch.slug}"
        url="/sketches/{sketch.slug}"
        size="160"
        allowSave={false}
        initiallyPlaying={false}
      ></Sketch>
    {/each}
  </div>
</Section>
<Section>
  <SectionTitle title="Projects" />
  <div>
    <Project title="elm-arborist" subtitle="Tree Editor" url="https://peterszerzo.github.io/elm-arborist/" logo="ElmArborist" />
    <Project title="SplytLight" subtitle="3d Drawing" url="https://splytlight.surge.sh/" logo="SplytLight" />
    <Project title="annacingi.com" subtitle="Artist Portfolio" url="http://annacingi.com" logo="AnnaCingi" />
    <Project title="elm-gameroom" subtitle="Game Framework" url="https://elm-gameroom.firebaseapp.com" logo="ElmGameroom" />
  </div>
</Section>
<Section>
  <SectionTitle title="Blog">
    <a href="https://dev.to/peterszerzo" style="display: inline-block; width: 30px; height: 30px;" slot="controls">
      <img src="https://d2fltix0v2e0sb.cloudfront.net/dev-badge.svg" alt="Peter Szerzo’s DEV Profile" height="30" width="30">
    </a>
  </SectionTitle>
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
</Section>
<Section>
  <SectionTitle title="Talks" />
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
</Section>
<Section>
  <SectionTitle title="The logo salad" subtitle="Languages and tools I love" />
  {#each tech as techItem}
    <a title={techItem.label} href={techItem.url} class="tech" style={`background-image: url(${techItem.image});`}>
      <span>{techItem.label}</span>
    </a>
  {/each}
</Section>
<Section>
  <SectionTitle title="About">
    <div slot="controls">
      <Switch on:change={handleAboutSwitcher} active={aboutVersion !== 'serious'} />
    </div>
  </SectionTitle>
  {#if aboutVersion === 'serious'}
    <div>
      {@html aboutSeriousHtml}
    </div>
  {:else}
    <div>
      {@html aboutAlternativeHtml}
    </div>
  {/if}
</Section>
