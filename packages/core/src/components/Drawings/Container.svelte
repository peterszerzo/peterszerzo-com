<style>
  .container {
    width: 100%;
    padding: 10px;
  }

  .sketch {
    width: fit-content;
    margin: auto;
    box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.2);
    border-radius: 4px;
    width: 324px;
    height: 324px;
  }

  @media screen and (min-width: 768px) {
    .sketch {
      width: fit-content;
      box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.2);
      border-radius: 4px;
      width: 524px;
      height: 524px;
    }
  }
</style>

<div class="container">
  <div class="sketch">
    <slot />
  </div>
</div>
