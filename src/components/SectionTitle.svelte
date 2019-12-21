<div class="section-title">
  <div class="section-title-top">
    <h2>{title}</h2>
    <slot name="controls"></slot>
  </div>
  {#if subtitle}
    <p>{subtitle}</p>
  {/if}
</div>


<script>
  export let title;
  export let subtitle;
</script>

<style>
.section-title {
  margin-bottom: 25px;
}

.section-title-top {
  display: flex;
  align-items: center;
  justify-content: flex-start;
}

.section-title-top > *:not(:first-child) {
  margin-left: 10px;
}

h2 {
  width: fit-content;
  font-weight: 700;
  margin: 0 20px 0 0;
  position: relative;
}

h2::after {
  content: ' ';
  position: absolute;
  left: 0;
  right: 0;
  bottom: -3px;
  height: 3px;
  background-color: var(--sage);
}

p {
  color: #898989;
  line-height: 1;
}

</style>
