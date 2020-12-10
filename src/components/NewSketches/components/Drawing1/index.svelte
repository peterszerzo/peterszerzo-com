<script lang="ts">
  import { onMount } from 'svelte';
  import { spring } from 'svelte/motion';
  import { range2 } from '$components/utils';
  import SimplexNoise from 'simplex-noise';
  import tinycolor from 'tinycolor2';

  const t = spring({
    rotation: 3,
    displaceX: 0,
    displaceY: 0,
    displaceFraction: 0,
  }, {
		stiffness: 0.016,
		damping: 0.22
	});

  const simplex = new SimplexNoise('my-seed-no');

  let k = 12;

  const shuffle = () => {
    const val = simplex.noise2D(new Date().getTime() / 100, 0);
    if (val > 0.5) {
      // k = Math.floor(5 + 10 * Math.random());
    }
    const displace = Math.random() - 0.5;
    const xOrY = Math.random() < 0.5;
    $t = {
      rotation: val * 8,
      displaceX: xOrY ? displace : 0,
      displaceY: xOrY ? 0 : displace,
      displaceFraction: Math.random(),
    };
  }

  onMount(() => {
    shuffle();
    const interval = setInterval(shuffle, 1000);
    return () => {
      clearInterval(interval);
    }
  });

  const w = 524;

  const p = 0.25;

  $: pts = range2(k).map((pos, i) => {
    const sizeGrid = 5;
    const sizeFactor = simplex.noise2D(sizeGrid * pos[0], sizeGrid * pos[1]);
    const colorGrid = 16;
    const colorFactor = simplex.noise2D(colorGrid * pos[0], colorGrid * pos[1]);
    const rotateFactor = simplex.noise2D(11 * pos[0], 11 * pos[1]);
    const size = 0.9 * sizeFactor + 0.9;
    const absoluteSize = w * size / k / 3;
    return {
      pos,
      transformCache: ($t) => `translate(${
        (p + pos[0] * (1 - 2 * p)) * w + (pos[1] < 0.5 ? -$t.displaceX : $t.displaceX) * w / 5
      } ${
        (p + pos[1] * (1 - 2 * p)) * w + (pos[0] < 0.5 ? -$t.displaceY : $t.displaceY) * w / 5
      })`,
      color: tinycolor('#185E77').darken(12 * colorFactor).toHexString(),
      size,
      absoluteSize, 
      rotateOffset: 4 + 4 * simplex.noise2D(8 * pos[0], 8 * pos[1]),
      rotateDirection: rotateFactor <= 0 ? 1 : -1,
    };
  });

</script>

<svg width={w} height={w} viewBox="0 0 {w} {w}">
  <g transform="rotate({$t.rotation * 4})" transform-origin="50% 50%">
    {#each pts as pt}
      <g transform={pt.transformCache($t)}>
        <circle
          cx={0}
          cy={0}
          r={pt.absoluteSize}
          fill={pt.color}
        />
      </g>
    {/each}
    {#each pts as pt}
      <g transform={pt.transformCache($t)}>
        <circle
          transform="rotate({pt.rotateDirection * -$t.rotation * 32 + 225 + pt.rotateOffset * 15})"
          cx={pt.absoluteSize * 0.40}
          cy={0}
          r={pt.absoluteSize * 0.25}
          fill="#FFBF1F" 
        />
      </g>
    {/each}
  </g>
</svg>

<style>
</style>
