<header>
  <a href="/">
    <Logo />
  </a>
</header>

<script>
  import Logo from "./Logo.svelte";
</script>

<style>
  header {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10000;
  }

  a {
    color: var(--sage);
    width: 40px;
    height: 40px;
    display: block;
  }

  a:hover {
    color: var(--lighterSage);
  }
</style>
