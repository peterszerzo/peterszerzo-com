<script lang="ts">
  export let r: number;
  export let fill: string | undefined;
  export let transform: string | undefined;
</script>

<svelte:options immutable={true} />

<path
  d="M0,0 L{r},0 a {r},{r} 0 0 1 -{r},{r} l0,-{r}Z"
  {...{ fill, transform }}
  stroke="#000"
  stroke-width="2" />
