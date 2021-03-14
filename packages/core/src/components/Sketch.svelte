<script lang="ts">
  import * as sk from "../sketches/index";
  import { onMount, onDestroy, tick } from "svelte";

  export let size;
  export let url;
  export let name;
  export let playing: boolean = false;

  let canvas;
  let container;
  let containerSize;
  let sketch;
  let animation;

  $: (() => {
    if (animation) {
      if (playing) {
        animation.start();
      } else {
        animation.stop();
      }
    }
  })();

  $: canvasContext = canvas && canvas.getContext("2d");

  $: finalSize = size || containerSize;

  onMount(async () => {
    sketch = sk.sketches(name)();

    await tick();
    await tick();

    if (sketch.step) {
      animation = sk.createAnimation(({ deltaTime, playhead }) => {
        if (canvasContext) {
          sketch.step({
            size: finalSize,
            context: canvasContext,
            deltaTime: deltaTime,
            playhead: playhead
          });
        }
      });
    }

    const w =
      container &&
      container.parentElement &&
      Math.min(524, container.parentElement.clientWidth);
    containerSize = w || 300;
  });

  onDestroy(() => {
    if (sketch && sketch.stop) {
      sketch.stop();
    }
  });
</script>

<style>
  .sketch {
    display: inline-block;
    overflow: hidden;
    position: relative;
  }

  a.sketch:hover {
    filter: brightness(96%);
  }
</style>

{#if url}
  <a
    class="sketch"
    href={url}
    style={`width: ${finalSize}px; height: ${finalSize}px;`}
    bind:this={container}>
    <canvas width={finalSize} height={finalSize} bind:this={canvas} />
  </a>
{:else}
  <div
    class="sketch"
    style={`width: ${finalSize}px; height: ${finalSize}px;`}
    bind:this={container}>
    <canvas width={finalSize} height={finalSize} bind:this={canvas} />
  </div>
{/if}
