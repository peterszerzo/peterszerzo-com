const range = n => [...Array(n).keys()];

const drawPoli = ({ size, x, y, r, rot, vertices }) => context => {
  context.save();
  context.translate(x * size, y * size);
  context.rotate(rot);
  context.beginPath();
  context.moveTo(r * size, 0);
  range(vertices + 1).forEach(index => {
    context.lineTo(
      r * size * Math.cos(index * Math.PI * 2 / vertices),
      r * size * Math.sin(index * Math.PI * 2 / vertices)
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
      radius: radius * k ** num / kmax,
      rotation: 0
    }))
  };
};

const makeSpirals = () => {
  const layoutPad = 1 / 12;
  const layoutUnit = (1 - 4 * layoutPad) / 3;

  return [
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
};

const stepSpiral = deltaTime => spiral => ({
  ...spiral,
  objs: spiral.objs.map((obj, index) => ({
    ...obj,
    rotation:
      obj.rotation + deltaTime * 4 / spiral.vert * 1.5 * (index - 9.5) / 9.5
  }))
});

const drawSpiral = context => size => spiral => {
  spiral.objs.forEach((poli, index) => {
    drawPoli({
      size,
      x: spiral.x,
      y: spiral.y,
      r: poli.radius,
      rot: poli.rotation,

      vertices: spiral.vert
    })(context);
  });
};

const stepRotations = deltaTime => rotations =>
  rotations.map((rot, index) => rot + deltaTime * 1.5 * (index - 9.5) / 9.5);

const createSketch = () => {
  let spirals = makeSpirals();
  return {
    step: ({ context, size, deltaTime }) => {
      context.fillStyle = "#FFF";
      context.fillRect(0, 0, size, size);
      context.strokeStyle = "#000";
      context.lineWidth = size / 300;
      context.lineCap = "round";
      spirals = spirals.map(stepSpiral(deltaTime / 1000));
      spirals.forEach(drawSpiral(context)(size));
    }
  };
};

export default createSketch;
