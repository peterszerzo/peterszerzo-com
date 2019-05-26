import "./webcomponents";

const modal = {
  mount: innerHTML => {
    document.getElementById("modal-container").innerHTML = `
      <div class="modal">
      ${innerHTML}
      </div>
        `;
    document.body.style.overflow = "hidden";
  },
  unmount: () => {
    document.getElementById("modal-container").innerHTML = "";
    document.body.style.overflow = "auto";
  }
};

export const router = () => {
  let route = window.location.pathname;
  const chunks = route.split("/").filter(chunk => chunk !== "");
  if (chunks.length !== 2) {
    return;
  }
  const [sketchType, sketchName] = chunks;
  modal.mount(`<my-sketch sketch-type="${sketchType}" sketch-name="${sketchName}" size="full" animating="true"></my-sketch>`);
};

router();
