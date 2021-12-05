<script lang="ts">
  import Static from "$lib/components/Static.svelte";

  const md = `
Focusing on these three right now:

* Design and UI engineering for [NLX](https://nlx.ai).
* More or less weekly drawings on [Instagram](https://www.instagram.com/peterszerzo_/).
* Prepping to go back to [school](https://filmuniversitaet.de/studium/studienangebot/masterstudiengaenge/creative-technologies/). As a shorter-term goal, passing a hairy German language test.

Enjoying podcasts like [Brought to you by](https://podcasts.apple.com/us/podcast/brought-to-you-by/id1413374332) and [Oh No Ross and Carrie](http://ohnopodcast.com/). Reading [Who’s afraid of Virginia Woolf](https://en.wikipedia.org/wiki/Who%27s_Afraid_of_Virginia_Woolf%3F).
  `;
</script>

<svelte:head>
  <title>Now | Peter Szerzo</title>
</svelte:head>

<div class="static-page">
  <h1>Peter’s Now Page</h1>

  <blockquote>
    The /now page is Derek Sivers’
    <a href="https://sivers.org/nowff">brilliant idea</a>. Thank you, Derek!
  </blockquote>

  <Static {md} />
</div>

<style>
  .static-page > :global(*) {
    margin-bottom: 40px;
  }

  .static-page > :global(:last-child) {
    margin-bottom: 0;
  }
</style>
