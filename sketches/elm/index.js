(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  const capitalizeFirst = word =>
    word.slice(0, 1).toUpperCase() + word.slice(1);

  const slugToKey = slug =>
    slug
      .split("-")
      .map(capitalizeFirst)
      .join("");

  const getSketch = sketchName => {
    switch (sketchName) {
      case "marching-windows":
        return import("./MarchingWindows.elm");
      case "just-hanging-out":
        return import("./JustHangingOut.elm");
      case "ribbons":
        return import("./Ribbons.elm");
      case "envo":
        return import("./Envo.elm");
    }
  };

  class ElmSketch extends HTMLElement {
    connectedCallback() {
      const div = document.createElement("div");
      this.appendChild(div);
      const animating = Boolean(this.getAttribute("animating"));
      const size = Number(this.getAttribute("size")) || 320;
      const handleSketch = name => e => {
        this.app = e.Elm[slugToKey(name)].init({
          node: div,
          flags: {
            size,
            animating
          }
        });
      };
      const sketchName = this.getAttribute("name");
      getSketch(sketchName).then(handleSketch(sketchName));
    }

    static get observedAttributes() {
      return ["animating"];
    }

    attributeChangedCallback() {
      this.setAnimating();
    }

    setAnimating() {
      const animating = Boolean(this.getAttribute("animating"));
      this.app && this.app.ports.animate.send(animating);
    }
  }

  customElements.define("elm-sketch", ElmSketch);
})();
