<script context="module">
  export async function preload({ params }) {
    return { slug: params.slug };
  }
</script>

<script lang="ts">
  import drawings from "../../components/Drawings/index";
  import Container from "../../components/Drawings/Container.svelte";
  import marked from "marked";

  export let slug: string;

  let playing: boolean = true;

  const handleKeyDown = ev => {
    if (ev.key === " ") {
      ev.preventDefault();
      playing = !playing;
    }
  };

  $: drawing = drawings[slug];

  $: content = drawing?.content ? marked(drawing?.content) : undefined;
</script>

<svelte:head>
  <title>{drawing?.title || `Sketch ${slug}`} | Peter Szerzo</title>
</svelte:head>

<svelte:body on:keydown={handleKeyDown} />

{#if drawing}
  <div class="sketch-page">
    {#if drawing.title}
      <h1>{drawing.title}</h1>
    {/if}
    <Container>
      <svelte:component this={drawing.Component} {playing} />
    </Container>
    {#if content}
      <div class="content">
        {@html content}
      </div>
    {/if}
  </div>
{/if}
