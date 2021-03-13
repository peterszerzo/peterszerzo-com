<script lang="ts">
  import { range } from "ramda";
  import SimplexNoise from "simplex-noise";

  export let seed: string = "my-seed-no";
  export let width: number = 300;
  export let tick: number = 1;
  export let transitionDuration: number = 150;
  export let color: string = "#70F8BA";

  export let type: "round" | "sharp" = "round";

  $: simplex = new SimplexNoise(seed);

  const createSquiggle = (tick: number) => {
    const f = 1;
    const tf = 0.03;
    return range(0, 40).map((index: number) => [
      width * simplex.noise2D(tf * tick + index, tf * tick + index),
      width *
        simplex.noise2D(tf * tick + index + f * 1, tf * tick + index + f * 1),
      width *
        simplex.noise2D(tf * tick + index + f * 2, tf * tick + index + f * 2),
      width *
        simplex.noise2D(tf * tick + index + f * 3, tf * tick + index + f * 3),
    ]);
  };

  $: squiggle = createSquiggle(tick);

  $: pathDAttribute = squiggle
    .map((pt, index) => {
      if (index === 0) {
        return `M${pt[2]},${pt[3]}`;
      }
      if (type === "sharp") {
        return `L${pt[0] * 1.3},${pt[1] * 1.3}`;
      }
      return `S${pt[0]},${pt[1]} ${pt[2]},${pt[3]}`;
    })
    .join(" ");
</script>

<style>
  path {
    transition: var(--transitionDuration) linear;
  }
</style>

<g style="--transitionDuration: {transitionDuration}ms">
  <path
    transform="translate({width / 30} -{width / 30})"
    d={pathDAttribute}
    stroke={color}
    stroke-width={width / 30}
    stroke-linecap="round"
    stroke-linejoin="round"
    fill="none" />
  <path
    d={pathDAttribute}
    stroke="#000"
    stroke-width={width / 30}
    stroke-linecap="round"
    stroke-linejoin="round"
    fill="none" />
</g>
