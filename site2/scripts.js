import { sketch } from "../sketches/src/04.js";

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class OverEasy extends HTMLElement {
    connectedCallback() {
      const div = document.createElement("div");
      this.appendChild(div);
      const sketchName = this.getAttribute("sketch");
      const handleSketch = name => e => {
        e.Elm.OverEasy[name].init({
          node: div
        });
      };
      switch (sketchName) {
        case "WalkWithMe":
          import("../overeasy/OverEasy/WalkWithMe.elm").then(
            handleSketch("WalkWithMe")
          );
          break;
        case "BureaucracyIsDistracting":
          import("../overeasy/OverEasy/BureaucracyIsDistracting.elm").then(
            handleSketch("BureaucracyIsDistracting")
          );
          break;
      }
    }
  }

  customElements.define("over-easy", OverEasy);
})();

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class CanvasSketch extends HTMLElement {
    connectedCallback() {
      const canvas = document.createElement("canvas");
      canvas.setAttribute("width", "500");
      canvas.setAttribute("height", "500");
      const context = canvas.getContext("2d");
      sketch()({
        width: 500,
        height: 500,
        context,
        deltaTime: 0
      })
      this.appendChild(canvas);
    }
  }

  customElements.define("canvas-sketch", CanvasSketch);
})();
