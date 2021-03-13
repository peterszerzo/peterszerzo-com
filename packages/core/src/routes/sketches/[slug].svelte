<script context="module">
  export async function preload({ params, query }) {
    const res = await this.fetch(`sketches/${params.slug}.data.json`);
    const data = await res.json();

    if (res.status === 200) {
      return { sketch: data };
    } else {
      this.error(res.status, data.message);
    }
  }
</script>

<script>
  import Sketch from "../../components/Sketch.svelte";
  import marked from "marked";

  export let sketch;

  export let width;
  export let height;

  $ : content = sketch.content && marked(sketch.content);
</script>

<svelte:head>
  <title>{sketch.title}</title>
</svelte:head>

<div class="sketch-page">
  <h1>{sketch.title}</h1>

  <Sketch
    name={sketch.slug}
    animating={true}
    allowSave={true}
    initiallyPlaying={true}
  ></Sketch>

  {#if sketch.content}
    <div class="content">
      {@html content}
    </div>
  {/if}
</div>

<svelte:window bind:innerWidth={width} bind:innerHeight={height} />

<style>
  .sketch-page > :global(*) {
    margin-bottom: 30px;
  }

  .sketch-page > :global(*:last-child) {
    margin-bottom: 0;
  }
</style>
