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

<script lang="ts">
  import marked from "marked";
  import drawingComponents from "../components/Drawings/index";

  import Project from "../components/Project.svelte";
  import Switch from "../components/Switch.svelte";
  import Section from "../components/Section.svelte";
  import SectionTitle from "../components/SectionTitle.svelte";
  import Hero from "../components/Hero.svelte";

  let activeDrawing: string | null = null;

  export let data;

  $: aboutSeriousHtml = marked(data.aboutSerious);
  $: aboutAlternativeHtml = marked(data.aboutAlternative);

  export let aboutVersion = "serious";

  const handleAboutSwitcher = detail => {
    aboutVersion = aboutVersion === "serious" ? "nonserious" : "serious";
  };

  const tech = [
    {
      label: "Elm",
      image: "/imgs/logos/elm-logo.png",
      url: "https://github.com/peterszerzo/elm-arborist"
    },
    {
      label: "TypeScript",
      image: "/imgs/logos/typescript-logo.png",
      url:
        "https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi"
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
      url:
        "https://gist.github.com/peterszerzo/22b063ba5b155bb0ca4baec648d4679a"
    },
    {
      label: "Processing",
      image: "/imgs/logos/processing-logo.png",
      url: "https://processing.org/"
    },
    {
      label: "Vim",
      image: "/imgs/logos/vim-logo.png",
      url: "https://github.com/peterszerzo/dotfiles/blob/master/.vimrc"
    }
  ];
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

  .sketch-container {
    display: inline-block;
    width: 120px;
    height: 120px;
    transition: filter 0.2s ease-in-out;
  }

  .sketch-container:hover {
    filter: brightness(110%);
  }

  .sketch-container > :global(canvas),
  .sketch-container > :global(img) {
    width: 100%;
    height: 100%;
  }
</style>

<svelte:head>
  <title>Peter Szerzo</title>
</svelte:head>

<Hero title="Peter Szerzo" after="Neighborhood Creative Programmer" />

<Section>
  <SectionTitle title="Sketches" />
  <div class="sketches">
    {#each Object.entries(drawingComponents) as [key, drawing]}
      {#if drawing.thumbnail}
        <a class="sketch-container" href={drawing.url}>
          <img src={drawing.thumbnail} alt="Thumbnail" />
        </a>
      {:else}
        <a
          class="sketch-container"
          href={`/sketches/${key}`}
          on:mouseover={() => {
            activeDrawing = key;
          }}
          on:mouseout={() => {
            activeDrawing = null;
          }}>
          <svelte:component
            this={drawing.Component}
            playing={activeDrawing === key} />
        </a>
      {/if}
    {/each}
  </div>
</Section>
<Section>
  <SectionTitle title="Projects" />
  <div>
    <Project
      title="elm-arborist"
      subtitle="Tree Editor"
      url="https://peterszerzo.github.io/elm-arborist/"
      logo="ElmArborist" />
    <Project
      title="SplytLight"
      subtitle="3d Drawing"
      url="https://splytlight.surge.sh/"
      logo="SplytLight" />
    <Project
      title="annacingi.com"
      subtitle="Artist Portfolio"
      url="http://annacingi.com"
      logo="AnnaCingi" />
    <Project
      title="elm-gameroom"
      subtitle="Game Framework"
      url="https://elm-gameroom.firebaseapp.com"
      logo="ElmGameroom" />
  </div>
</Section>
<Section>
  <SectionTitle title="Blog">
    <a
      href="https://dev.to/peterszerzo"
      style="display: inline-block; width: 30px; height: 30px;"
      slot="controls">
      <img
        src="https://d2fltix0v2e0sb.cloudfront.net/dev-badge.svg"
        alt="Peter Szerzo’s DEV Profile"
        height="30"
        width="30" />
    </a>
  </SectionTitle>
  <ul>
    <li>
      <a href="https://www.kicommunity.de/">Building Conversational Applications with AI</a>
      // Berlin, May 2021
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/my-year-on-the-frontend-2020-edition-1fpk">My
        year on the frontend, 2020 edition</a>
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/generics-for-user-interfaces-hak">Generics
        for user interfaces</a>
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/introducing-arborist-the-tree-editor-for-elm-49po">Introducing
        Arborist, the Tree Editor for Elm</a>
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/rich-interactive-notebooks-with-elm-markup-part-1-50kb">Rich
        Interactive Notebooks with elm-markup</a>
    </li>
    <li>
      <a
        href="https://dev.to/peterszerzo/safe-functional-io-in-typescript-an-introduction-1kmi">Safe
        Functional IO in TypeScript</a>
    </li>
  </ul>
</Section>
<Section>
  <SectionTitle title="Talks" />
  <ul>
    <li>
      <a href="https://www.youtube.com/embed/0ASvEzfuH7g">Take your Framework
        Dancing</a>
      // Berlin, February 2018
    </li>
    <li>
      <a href="https://www.youtube.com/embed/sBCz6atTRZk">Multiplayer Games by
        the Boatloads</a>
      // Paris, June 2017
    </li>
    <li>Copenhagen React Workshop // Copenhagen, April 2016</li>
    <li>
      <a
        href="https://peterszerzo.github.io/practical-elm-and-friends/">Practicel
        Elm. And Friends</a>
      // Copenhagen, June 2016
    </li>
    <li>
      <a href="https://peterszerzo.github.io/css-by-the-fireplace/">CSS by the
        Fireplace</a>
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
      style={`background-image: url(${techItem.image});`}>
      <span>{techItem.label}</span>
    </a>
  {/each}
</Section>
<Section>
  <SectionTitle title="About">
    <div slot="controls">
      <Switch
        on:change={handleAboutSwitcher}
        active={aboutVersion !== 'serious'} />
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
