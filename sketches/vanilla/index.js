import pivotFrame from "./pivot-frame";
import cosineBeetles from "./cosine-beetles";
import theSpin from "./the-spin";
import shyCircles from "./shy-circles";
import wildyThings from "./wildy-things";

const sketches = sketchName => {
  switch (sketchName) {
    case "pivot-frame":
      return pivotFrame;
    case "the-spin":
      return theSpin;
    case "cosine-beetles":
      return cosineBeetles;
    case "shy-circles":
      return shyCircles;
    case "wildy-things":
      return wildyThings;
    default:
      return pivotFrame;
  }
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
      const size = Number(this.getAttribute("size")) || 320;
      const animating = Boolean(this.getAttribute("animating"));

      const canvas = document.createElement("canvas");
      canvas.setAttribute("width", size);
      canvas.setAttribute("height", size);
      this.appendChild(canvas);

      const context = canvas.getContext("2d");
      const sketchName = this.getAttribute("name");
      const sketch = sketches(sketchName)(size);
      if (sketch.step) {
        this.anim = createAnimation(({ deltaTime, playhead }) => {
          sketch.step({
            width: size,
            height: size,
            context,
            deltaTime: deltaTime,
            playhead: playhead
          });
        });
        this.setAnimating();
      } else {
        sketch.still({
          width: size,
          height: size,
          context
        });
      }
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
        this.anim && this.anim.start();
      } else {
        this.anim && this.anim.stop();
      }
    }

    disconnectedCallback() {
      this.anim && this.anim.stop();
    }
  }

  customElements.define("vanilla-sketch", VanillaSketch);
})();
