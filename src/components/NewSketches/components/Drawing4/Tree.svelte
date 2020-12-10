<script lang="ts">
  export let tree;

  export let f = 0;

  const p = 0.08;

  const s = 50;
</script>

{#if tree}
  <rect fill="rgba(255, 255, 255, 0.05)" stroke="rgba(255, 255, 255, 0.1)" x="{-s / 2 + s * p / 2}" y="{-s / 2 + s * p / 2}" width="{s - s * p}" height="{s - s * p}" rx="{s * 0.15}" />
  <g transform="rotate({90 * f}) translate({s * f} 0)">
    <svelte:self tree={tree.children[0]} f={f} />
  </g>
  <g transform="rotate(0) translate({s * f} 0)">
    <svelte:self tree={tree.children[1]} f={f} />
  </g>
  <g transform="rotate({-90 * f}) translate({s * f} 0)">
    <svelte:self tree={tree.children[2]} f={f} />
  </g>
{/if}
