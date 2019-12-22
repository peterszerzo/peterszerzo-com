<script>
  import Footer from "../components/Footer.svelte";
  import Header from "../components/Header.svelte";
</script>

<style>
.container {
  width: 100%;
  max-width: 800px;
  margin: auto;
  padding: 120px 15px 80px;
}

@media (min-width: 640px) {
  .container {
    padding: 160px 20px 120px;
  }
}
</style>

<Header />

<div class="container">
  <slot></slot>
</div>

<Footer />
