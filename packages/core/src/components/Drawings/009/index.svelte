<script lang="ts">
  import sketch from "../../../sketches/misfit-planets";
  import canvasSketch from "../canvasSketch";

  export let playing: boolean = true;
</script>

<canvas use:canvasSketch={{ playing, sketch }} />
