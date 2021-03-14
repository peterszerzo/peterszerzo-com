<script lang="ts">
  import { onMount } from "svelte";
  import Squiggle from "./Squiggle.svelte";

  export let playing: boolean = false;

  let tick = 2;

  const shuffle = () => {
    if (playing) {
      tick++;
    }
  };

  const transitionDuration: number = 150;

  onMount(() => {
    const interval = setInterval(shuffle, transitionDuration);
    return () => {
      clearInterval(interval);
    };
  });
</script>

<svg width="100%" height="100%" viewbox="0 0 1000 1000">
  <g transform="translate(350 400)">
    <Squiggle {tick} width={240} color="#19647E" {transitionDuration} />
  </g>
  <g transform="translate(650 600)">
    <Squiggle
      {tick}
      width={240}
      type="sharp"
      seed="seed-2"
      color="#DD1C1A"
      {transitionDuration} />
  </g>
</svg>
