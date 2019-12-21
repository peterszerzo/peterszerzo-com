<script>
  import PauseIcon from "../components/PauseIcon.svelte";
  import PlayIcon from "../components/PlayIcon.svelte";
  import LinkIcon from "../components/LinkIcon.svelte";
  import { onMount } from "svelte";

  export let size;
  export let url;
  export let sketchName;
  export let initiallyPlaying;

  let isPlaying = false;

  const handlePlayPause = () => {
    isPlaying = !isPlaying;
  }

  onMount(async () => {
    isPlaying = initiallyPlaying;
    await import("../sketches/index.js");
  });
</script>

<div class="sketch" style={`width: ${size}px; height: ${size}px;`}>
  <vanilla-sketch size={size} name={sketchName} animating={isPlaying}></vanilla-sketch>
  <div class="sketch-controls">
    <button class="sketch-control-button" on:click={handlePlayPause}>
      {#if isPlaying}
        <PauseIcon />
      {:else}
        <PlayIcon />
      {/if}
    </button>
    {#if url}
      <a class="sketch-control-button" href={url}>
        <LinkIcon />
      </a>
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
