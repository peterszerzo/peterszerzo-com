import cubies from "./01-cubies";
import quads from "./02-quads";

const sketches = sketchName => {
  switch (sketchName) {
    case "cubies":
      return cubies;
    case "quads":
      return quads;
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
      const animating = Boolean(this.getAttribute("animating"));

      const container = document.createElement("div");
      container.style.width = size;
      container.style.height = size;
      this.appendChild(container);

      const sketchName = this.getAttribute("sketch");
      const sketchCreator = sketches(sketchName);
      import("p5").then(p5 => {
        this.p5Sketch = new p5(sketchCreator(size), container);
        this.setAnimating();
      });
    }

    static get observedAttributes() {
      return ["animating"];
    }

    attributeChangedCallback() {
      this.setAnimating();
    }

    setAnimating() {
      const animating = Boolean(this.getAttribute("animating"));
      if (animating) {
        this.p5Sketch && this.p5Sketch.loop();
      } else {
        this.p5Sketch && this.p5Sketch.noLoop();
      }
    }


    disconnectedCallback() {
      if (this.p5Sketch) {
        this.p5Sketch.remove();
      }
    }
  }

  customElements.define("p5-sketch", P5Sketch);
})();
