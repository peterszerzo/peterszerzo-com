const canvasSketch = require("canvas-sketch");

const dim = 1000;

const range = n => [...Array(n).keys()];

const settings = {
  dimensions: [dim, dim],
  animate: true,
  duration: 30,
  fps: 30
};

const drawPoli = ({ x, y, r, rot, vertices }) => context => {
  context.save();
  context.translate(x, y);
  context.rotate(rot);
  context.beginPath();
  context.moveTo(r, 0);
  range(vertices + 1).forEach(index => {
    context.lineTo(
      r * Math.cos((index * Math.PI * 2) / vertices),
      r * Math.sin((index * Math.PI * 2) / vertices)
    );
  });
  context.stroke();
  context.restore();
};

const makeSpiral = ({ x, y, radius, vert }) => {
  const k = 1 / Math.cos(Math.PI / vert);
  const kmax = k ** 19;
  return {
    x,
    y,
    vert,
    objs: range(20).map(num => ({
      radius: (radius * k ** num) / kmax,
      rotation: 0
    }))
  };
};

const layoutPad = dim / 12;

const layoutUnit = (dim - 4 * layoutPad) / 3;

let spirals = [
  [0, 0, 4],
  [1, 0, 5],
  [2, 0, 6],
  [0, 1, 7],
  [1, 1, 8],
  [2, 1, 9],
  [0, 2, 10],
  [1, 2, 11],
  [2, 2, 12]
]
  .map(([i, j, vert]) => ({
    x: layoutPad + layoutUnit / 2 + (layoutPad + layoutUnit) * i,
    y: layoutPad + layoutUnit / 2 + (layoutPad + layoutUnit) * j,
    radius: layoutUnit / 2,
    vert: vert
  }))
  .map(makeSpiral);

const stepSpiral = deltaTime => spiral => ({
  ...spiral,
  objs: spiral.objs.map((obj, index) => ({
    ...obj,
    rotation:
      obj.rotation +
      (((deltaTime * 4) / spiral.vert) * 1.5 * (index - 9.5)) / 9.5
  }))
});

const drawSpiral = context => spiral => {
  spiral.objs.forEach((poli, index) => {
    drawPoli({
      x: spiral.x,
      y: spiral.y,
      r: poli.radius,
      rot: poli.rotation,
      vertices: spiral.vert
    })(context);
  });
};

const stepRotations = deltaTime => rotations =>
  rotations.map((rot, index) => rot + (deltaTime * 1.5 * (index - 9.5)) / 9.5);

const sketch = () => ({ context, width, height, deltaTime }) => {
  context.fillStyle = "rgb(255, 255, 255)";
  context.fillRect(0, 0, width, height);
  context.strokeStyle = "rgb(0, 0, 0)";
  context.lineWidth = "3";
  context.lineCap = "round";
  spirals = spirals.map(stepSpiral(deltaTime));
  spirals.forEach(drawSpiral(context));
};

canvasSketch(sketch, settings);
