import * as elmSketches from "../sketches/elm";
import * as vanillaSketches from "../sketches/vanilla";
import * as p5Sketches from "../sketches/p5";

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

  const playButtonTemplate = isPlaying => `
<svg width="30" height="30" viewBox="0 0 1000 1000" fill="currentColor">
  ${
    !isPlaying
      ? `
    <circle cx="500" cy="500" r="500">
    </circle>
    <polygon points="400,300 400,700 700,500" fill="#FFFFFF" />
  `
      : `
    <circle cx="500" cy="500" r="500">
    </circle>
    <g fill="white">
      <rect x="360" y="300" width="80" height="400" fill="#FFFFFF"></rect>
      <rect x="560" y="300" width="80" height="400" fill="#FFFFFF"></rect>
    </g>
  `
  }
</svg>
`;

  class PlayButton extends HTMLElement {
    connectedCallback() {
      const isPlaying = Boolean(this.getAttribute("playing"));
      this.className = "sketch-control-button";
      this.innerHTML = playButtonTemplate(isPlaying);
    }

    static get observedAttributes() {
      return ["playing"];
    }

    attributeChangedCallback() {
      const isPlaying = Boolean(this.getAttribute("playing"));
      this.innerHTML = playButtonTemplate(isPlaying);
    }
  }

  customElements.define("play-button", PlayButton);

  class Sketch extends HTMLElement {
    connectedCallback() {
      this.style.position = "relative";

      const size = this.getSize();

      let animating = Boolean(this.getAttribute("animating"));

      const sketchName = this.getAttribute("sketch-name");

      const sketchType = elmSketches.sketchByName[sketchName]
        ? "elm"
        : vanillaSketches.sketchByName[sketchName]
          ? "vanilla"
          : "p5";

      setContainerStyles({ size, animating })(this);

      this.handlePlayPause = () => {
        animating = !animating;
        setContainerStyles({ size, animating })(this);
        if (animating) {
          this.playButton.setAttribute("playing", "true");
          this.sketchElement.setAttribute("animating", "true");
        } else {
          this.playButton.removeAttribute("playing");
          this.sketchElement.removeAttribute("animating");
        }
      };

      this.playButton = document.createElement("play-button");
      if (animating) {
        this.playButton.setAttribute("playing", "true");
      } else {
        this.playButton.removeAttribute("playing");
      }
      this.playButton.addEventListener("click", this.handlePlayPause);

      const url = this.getAttribute("url");
      if (url) {
        this.fullscreenLink = document.createElement("a");
        this.fullscreenLink.className = "sketch-control-button";
        this.fullscreenLink.style.border = "0";
        this.fullscreenLink.style.display = "block";
        this.fullscreenLink.setAttribute("href", url);
        this.fullscreenLink.innerHTML = `
        <svg width="30" height="30" viewBox="0 0 1000 1000" fill="currentColor">
          <rect x="100" y="100" width="300" height="100"></rect>
          <rect x="100" y="100" width="100" height="300"></rect>
          <rect x="600" y="100" width="300" height="100"></rect>
          <rect x="800" y="100" width="100" height="300"></rect>
          <rect x="100" y="600" width="100" height="300"></rect>
          <rect x="100" y="800" width="300" height="100"></rect>
          <rect x="600" y="800" width="300" height="100"></rect>
          <rect x="800" y="600" width="100" height="300"></rect>
        </svg>
      `;
      }

      const controlsContainer = document.createElement("div");
      controlsContainer.setAttribute("class", "sketch-controls");
      controlsContainer.appendChild(this.playButton);
      this.fullscreenLink && controlsContainer.appendChild(this.fullscreenLink);
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
      const rawSize = this.getAttribute("size");
      if (rawSize === "full") {
        return Math.min(
          Math.min(window.innerWidth, window.innerHeight) * 0.8,
          524
        );
      }
      return Number(rawSize) || 320;
    }

    disconnectedCallback() {
      this.playButton.removeEventListener("click", this.handlePlayPause);
    }
  }

  customElements.define("my-sketch", Sketch);
})();
