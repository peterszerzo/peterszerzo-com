<div class="hero">
  <div>
    {#if before}
      <p>{before}</p>
    {/if}
    {#if title}
      <h1><span class="animated-text-shadow">{title}</span></h1>
    {/if}
    {#if after}
      <p>{after}</p>
    {/if}
  </div>
</div>

<script>
  export let before;
  export let title;
  export let after;
</script>

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
