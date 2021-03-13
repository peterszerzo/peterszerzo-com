<div class="switch" on:click={handleChange}>
  <div class="switch-thumb" class:switch-thumb-active={active}></div>
</div>

<style>
  .switch {
    position: relative;
    width: 36px;
    height: 18px;
    border-radius: 9px;
    cursor: pointer;
    color: var(--sage);
    border: 1px solid currentColor;
  }

  .switch:hover {
    color: var(--lighterSage);
  }

  .switch-thumb {
    width: 14px;
    height: 14px;
    border-radius: 7px;
    position: absolute;
    background-color: currentColor;
    top: 1px;
    left: 1px;
    transition: transform 0.2s ease-in-out;
  }

  .switch-thumb-active {
    transform: translate3d(18px, 0, 0);
  }
</style>

<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  export let active;

  const handleChange = () => {
    dispatch("change", !active);
  }
</script>
