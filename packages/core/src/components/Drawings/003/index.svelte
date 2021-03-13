<script lang="ts">
  import reglSimpleFragment from "../reglSimpleFragment";

  export let playing: boolean = false;

  const frag = `
    precision mediump float;
    varying vec2 fragCoord;
    uniform float time;
    const vec3 color = vec3(69.0, 176.0, 164.0) / 255.0;
    void main() {
      vec2 grid = floor(fragCoord * 6.0) * (0.5 * sin(0.05 * time)) +
        0.2 * vec2(0.5 * sin(0.5 * time), 1.5 * cos(1.0 * time));
      gl_FragColor = vec4(color * (0.5 + 0.5 * sin(20.0 * grid.x + 0.25 * grid.y + 20.0 * 
        distance(fragCoord * 0.5, vec2(0.0)))), 1.0);
    }
  `;
</script>

<svelte:options immutable={true} />

<canvas
  style="width: 100%; height: 100%"
  use:reglSimpleFragment={{ playing, frag }} />
