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
  export let sketch;
  import { onMount } from "svelte";

  onMount(async () => {
    await import("../../sketches/index.js");
  });
</script>

<style>
</style>

<svelte:head>
  <title>{sketch.title}</title>
</svelte:head>

<a href="/">Home</a>

<h1>{sketch.title}</h1>

<my-sketch
  sketch-name={sketch.slug}
  url="/sketches/cosine-beetles"
  size="600"
></my-sketch>

<div class="content">
  {@html sketch.html}
</div>
