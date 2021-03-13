<script lang="ts">
  import Tree from "./Tree.svelte";

  import { onMount } from "svelte";
  import { spring } from "svelte/motion";

  export let playing: boolean = false;

  const t = spring(
    {
      f: 4 / 3,
      rot: 1 / 6,
    },
    {
      stiffness: 0.008,
      damping: 0.2,
    }
  );

  const shuffle = () => {
    if (!playing) {
      return;
    }
    $t = {
      f: Math.floor(Math.random() * 6) / 3,
      rot: Math.floor(Math.random() * 6) / 6,
    };
  };

  onMount(() => {
    const interval = setInterval(shuffle, 4000);
    return () => {
      clearInterval(interval);
    };
  });

  const w = 1000;

  export type Tree = null | [Tree, Tree, Tree];

  const probK = 0.92;

  const generateTree = (
    continueProbability: number,
    seed: number,
    notTopLevel?: boolean
  ): Tree => {
    const prob = 0.5 + 0.5 * Math.sin(43145.8 * seed);
    if (prob > continueProbability && notTopLevel) {
      return null;
    }
    return [
      generateTree(continueProbability * probK, seed + 4, true),
      generateTree(continueProbability * probK, seed + 5, true),
      generateTree(continueProbability * probK, seed + 6, true),
    ];
  };

  const opacity = 0.6;

  const tree1 = generateTree(0.94, 150);

  const tree2 = generateTree(0.94, 250);

  const tree3 = generateTree(0.94, 350);

  const tree4 = generateTree(0.94, 450);
</script>

<svelte:options immutable={true} />

<svg width="100%" height="100%" viewBox="0 0 {w} {w}">
  <rect width={w} height={w} fill="#FFF" />
  <g
    transform="translate({w * 0.35} {w * 0.65}) rotate({360 - $t.rot * 180}) scale(0.3)">
    <Tree
      size={w / 18}
      tree={tree3}
      f={3 * $t.f}
      color="rgba(220, 220, 220, {opacity})" />
  </g>
  <g
    transform="translate({w * 0.65} {w * 0.35}) rotate({360 - $t.rot * 180}) scale(0.3)">
    <Tree
      size={w / 18}
      tree={tree4}
      f={3 - 3 * $t.f}
      color="rgba(220, 220, 220, {opacity})" />
  </g>
  <g transform="translate({w * 0.35} {w * 0.35}) rotate({$t.rot * 180})">
    <Tree
      size={w / 16}
      tree={tree1}
      f={$t.f}
      color="rgba(81, 181, 124, {opacity})" />
  </g>
  <g transform="translate({w * 0.65} {w * 0.65}) rotate({360 - $t.rot * 180})">
    <Tree
      size={w / 16}
      tree={tree2}
      f={1 - $t.f}
      color="rgba(89, 183, 186, {opacity})" />
  </g>
</svg>
