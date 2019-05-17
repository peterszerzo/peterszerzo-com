import { setContainerStyles } from "../shared";

(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  const getSketch = sketchName => {
    switch (sketchName) {
      case "WalkWithMe":
        return import("./WalkWithMe.elm");
      case "OurBearingsAreFragile":
        return import("./OurBearingsAreFragile.elm");
      case "MarchingWindows":
        return import("./MarchingWindows.elm");
    }
  };

  class ElmSketch extends HTMLElement {
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

  customElements.define("elm-sketch", ElmSketch);
})();
