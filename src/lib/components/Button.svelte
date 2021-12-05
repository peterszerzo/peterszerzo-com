<script lang="ts">
  export let label;
</script>

<button on:click>
  {label}
</button>

<style>
  button {
    border: 1px solid var(--sage);
    color: var(--sage);
    border-radius: 3px;
    line-height: 1;
    padding: 8px 10px 6px 10px;
  }

  button:hover {
    background-color: #f8f8f8;
  }

  button:focus {
    outline: none;
    box-shadow: 0 0 0 3px var(--faintSage);
  }
</style>
