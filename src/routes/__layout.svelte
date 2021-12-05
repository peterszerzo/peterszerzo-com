<script lang="ts">
  import "../app.css";
  import { navigating } from "$app/stores";
  import Footer from "$lib/components/Footer.svelte";
  import Header from "$lib/components/Header.svelte";
</script>

<Header />

<div class="container">
  <div class="overlay" class:overlayActive={$navigating} />
  <slot />
</div>

<Footer />

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

  .overlay {
    position: fixed;
    z-index: 100000;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    pointer-events: none;
    opacity: 0;
    transition: opacity 0.2s ease-in-out;
    background-color: rgba(255, 255, 255, 0.4);
  }

  .overlayActive {
    opacity: 1;
  }
</style>
