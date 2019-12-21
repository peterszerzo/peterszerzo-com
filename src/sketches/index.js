import pivotFrame from "./pivot-frame";
import cosineBeetles from "./cosine-beetles";
import theSpin from "./the-spin";
import shyCircles from "./shy-circles";
import tickle from "./tickle";
import honestCash from "./honest-cash";
import bezierRail from "./bezier-rail";

export const sketchByName = {
  ["pivot-frame"]: pivotFrame,
  ["the-spin"]: theSpin,
  ["cosine-beetles"]: cosineBeetles,
  ["shy-circles"]: shyCircles,
  ["tickle"]: tickle,
  ["honest-cash"]: honestCash,
  ["bezier-rail"]: bezierRail
};

const sketches = sketchName => {
  return sketchByName[sketchName] || pivotFrame;
};

const animate = () => {
  requestAnimationFrame(() => {
    animate();
  });
};

const createAnimation = stepper => {
  let prevTime = new Date().getTime();
  let playhead = 0;
  let animating = false;
  stepper({ deltaTime: 0, playhead: 0 });
  const animate = () => {
    const newTime = new Date().getTime();
    const deltaTime = newTime - prevTime;
    playhead += deltaTime;
    stepper({ deltaTime, playhead });
    prevTime = newTime;
    requestAnimationFrame(() => {
      if (animating) {
        animate();
      }
    });
  };
  const start = () => {
    prevTime = new Date().getTime();
    animating = true;
    animate();
  };
  const stop = () => {
    animating = false;
  };
  const toggle = () => {
    animating ? stop() : start();
  };
  return {
    start,
    stop,
    toggle
  };
};

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class VanillaSketch extends HTMLElement {
    connectedCallback() {
      this.size = Number(this.getAttribute("size")) || 320;
      const animating = JSON.parse(this.getAttribute("animating"));

      this.canvas = document.createElement("canvas");
      this.canvas.setAttribute("width", this.size);
      this.canvas.setAttribute("height", this.size);
      this.appendChild(this.canvas);

      this.handleSave = ev => {
        if (ev.key === "s" && ev.ctrlKey) {
          const image = this.canvas
            .toDataURL("image/png")
            .replace("image/png", "image/octet-stream");
          window.location.href = image;
        }
      };

      document.addEventListener("keydown", this.handleSave);

      const context = this.canvas.getContext("2d");
      const sketchName = this.getAttribute("name");
      this.sketch = sketches(sketchName)(this.size);
      if (this.sketch.step) {
        this.anim = createAnimation(({ deltaTime, playhead }) => {
          this.sketch.step({
            size: this.size,
            context,
            deltaTime: deltaTime,
            playhead: playhead
          });
        });
        this.setAnimating();
      } else {
        this.sketch.still({
          size: this.size,
          width: this.size,
          height: this.size,
          context
        });
      }
    }

    static get observedAttributes() {
      return ["animating", "size"];
    }

    attributeChangedCallback() {
      const newSize = Number(this.getAttribute("size")) || 320;
      if (newSize !== this.size) {
        this.size = newSize;
        if (this.canvas) {
          this.canvas.setAttribute("width", this.size);
          this.canvas.setAttribute("height", this.size);
        }
      }
      this.setAnimating();
    }

    setAnimating() {
      const animating = JSON.parse(this.getAttribute("animating"));
      if (animating) {
        this.anim && this.anim.start();
      } else {
        this.anim && this.anim.stop();
      }
    }

    disconnectedCallback() {
      this.anim && this.anim.stop();
      document.removeEventListener("keydown", this.handleSave);
    }
  }

  customElements.define("vanilla-sketch", VanillaSketch);
})();
