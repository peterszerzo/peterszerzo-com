<script lang="ts">
  import ElmArborist from "./logos/ElmArborist.svelte";
  import SplytLight from "./logos/SplytLight.svelte";
  import AnnaCingi from "./logos/AnnaCingi.svelte";
  import ElmGameroom from "./logos/ElmGameroom.svelte";

  export let url: string;
  export let title: string;
  export let subtitle: string;
  export let logo: string;

  $: logoComponent = (() => {
    switch (logo) {
      case "ElmArborist":
        return ElmArborist;
      case "SplytLight":
        return SplytLight;
      case "AnnaCingi":
        return AnnaCingi;
      case "ElmGameroom":
        return ElmGameroom;
      default:
        return SplytLight;
    }
  })();
</script>

<a href={url}>
  <div class="logo-container">
    <svelte:component this={logoComponent} />
  </div>
  <p class="title">{title}</p>
  <small class="subtitle">{subtitle}</small>
</a>

<style>
  a {
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    background-color: #fff;
    border-radius: 8px;
    text-decoration: none;
    position: relative;
    color: inherit;
    width: 160px;
    height: 160px;
    padding: 24px 12px;
    display: inline-block;
    margin-right: 20px;
    margin-bottom: 20px;
    transition: background-color 0.3s ease-in-out;
  }

  a:hover {
    background-color: #f5f5f5;
  }

  .logo-container {
    margin: auto auto 15px;
    width: 60px;
    height: 60px;
  }

  p {
    margin: 0;
    text-align: center;
  }

  .subtitle {
    color: var(--lighterGray);
    text-align: center;
    display: block;
  }
</style>
