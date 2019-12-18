<script>
  import Footer from "../components/Footer.svelte";
</script>

<style>
.container {
  width: 100%;
  max-width: 800px;
  margin: auto;
  padding: 60px 15px;
}

.container > :global(*) {
  margin-bottom: 60px;
}

.container > :global(*:last-child) {
  margin-bottom: 0;
}

@media (min-width: 640px) {
  .container {
    padding: 140px 20px;
  }

  .container > :global(*) {
    margin-bottom: 100px;
  }

  .container > :global(*:last-child) {
    margin-bottom: 0;
  }
}
</style>

<div class="container">
  <slot></slot>
  <div class="divider"></div>
  <Footer />
</div>
