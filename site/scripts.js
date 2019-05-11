import sketches from "../sketches";

const setContainerStyles = ({ size, animating }) => el => {
  el.style.width = size + "px";
  el.style.height = size + "px";
  el.style.transition = "box-shadow 0.1s ease-in-out";
  el.style.borderRadius = "3px";
  el.style.cursor = "pointer";
  el.style.overflow = "hidden";
  if (animating) {
    el.style.boxShadow = "0 0 2px 0 rgba(0, 0, 0, 0.5)";
  } else {
    el.style.boxShadow = "0 0 10px 0 rgba(0, 0, 0, 0.3)";
  }
};

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  const getSketch = sketchName => {
    switch (sketchName) {
      case "WalkWithMe":
        return import("../overeasy/WalkWithMe.elm");
      case "OurBearingsAreFragile":
        return import("../overeasy/OurBearingsAreFragile.elm");
      case "MarchingWindows":
        return import("../overeasy/MarchingWindows.elm");
    }
  };

  class OverEasy extends HTMLElement {
    connectedCallback() {
      const div = document.createElement("div");
      this.appendChild(div);
      let animating = Boolean(this.getAttribute("animating"));
      const size = Number(this.getAttribute("size")) || 320;
      setContainerStyles({ size, animating })(this);
      let app;
      const handleSketch = name => e => {
        this.handleClick = () => {
          animating = !animating;
          app.ports.animate.send(animating);
          setContainerStyles({ size, animating })(this);
        };
        this.addEventListener("click", this.handleClick);
        app = e.Elm[name].init({
          node: div,
          flags: {
            size,
            animating: false
          }
        });
      };
      const sketchName = this.getAttribute("sketch");
      getSketch(sketchName).then(handleSketch(sketchName));
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

  class CanvasSketch extends HTMLElement {
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

  customElements.define("canvas-sketch", CanvasSketch);
})();
