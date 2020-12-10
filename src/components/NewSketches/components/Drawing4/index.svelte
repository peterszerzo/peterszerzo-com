<script lang="ts">
  import Tree from '$components/Drawing4/Tree.svelte';

  import { onMount } from 'svelte';
  import { spring } from 'svelte/motion';

  const t = spring(0, {
		stiffness: 0.016,
		damping: 0.22
	});

  const shuffle = () => {
    $t = Math.random() * 2;
  }

  onMount(() => {
    shuffle();
    const interval = setInterval(shuffle, 1000);
    return () => {
      clearInterval(interval);
    }
  });

  const w = 500;

  const tree = {
    children: [
      {
        children: [
          {
            children: []
          }
        ]
      },
      {
        children: [
          undefined,
          {
            children: []
          },
          {
            children: []
          },
        ]
      },
      {
        children: [
          {
            children: []
          },
          {
            children: [
              {
                children: []
              }
            ]
          }
        ]
      },
    ]
  };
</script>

<svg width={w} height={w} viewBox="0 0 {w} {w}">
  <rect width={w} height={w} fill="#000" />
  <g transform="translate({w / 2} {w / 2})">
    <Tree tree={tree} f={$t} />
  </g>
</svg>
