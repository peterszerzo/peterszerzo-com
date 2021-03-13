<script context="module">
  export async function preload({ params }) {
    return { slug: params.slug };
  }
</script>

<script lang="ts">
  import drawings from "../../components/Drawings/index";
  import Container from "../../components/Drawings/Container.svelte";

  export let slug: string;

  $: Component = drawings[slug];
</script>

<Container>
  <svelte:component this={Component} playing />
</Container>
