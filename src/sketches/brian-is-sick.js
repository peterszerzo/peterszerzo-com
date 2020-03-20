import * as utils from "./utils/index";

const n = 12;

const grid = utils.range2(n)(n);

// Main

const smiley = "🙂";
const sneeze = "🤧";
const temp = "🤒";

// Cells logic

const toHash = ([i, j]) => `${i}-${j}`;

const distanceSq = ([i, j]) =>
  (((i - (n - 1) / 2) / (n - 1)) * 2) ** 2 +
  (((j - (n - 1) / 2) / (n - 1)) * 2) ** 2;

const neighborStates = cells => ([i, j]) =>
  [
    [i - 1, j - 1],
    [i - 1, j],
    [i - 1, j + 1],
    [i, j - 1],
    [i, j + 1],
    [i + 1, j - 1],
    [i + 1, j],
    [i + 1, j + 1]
  ]
    .map(coord => cells[toHash(coord)])
    .filter(val => !!val)
    .map(val => val.state);

const clone = obj => JSON.parse(JSON.stringify(obj));

const step = cells => {
  const newCells = clone(cells);
  Object.entries(cells).forEach(([key, cell]) => {
    if (cell.state === "dying") {
      newCells[key] = {
        ...cell,
        state: "off"
      };
      return;
    }
    if (cell.state === "on") {
      newCells[key] = {
        ...cell,
        state: "dying"
      };
      return;
    }
    if (cell.state === "off") {
      const neighbors = neighborStates(cells)([cell.i, cell.j]);
      newCells[key] = {
        ...cell,
        state:
          neighbors.filter(state => state === "on").length === 2 ? "on" : "off"
      };
      return;
    }
  });
  return newCells;
};

const ons = cells =>
  Object.values(cells).filter(cell => cell.state === "on").length;

const setOns = cells => {
  const newCells = clone(cells);
  Object.entries(newCells).forEach(([key, cell]) => {
    newCells[key].state =
      distanceSq([cell.i, cell.j]) < 0.15 && Math.random() < 0.6 ? "on" : "off";
  });
  return newCells;
};

const period = 150;

const createSketch = () => {
  let cells = {};
  utils
    .range2(n)(n)
    .forEach(([i, j]) => {
      cells[toHash([i, j])] = {
        i,
        j,
        state: "off"
      };
    });
  cells = setOns(cells);
  const kFont = 0.6;
  const drawControlCircles = false;
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      const isTick =
        Math.floor(playhead / period) !==
        Math.floor((playhead + deltaTime) / period);
      if (isTick) {
        cells = step(cells);
        if (ons(cells) === 0) {
          cells = setOns(cells);
        }
      }
      context.fillStyle = "#FFFFFF";
      context.fillRect(0, 0, size, size);

      context.font = `${(size / (n - 1)) * kFont}px monospace`;
      context.textAlign = "center";

      Object.values(cells).map(({ i, j, state }) => {
        const x = (i / n + 1 / 2 / n) * size;
        const y = (j / n + 1 / 2 / n) * size;
        context.fillStyle = "#000000";
        context.fillText(
          state === "on" ? temp : state === "dying" ? sneeze : smiley,
          x,
          y + ((size / n) * kFont) / 2
        );
        if (drawControlCircles) {
          context.strokeStyle = "#ababab";
          context.lineWidth = 1;
          context.beginPath();
          context.arc(x, y, (size / (n - 1)) * 0.15, 0, 2 * Math.PI);
          context.stroke();
        }
      });
    }
  };
};

export default createSketch;
