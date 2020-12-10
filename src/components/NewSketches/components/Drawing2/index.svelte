<script lang="ts" context="module">
  import { distance, unitRange } from '$components/utils';
  import { hierarchy, pack } from "d3-hierarchy";

  const colorScheme = ["#22162B", "#451F55", "#724E91", "#E54F6D", "#F8C630"];

  const initNodes = () => {
    const outerPad = 1/12;
    const pk = pack().size([1 - outerPad * 2, 1 - outerPad * 2]).padding(1 / 33);
    const nodes = {
      children: unitRange(90).map(() => ({
        name: "name",
        size: (Math.random() + 0.1) / 1.2
      })),
      name: "name"
    };
    const root = hierarchy(nodes);
    root.sum(d => d.size);
    const rootNode = pk(root);
    const resultNodes = rootNode.children.map(child => {
      const r = distance([child.x, child.y], [0.5, 0.5]);
      return {
        x: child.x + outerPad,
        y: child.y + outerPad,
        r,
        size: child.r * 3.2,
        direction: Math.floor(2 * Math.random()) - 1,
        rotation: Math.floor(Math.random() * (360 / 45)) * 45,
        color: colorScheme[Math.floor(Math.random() * colorScheme.length)]
      }
    });
    return resultNodes;
  }
</script>

<script lang="ts">
  import Arc from '$components/Drawing2/Arc.svelte';
  import { spring } from 'svelte/motion';
  import { onMount } from 'svelte';
  import { diffStore } from '$components/utils';
  import SimplexNoise from 'simplex-noise';

	const t = spring({ r: 3, n: 0 }, {
		stiffness: 0.01,
		damping: 0.15
	});

  const dt = diffStore(t);

  const simplex = new SimplexNoise('my-seed-no');

  const shuffle = () => {
    const val = simplex.noise2D(new Date().getTime() / 100, 0);
    $t = { r: val * 64, n: Math.floor(Math.random() * 4) };
  }

  onMount(() => {
    shuffle();
    const interval = setInterval(shuffle, 1200);
    return () => {
      clearInterval(interval);
    }
  });

  const w = 524;

  const abs = Math.abs;

  const nodes = initNodes();
</script>

<svg width={w} height={w} viewBox="0 0 {w} {w}">
  <rect x="0" y="0" width={w} height={w} fill="#FFF" />
  <g transform="scale({1 + 0.005 * abs($dt ? $dt.r : 0)})" transform-origin="50% 50%">
    {#each nodes as node}
      <g
        transform="
          rotate({$t.r * 4 * (0.4 - node.r)})
          translate({
            w * (((node.x - 0.5) * (1 + abs($dt ? $dt.r : 0) * 0.02)) + 0.5)
          }, {
            w * (((node.y - 0.5) * (1 + abs($dt ? $dt.r : 0) * 0.02)) + 0.5)
          })
        "
        transform-origin="50% 50%"
      >
        <Arc
          r={w * node.size / 1}
          fill={node.color}
          transform="rotate({-$t.r * 4 * (0.4 - node.r) + node.rotation + $t.n * 45 * node.direction})"
        />
      </g>
    {/each}
  </g>
</svg>
