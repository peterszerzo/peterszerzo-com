<a href={url}>
  <div class="logo-container">
    <svelte:component this={logoComponent} />
  </div>
  <p class="title">{title}</p>
  <small class="subtitle">{subtitle}</small>
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
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
    border-radius: 4px;
    text-decoration: none;
    position: relative;
    color: inherit;
    width: 160px;
    height: 160px;
    padding: 20px 10px;
    display: inline-block;
    margin-right: 20px;
    margin-bottom: 20px;
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
    color: var(--lighterGray);
    text-align: center;
    display: block;
  }
</style>
