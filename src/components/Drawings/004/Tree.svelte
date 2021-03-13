<script lang="ts">
  export let tree;

  export let f = 0;

  export let size: number = 40;

  export let color: string = "rgba(137, 189, 158, 0.6)";

  const p = 0.1;
</script>

<svelte:options immutable={true} />

{#if tree}
  <rect
    fill={color}
    x={(-size * (1 - p)) / 2}
    y={(-size * (1 - p)) / 2}
    width={size * (1 - p)}
    height={size * (1 - p)}
    rx={size * 0.15} />
  <g transform="rotate({90 * f}) translate({size * f} 0)">
    <svelte:self {size} tree={tree[0]} {f} {color} />
  </g>
  <g transform="rotate(0) translate({size * f} 0)">
    <svelte:self {size} tree={tree[1]} {f} {color} />
  </g>
  <g transform="rotate({-90 * f}) translate({size * f} 0)">
    <svelte:self {size} tree={tree[2]} {f} {color} />
  </g>
{/if}
