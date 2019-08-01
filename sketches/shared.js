import "../sketches/elm";
import "../sketches/vanilla";
import "../sketches/p5";

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
<svg width="30" height="30" viewBox="0 0 50 50">
  <circle cx="25" cy="25" r="25">
  </circle>
  ${!isPlaying ? `<polygon points="20,15 20,35 35,25" fill="white" />` : ""}
  ${
    isPlaying
      ? `
  <g fill="white">
    <rect x="18" y="15" width="4" height="20"></rect>
    <rect x="28" y="15" width="4" height="20"></rect>
  </g>
  `
      : ""
  }
</svg>
`;

  class PlayButton extends HTMLElement {
    connectedCallback() {
      const isPlaying = Boolean(this.getAttribute("playing"));
      this.innerHTML = playButtonTemplate(isPlaying);
    }

    static get observedAttributes() {
      return ["playing"];
    }

    attributeChangedCallback() {
      console.log("changed");
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

      const sketchType = this.getAttribute("sketch-type");
      const sketchName = this.getAttribute("sketch-name");

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

      this.fullscreenLink = document.createElement("a");
      this.fullscreenLink.style.border = "0";
      this.fullscreenLink.style.display = "block";
      this.fullscreenLink.innerHTML = `
        <svg viewBox="0 0 1000 1000" width="30" height="30">
          <use xlink:href="#expand"></use>
        </svg>
      `;
      if (this.getAttribute("size") === "full") {
        this.fullscreenLink.setAttribute("href", "/");
      } else {
        this.fullscreenLink.setAttribute(
          "href",
          `/${sketchType}/${sketchName}`
        );
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
      const rawSize = this.getAttribute("size");
      if (rawSize === "full") {
        return Math.min(window.innerWidth, window.innerHeight) * 0.8;
      }
      return Number(rawSize) || 320;
    }

    disconnectedCallback() {
      this.playButton.removeEventListener("click", this.handlePlayPause);
    }
  }

  customElements.define("my-sketch", Sketch);
})();
