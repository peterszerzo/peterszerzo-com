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
      modal.mount(`<elm-sketch sketch="${sketchName}" size="480"></elm-sketch>`);
      break;
    case "sketches":
      modal.mount(
        `<vanilla-sketch sketch="${sketchName}" size="540"></vanilla-sketch>`
      );
      break;
    case "p5":
      modal.mount(
        `<p5-sketch sketch="${sketchName}" size="540"></p5-sketch>`
      );
      break;
  }
};

router();
