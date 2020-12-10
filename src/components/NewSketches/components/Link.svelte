<a class:active={active === href} href={href}><slot/></a>

<script lang="ts">
  export let href: string = "/";
  export let active: string;
</script>

<style>
  a {
    display: block;
    text-decoration: none;
    color: inherit;
    border-radius: 6px;
    color: #676767;
  }

  a:hover {
    color: #000000;
  }

  .active {
    color: #000000;
  }
</style>
