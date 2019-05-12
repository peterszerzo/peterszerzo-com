const d3Hierarchy = require("d3-hierarchy");
const utils = require("./utils");

const colorScheme = ["#33658a", "#86bbd8", "#2f4858", "#f6ae2d", "#f26419"];

const square = context => ({ x, y, w, colorIndex, minW, maxW, rot }) => {
  context.save();
  context.translate(x, y);
  context.rotate(rot + (Math.PI / 2) * (colorIndex % 4));
  context.fillStyle = colorScheme[colorIndex];
  context.beginPath();
  context.moveTo(-w / 2, -w / 2);
  context.lineTo(-w / 2, +w / 2);
  context.lineTo(+w / 2, +w / 2);
  context.arcTo(+w / 2, -w / 2, -w / 2, -w / 2, w);
  context.fill();
  context.restore();
};

const pack = dim => {
  const outerPad = dim / 12;
  const pack = d3Hierarchy
    .pack()
    .size([dim - outerPad * 2, dim - outerPad * 2])
    .padding(dim / 33);
  const nodes = {
    children: utils.range(150).map(() => ({
      name: "name",
      size: ((Math.random() + 0.1) / 1.2) * dim
    })),
    name: "name"
  };
  const root = d3Hierarchy.hierarchy(nodes);
  root.sum(d => d.size);
  const rootNode = pack(root);
  const resultNodes = rootNode.children.map(child => ({
    x: child.x + outerPad,
    y: child.y + outerPad,
    w: child.r * 3.2,
    colorIndex: Math.floor(Math.random() * colorScheme.length)
  }));
  return {
    nodes: resultNodes,
    minmaxW: utils.minmax(resultNodes.map(n => n.w))
  };
};

const createSketch = dim => {
  const pk = pack(dim);
  let body = {
    angle: Math.PI / 4 - Math.PI / 8,
    velocity: 0
  };
  return {
    step: ({ context, width, height, playhead, deltaTime }) => {
      body.angle += body.velocity * 0.02;
      body.velocity += (Math.PI / 4 - body.angle) * 0.01;

      context.translate(0, 0);
      context.fillStyle = "rgba(255, 255, 255, 1)";
      context.fillRect(0, 0, width, height);
      context.strokeStyle = "rgb(55, 55, 55)";
      context.lineCap = "round";
      context.strokeStyle = "rgb(255, 255, 255)";
      context.lineWidth = "6";

      context.fillStyle = "rgba(255, 255, 255, 1)";

      const spreadFactor = 0.3 * (0 + body.velocity ** 2 * 2.5);

      context.save();

      context.translate(dim / 2, dim / 2);
      context.rotate(body.angle);
      context.translate(-dim / 2, -dim / 2);

      context.shadowBlur = 3;
      context.shadowColor = "rgba(0, 0, 0, 0.4)";

      pk.nodes.map(
        utils.compose(
          sq => ({
            x: sq.x + (sq.x - dim / 2) * spreadFactor,
            y: sq.y + (sq.y - dim / 2) * spreadFactor,
            w: sq.w,
            colorIndex: sq.colorIndex,
            rot: -body.angle,
            minW: pk.minmaxW.min,
            maxW: pk.minmaxW.max
          }),
          square(context)
        )
      );

      context.restore();
    }
  };
};

export default createSketch;
