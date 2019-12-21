<script>
  import Footer from "../components/Footer.svelte";
  import Header from "../components/Header.svelte";

  export let segment;
</script>

<style>
.container {
  width: 100%;
  max-width: 800px;
  margin: auto;
  padding: 80px 15px;
}

@media (min-width: 640px) {
  .container {
    padding: 120px 20px;
  }
}
</style>

<div class="container">
  <Header />
  <slot></slot>
</div>

<Footer />
