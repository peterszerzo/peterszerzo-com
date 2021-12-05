<script lang="ts">
  export let before: string | undefined = undefined;
  export let title: string;
  export let after: string | undefined = undefined;
</script>

<div class="hero">
  <div>
    {#if before}
      <p>{before}</p>
    {/if}
    <h1><span class="animated-text-shadow">{title}</span></h1>
    {#if after}
      <p>{after}</p>
    {/if}
  </div>
</div>

<style>
  .hero {
    text-align: left;
  }

  h1 {
    margin: 0;
    text-shadow: 2px 2px 0px var(--sage);
  }

  p {
    margin: 6px 0;
  }

  .hero > * {
    margin: 0;
  }
</style>
