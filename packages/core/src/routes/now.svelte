<script context="module">
  export async function preload() {
    const res = await this.fetch("cms/now.md");
    const md = await res.text();
    return { md };
  }
</script>

<svelte:head>
  <title>Now | Peter Szerzo</title>
</svelte:head>

<script>
  import Static from "../components/Static.svelte";
  import marked from "marked";

  export let md;

  $ : htmlContent = marked(md);
</script>

<div class="static-page">
  <h1>Peter’s Now Page</h1>

  <blockquote>
    The /now page is Derek Sivers’
    <a href="https://sivers.org/nowff">brilliant idea</a>. Thank you, Derek!
  </blockquote>

  <Static md={md} />
</div>

<style>
  .static-page > :global(*) {
    margin-bottom: 40px;
  }

  .static-page > :global(:last-child) {
    margin-bottom: 0;
  }
</style>
