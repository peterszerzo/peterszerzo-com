import { setContainerStyles } from "../shared";
import cubies from "./01-cubies";
import p5 from "p5";

const sketches = sketchName => {
  switch (sketchName) {
    case "cubies":
      return cubies;
    default:
      return cubies;
  }
};

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class P5Sketch extends HTMLElement {
    connectedCallback() {
      const size = Number(this.getAttribute("size")) || 320;
      let animating = Boolean(this.getAttribute("animating"));

      setContainerStyles({ size, animating })(this);

      const container = document.createElement("div");
      container.style.width = size;
      container.style.height = size;
      this.appendChild(container);

      const sketchName = this.getAttribute("sketch");
      const sketchCreator = sketches(sketchName);
      this.p5Sketch = new p5(sketchCreator(size), container);
    }

    disconnectedCallback() {
      if (this.p5Sketch) {
        this.p5Sketch.remove();
      }
    }
  }

  customElements.define("p5-sketch", P5Sketch);
})();
