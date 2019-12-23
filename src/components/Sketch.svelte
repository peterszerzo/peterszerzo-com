<script>
  import PauseIcon from "../components/PauseIcon.svelte";
  import PlayIcon from "../components/PlayIcon.svelte";
  import LinkIcon from "../components/LinkIcon.svelte";
  import SaveIcon from "../components/SaveIcon.svelte";
  import * as sk from "../sketches/index.js";
  import { onMount, onDestroy, tick } from "svelte";

  export let size;
  export let url;
  export let name;
  export let allowSave;
  export let initiallyPlaying;

  let isPlaying = false;

  const handlePlayPause = () => {
    isPlaying = !isPlaying;
  }

  let canvas;
  let container;
  let containerSize;
  let sketch;
  let animation;

  $ : (() => {
    if (animation) {
      if (isPlaying) {
        animation.start();
      } else {
        animation.stop();
      }
    }
  })();

  const handleSave = () => {
    if (canvas) {
      const image = canvas
        .toDataURL("image/png")
        .replace("image/png", "image/octet-stream");
      window.location.href = image;
    }
  }

  $ : canvasContext = canvas && canvas.getContext("2d");

  $ : finalSize = size || containerSize;

  onMount(async () => {
    isPlaying = initiallyPlaying;

    sketch = sk.sketches(name)();

    await tick();
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

    const w = container && container.parentElement && Math.min(480, container.parentElement.clientWidth);
    containerSize = w || 300;
  });

  onDestroy(() => {
    if (sketch && sketch.stop) {
      sketch.stop();
    }
  });
</script>

<div class="sketch" style={`width: ${finalSize}px; height: ${finalSize}px;`} bind:this={container}>
  <canvas width={finalSize} height={finalSize} bind:this={canvas} />
  <div class="sketch-controls">
    <button class="sketch-control-button" on:click={handlePlayPause} title={isPlaying ? "Pause" : "Play"}>
      {#if isPlaying}
        <PauseIcon />
      {:else}
        <PlayIcon />
      {/if}
    </button>
    {#if url}
      <a title="View sketch page" class="sketch-control-button" href={url}>
        <LinkIcon />
      </a>
    {/if}
    {#if allowSave}
      <button class="sketch-control-button" on:click={handleSave} title="Save sketch">
        <SaveIcon />
      </button>
    {/if}
  </div>
</div>

<style>
.sketch {
  position: relative;
}

.sketch-controls {
  position: absolute;
  bottom: 5px;
  right: 5px;
  border-radius: 4px;
  z-index: 100;
  align-items: center;
  justify-content: center;
  display: flex;
  transition: opacity 0.1s ease-in-out;
  /* state styles */
  opacity: 1;
  pointer-events: all;
}

.sketch:hover .sketch-controls {
  opacity: 1;
  pointer-events: all;
}

@media (min-width: 640px) {
  .sketch-controls {
    opacity: 0;
    pointer-events: none;
  }
}

.sketch-controls * {
  display: inline-block;
  margin-left: 5px;
}

.sketch-controls *:first-child {
  margin-left: 0;
}

.sketch-control-button {
  display: block;
  background: none;
  border: 0;
  padding: 0;
  margin: 0;
  color: var(--black);
  width: 24px;
  height: 24px;
  cursor: pointer;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 50%;
  padding: 4px;
}

.sketch-control-button :global(svg) {
  width: 16px;
  height: 16px;
  vertical-align: top;
}

.sketch-control-button:hover {
  background-color: rgba(255, 255, 255, 1);
  color: var(--sage);
}

.sketch-control-button:focus {
  outline: none;
}
</style>
