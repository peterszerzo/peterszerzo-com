<script lang="ts">
  import { onMount } from "svelte";
  import { spring } from "svelte/motion";

  export let playing: boolean = false;

  const range = n => [...Array(n).keys()];

  const r = 40;

  const t = spring(0, {
    stiffness: 0.001,
    damping: 0.02
  });

  const shuffle = () => {
    if (!playing) {
      return;
    }
    $t = Math.floor(4 * (Math.random() - 0.5));
  };

  onMount(() => {
    const interval = setInterval(shuffle, 2000);
    return () => {
      clearInterval(interval);
    };
  });

  const colorScheme1 = {
    bg1: "#0B4B6F",
    bg2: "#041725",
    stroke: "#F05365",
    strokeShadow: "#A1C6EA"
  };

  const colorScheme2 = {
    bg1: "#745C97",
    bg2: "#39375B",
    stroke: "#DC6ACF",
    strokeShadow: "#E8FFFF"
  };

  const colorScheme = colorScheme1;

  const hexGrid = ({ n, m }) =>
    range(n)
      .map(i => range(m).map(j => [i, j]))
      .reduce((accumulator, current) => [...accumulator, ...current], [])
      .reduce((accumulator, [i, j]) => {
        const hexagonCenter = Math.floor(j / 2);
        const hexagonDeviation = (j % 2) - 0.5;
        return [
          ...accumulator,
          {
            i,
            j,
            x:
              hexagonCenter * 3 * 2 * r +
              hexagonDeviation * 2 * r * (i % 2 == 0 ? 1 : 2),
            y: (2 * r * i * Math.sqrt(3)) / 2
          }
        ];
      }, []);

  const grid = hexGrid({ n: 22, m: 14 });

  const w = 1000;

  const PI = Math.PI;

  const getRotation = (tCurrent, i, j) => {
    return i + j + i * j + $t * 2;
  };

  const angle = 120;

  $: sinAngle = Math.sin((angle * Math.PI) / 180);
  $: cosAngle = Math.cos((angle * Math.PI) / 180);
</script>

<svg width="100%" height="100%" viewBox="0 0 {w} {w}">
  <defs>
    <linearGradient id="006-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color={colorScheme.bg1} />
      <stop offset="100%" stop-color={colorScheme.bg2} />
    </linearGradient>
  </defs>
  <rect x="0" y="0" width={w} height={w} fill="url(#006-gradient)" />
  <g
    transform="translate({w * (0.5 + 0.05 * $t)} {w * (0.5 + 0.03 * $t)}) rotate({$t * 15}) scale(1) translate({-w / 2} {-w / 2})">
    {#each grid as pt}
      <g
        transform="translate({-w * 0.2 + pt.x + w * 0.005} {-w * 0.2 + pt.y + w * 0.005}) rotate({60 * getRotation($t, pt.i, pt.j)})">
        <path
          d="M{r},0 A {r},{r} 0 1 1 {r * cosAngle},{-r * sinAngle}"
          stroke={colorScheme.strokeShadow}
          fill="none"
          stroke-width="16"
          stroke-linecap="round"
          stroke-linejoin="round" />
      </g>
    {/each}
    {#each grid as pt}
      <g
        transform="translate({-w * 0.2 + pt.x} {-w * 0.2 + pt.y}) rotate({60 * getRotation($t, pt.i, pt.j)})">
        <path
          d="M{r},0 A {r},{r} 0 1 1 {r * cosAngle},{-r * sinAngle}"
          stroke={colorScheme.stroke}
          fill="none"
          stroke-width="16"
          stroke-linecap="round"
          stroke-linejoin="round" />
      </g>
    {/each}
  </g>
</svg>
