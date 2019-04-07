import Hammer from "hammerjs";
import debounce from "lodash/debounce";

/*
 * A container to detect swipe events
 */
(() => {
  if (!window.customElements || !window.HTMLElement) {
    return;
  }

  class SwipeContainer extends HTMLElement {
    connectedCallback() {
      const hammer = new Hammer.Manager(this);
      hammer.add(
        new Hammer.Pan({
          direction: Hammer.DIRECTION_HORIZONTAL,
          threshold: 30
        })
      );
      this.handlePanLeft = debounce(() => {
        this.broadcastPan("left");
      }, 200);
      this.handlePanRight = debounce(() => {
        this.broadcastPan("right");
      }, 200);
      hammer.on("panleft", this.handlePanLeft);
      hammer.on("panright", this.handlePanRight);
      this.hammer = hammer;
    }

    broadcastPan(name) {
      this.dispatchEvent(
        new CustomEvent(`pan${name}`, {
          detail: {}
        })
      );
    }

    disconnectedCallback() {
      this.hammer.remove();
    }
  }

  customElements.define("swipe-container", SwipeContainer);
})();
