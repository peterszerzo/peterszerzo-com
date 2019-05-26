import "../sketches/elm"
import "../sketches/vanilla"
import "../sketches/p5"

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

  class Sketch extends HTMLElement {
    connectedCallback() {
      this.style.position = "relative";

      const size = this.getSize();

      let animating = Boolean(this.getAttribute("animating"));

      const sketchType = this.getAttribute("sketch-type");
      const sketchName = this.getAttribute("sketch-name");

      setContainerStyles({ size, animating })(this);

      this.handlePlayPause = () => {
        animating = !animating;
        setContainerStyles({ size, animating })(this);
        if (animating) {
          this.playButton.innerText = "Pause";
          this.sketchElement.setAttribute("animating", "true");
        } else {
          this.playButton.innerText = "Play";
          this.sketchElement.removeAttribute("animating");
        }
      };

      this.playButton = document.createElement("button");
      this.playButton.innerText = animating ? "Pause" : "Play";
      this.playButton.addEventListener("click", this.handlePlayPause);


      this.fullscreenLink = document.createElement("a");
      if (this.getAttribute("size") === "full") {
        this.fullscreenLink.setAttribute("href", "/");
        this.fullscreenLink.innerText = "Close";
      } else {
        this.fullscreenLink.setAttribute("href", `/${sketchType}/${sketchName}`);
        this.fullscreenLink.innerText = "Fullscreen";
      }

      const controlsContainer = document.createElement("div");
      controlsContainer.setAttribute("class", "sketch-controls");
      controlsContainer.appendChild(this.playButton);
      controlsContainer.appendChild(this.fullscreenLink);
      this.appendChild(controlsContainer);

      this.sketchElement = document.createElement(`${sketchType}-sketch`);
      this.sketchElement.setAttribute("name", sketchName);
      this.sketchElement.setAttribute("size", size);
      if (animating) {
        this.sketchElement.setAttribute("animating", "true");
      }
      this.appendChild(this.sketchElement);
    }

    getSize() {
      const rawSize = this.getAttribute("size")
      if (rawSize === "full") {
        return Math.min(window.innerWidth, window.innerHeight) * 0.8
      }
      return Number(rawSize) || 320
    }

    disconnectedCallback() {
      this.playButton.removeEventListener("click", this.handlePlayPause);
    }
  }

  customElements.define("my-sketch", Sketch);
})();
