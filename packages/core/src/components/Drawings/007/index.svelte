<script lang="ts">
  import { onMount } from "svelte";
  import { spring } from "svelte/motion";
  import { lerp3, polyfloat } from "../utils";
  import { range } from "ramda";

  export let playing: boolean = false;

  const clamp = (n: number, min: number, max: number) =>
    Math.max(min, Math.min(n, max));

  const t = spring(
    {
      sides: 8,
      twist: 1,
    },
    {
      stiffness: 0.001,
      damping: 0.1,
    }
  );

  const shuffle = () => {
    if (!playing) {
      return;
    }
    $t = {
      sides: clamp(Math.floor($t.sides + 8 * (Math.random() - 0.5)), 5, 12),
      twist: clamp(
        Math.floor($t.twist * 8 + 8 * (Math.random() - 0.5)) / 8,
        0,
        1
      ),
    };
  };

  onMount(() => {
    const interval = setInterval(shuffle, 1200);
    return () => {
      clearInterval(interval);
    };
  });

  const n = 18;

  const rg = range(0, n);

  const color1 = [231, 235, 239];

  const color2 = [28, 31, 64];

  const colorByIndex = (index) => {
    const [r, g, b] = lerp3((index + 8) / (n - 1 + 8))(color1)(color2);
    return `rgb(${r}, ${g}, ${b})`;
  };

  $: pts = polyfloat($t.sides);

  $: radiusFactor = Math.cos((2 * Math.PI) / $t.sides / 2);

  $: angle = 360 / $t.sides / 2;

  const w = 1000;
</script>

<svg width="100%" height="100%" viewBox="0 0 {w} {w}">
  <g
    transform="translate({w / 2} {w / 2}) scale({3.5 + 0.04 * $t.sides}) rotate({60 * $t.sides - 120 * $t.twist})">
    {#each rg as index}
      <polygon
        transform="rotate({angle * index * $t.twist})"
        fill={colorByIndex(index)}
        stroke="rgba(0, 0, 0, 0.2)"
        stroke-width="0.2"
        stroke-linecap="round"
        stroke-linejoin="round"
        points={pts
          .map(
            ([x, y]) =>
              `${((x * w) / 4) * radiusFactor ** index},${
                ((y * w) / 4) * radiusFactor ** index
              }`
          )
          .join(' ')} />
    {/each}
  </g>
</svg>
