import { setContainerStyles } from "../shared";
import pack from "./03-pack";
import theSpin from "./04-the-spin";

const sketches = sketchName => {
  switch (sketchName) {
    case "pack":
      return pack;
    case "the-spin":
      return theSpin;
    default:
      return pack;
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
      let animating = Boolean(this.getAttribute("animating"));

      setContainerStyles({ size, animating })(this);

      const canvas = document.createElement("canvas");
      canvas.setAttribute("width", size);
      canvas.setAttribute("height", size);
      const context = canvas.getContext("2d");
      const sketchName = this.getAttribute("sketch");
      const sketch = sketches(sketchName)(size);
      const anim = createAnimation(({ deltaTime, playhead }) => {
        sketch.step({
          width: size,
          height: size,
          context,
          deltaTime: deltaTime,
          playhead: playhead
        });
      });
      this.appendChild(canvas);
      this.handleClick = () => {
        animating = !animating;
        setContainerStyles({ size, animating })(this);
        if (animating) {
          anim.start();
        } else {
          anim.stop();
        }
      };
      canvas.addEventListener("click", this.handleClick);
    }
  }

  customElements.define("vanilla-sketch", VanillaSketch);
})();
