<script lang="ts">
  import reglSimpleFragment from "../reglSimpleFragment";

  export let playing: boolean = false;

  const frag = `
  precision mediump float;
  varying vec2 fragCoord;
  uniform float time;

  float doubleCircleSigmoid (float x, float a) {
    float min_param_a = 0.0;
    float max_param_a = 1.0;
    a = max(min_param_a, min(max_param_a, a)); 

    float y = 0.0;
    if (x <= a){
      y = a - sqrt(a * a - x * x);
    } else {
      y = a + sqrt((1.0 - a) * (1.0 - a) - (x - 1.0) * (x - 1.0));
    }
    return y;
  }

  void main() {
    vec2 st = fragCoord;
      
    const float units = 5.0;

    float time_ = time * 0.4 + 1.0;
    
    float r = 0.5 + 0.5 * sin(st.x * units + time_) * sin(st.y * units - time_ / 5.0);
    float b = 0.5 + 0.5 * sin(st.x * units + time_ / 5.0) * sin(st.y * units - time_);

    r = doubleCircleSigmoid(r, 0.5);
    b = doubleCircleSigmoid(b, 0.5);

    gl_FragColor = vec4(r, mix(r, b, 0.5 + 0.5 * sin(time_ * 2.0)), b, 1.0);
  }

  `;
</script>

<svelte:options immutable={true} />

<canvas
  style="width: 100%; height: 100%"
  use:reglSimpleFragment={{ playing, frag }} />
