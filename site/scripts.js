import createSketch03 from "../sketches/src/03.js";
import createSketch04 from "../sketches/src/04.js";
import * as a from "../sketches/src/03.js";

const setAnimatingStyles = el => {
  el.style.boxShadow = "0 0 2px 0 rgba(0, 0, 0, 0.5)";
  el.style.transition = "box-shadow 0.1s ease-in-out";
  el.style.borderRadius = "3px";
  el.style.cursor = "pointer";
  el.style.overflow = "hidden";
  el.style.width = "320px";
  el.style.height = "320px";
};

const setNotAnimatingStyles = el => {
  el.style.boxShadow = "0 0 10px 0 rgba(0, 0, 0, 0.3)";
  el.style.transition = "box-shadow 0.1s ease-in-out";
  el.style.borderRadius = "3px";
  el.style.cursor = "pointer";
  el.style.overflow = "hidden";
  el.style.width = "320px";
  el.style.height = "320px";
};

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class OverEasy extends HTMLElement {
    connectedCallback() {
      const div = document.createElement("div");
      let isAnimating = false;
      setNotAnimatingStyles(this);
      this.appendChild(div);
      const sketchName = this.getAttribute("sketch");
      let app;
      const handleSketch = name => e => {
        this.handleClick = () => {
          if (isAnimating) {
            app.ports.animate.send(false);
            setNotAnimatingStyles(this);
          } else {
            app.ports.animate.send(true);
            setAnimatingStyles(this);
          }
          isAnimating = !isAnimating;
        };
        this.addEventListener("click", this.handleClick)
        app = e.Elm[name].init({
          node: div
        });
      };
      switch (sketchName) {
        case "WalkWithMe":
          import("../skelmches/WalkWithMe.elm").then(
            handleSketch("WalkWithMe")
          );
          break;
        case "OurBearingsAreFragile":
          import("../skelmches/OurBearingsAreFragile.elm").then(
            handleSketch("OurBearingsAreFragile")
          );
          break;
        case "MarchingWindows":
          import("../skelmches/MarchingWindows.elm").then(
            handleSketch("MarchingWindows")
          );
          break;
      }
    }
  }

  customElements.define("over-easy", OverEasy);
})();

const animate = () => {
  requestAnimationFrame(() => {
    animate();
  });
};

const createAnimation = stepper => {
  let prevTime = new Date().getTime();
  let playhead = 0;
  let isAnimating = false;
  stepper({ deltaTime: 0, playhead: 0 });
  const animate = () => {
    const newTime = new Date().getTime();
    const deltaTime = newTime - prevTime;
    playhead += deltaTime;
    stepper({ deltaTime, playhead });
    prevTime = newTime;
    requestAnimationFrame(() => {
      if (isAnimating) {
        animate();
      }
    });
  };
  const start = () => {
    prevTime = new Date().getTime();
    isAnimating = true;
    animate();
  };
  const stop = () => {
    isAnimating = false;
  };
  const toggle = () => {
    isAnimating ? stop() : start();
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

  class CanvasSketch extends HTMLElement {
    connectedCallback() {
      let isAnimating = false;

      setNotAnimatingStyles(this);

      const canvas = document.createElement("canvas");
      canvas.setAttribute("width", "320");
      canvas.setAttribute("height", "320");
      const context = canvas.getContext("2d");
      const sketchName = this.getAttribute("sketch");
      const sketch = (() => {
        switch (sketchName) {
          case "03":
            return createSketch03();
          case "04":
            return createSketch04();
          default:
            return createSketch03();
        }
      })();
      const anim = createAnimation(({ deltaTime, playhead }) => {
        sketch.step({
          width: 320,
          height: 320,
          context,
          deltaTime: deltaTime,
          playhead: playhead
        });
      });
      this.appendChild(canvas);
      this.handleClick = () => {
        if (isAnimating) {
          anim.stop();
          setNotAnimatingStyles(this);
        } else {
          anim.start();
          setAnimatingStyles(this);
        }
        isAnimating = !isAnimating;
      };
      canvas.addEventListener("click", this.handleClick);
    }
  }

  customElements.define("canvas-sketch", CanvasSketch);
})();
