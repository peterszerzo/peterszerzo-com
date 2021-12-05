<script lang="ts">
  import { marked } from "marked";

  export let md: string;

  $: htmlContent = marked(md);
</script>

<div class="static">
  {@html htmlContent}
</div>

<style>
  .static :global(ul) {
    list-style: initial;
    padding-left: 20px;
  }
</style>
