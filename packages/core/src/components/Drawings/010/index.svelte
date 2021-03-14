<script lang="ts">
  import sketch from "../../../sketches/honest-cash";
  import canvasSketch from "../canvasSketch";

  export let playing: boolean = true;
</script>

<canvas use:canvasSketch={{ playing, sketch }} />
