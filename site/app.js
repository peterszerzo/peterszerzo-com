import "./scripts";

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

const router = () => {
  let route = window.location.pathname;
  const chunks = route.split("/").filter(chunk => chunk !== "");
  if (chunks.length !== 2) {
    return;
  }
  const [group, sketchName] = chunks;
  switch (group) {
    case "overeasy":
      modal.mount(`<over-easy sketch="${sketchName}" size="480"></over-easy>`);
      break;
    case "sketches":
      modal.mount(
        `<canvas-sketch sketch="${sketchName}" size="540"></canvas-sketch>`
      );
      break;
  }
};

// router();
