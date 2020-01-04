<a href={url}>
  <div class="logo-container">
    <svelte:component this={logoComponent} />
  </div>
  <p class="title">{title}</p>
  <p class="subtitle">{subtitle}</p>
</a>

<script>
  import ElmArborist from "./logos/ElmArborist.svelte";
  import SplytLight from "./logos/SplytLight.svelte";
  import AnnaCingi from "./logos/AnnaCingi.svelte";
  import ElmGameroom from "./logos/ElmGameroom.svelte";

  export let url;
  export let title;
  export let subtitle;
  export let logo;

  $ : logoComponent = (() => {
    switch(logo) {
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

<style>
  a {
    text-decoration: none;
    position: relative;
    color: inherit;
    width: 160px;
    height: 160px;
    padding: 10px;
    display: inline-block;
  }

  a:hover {
    background-color: var(--faintGray);
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
    font-size: 13px;
    color: var(--lighterGray);
  }
</style>
