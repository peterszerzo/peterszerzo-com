<div class="static">
  {@html htmlContent}
</div>

<script>
  import marked from "marked";

  export let md;

  $ : htmlContent = marked(md);
</script>

<style>
  .static :global(ul) {
    list-style: initial;
    padding-left: 20px;
  }
</style>
