<script lang="ts">
  import { onMount, afterUpdate} from 'svelte';
  import Link from '$components/Link.svelte';

  let active;

  afterUpdate(() => {
    active = window.location.pathname;
  });

  const drawings = [
    { slug: 'drawing-1', title: "Drawing 1" },
    { slug: 'drawing-2', title: "Drawing 2" },
    { slug: 'drawing-3', title: "Drawing 3" },
    { slug: 'drawing-4', title: "Drawing 4" },
  ];

</script>

<nav>
  {#each drawings as drawing}
    <Link active={active} href={`/${drawing.slug}`}>{drawing.title}</Link>
  {/each}
</nav>

<style>
  nav {
    position: absolute;
    padding: 20px;
  }

  nav > :global(*) + :global(*) {
    margin-top: 12px;
  }
</style>
