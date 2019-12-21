import * as d3Hierarchy from "d3-hierarchy";
import * as utils from "./utils/index";

const colorScheme = ["#33658a", "#86bbd8", "#2f4858", "#f6ae2d", "#f26419"];

const square = context => ({ x, y, w, size, colorIndex, minW, maxW, rot }) => {
  context.save();
  context.translate(x * size, y * size);
  context.rotate(rot + (Math.PI / 2) * (colorIndex % 4));
  context.fillStyle = colorScheme[colorIndex];
  context.beginPath();
  context.moveTo((-w / 2) * size, (-w / 2) * size);
  context.lineTo((-w / 2) * size, (+w / 2) * size);
  context.lineTo((+w / 2) * size, (+w / 2) * size);
  context.arcTo(
    (+w / 2) * size,
    (-w / 2) * size,
    (-w / 2) * size,
    (-w / 2) * size,
    w * size
  );
  context.fill();
  context.restore();
};

const pack = () => {
  const outerPad = 1 / 12;
  const pack = d3Hierarchy
    .pack()
    .size([1 - outerPad * 2, 1 - outerPad * 2])
    .padding(1 / 33);
  const nodes = {
    children: utils.range(150).map(() => ({
      name: "name",
      size: (Math.random() + 0.1) / 1.2
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

const createSketch = () => {
  const pk = pack();
  let body = {
    angle: Math.PI / 4 - Math.PI / 8,
    velocity: 0
  };
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      body.angle += body.velocity * 0.02;
      body.velocity += (Math.PI / 4 - body.angle) * 0.01;

      context.translate(0, 0);
      context.fillStyle = "rgba(255, 255, 255, 1)";
      context.fillRect(0, 0, size, size);
      context.strokeStyle = "rgb(55, 55, 55)";
      context.lineCap = "round";
      context.strokeStyle = "rgb(255, 255, 255)";
      context.lineWidth = "6";

      context.fillStyle = "rgba(255, 255, 255, 1)";

      const spreadFactor = 0.3 * (0 + body.velocity ** 2 * 2.5);

      context.save();

      context.translate(size / 2, size / 2);
      context.rotate(body.angle);
      context.translate(-size / 2, -size / 2);

      context.shadowBlur = 3;
      context.shadowColor = "rgba(0, 0, 0, 0.4)";

      pk.nodes.map(
        utils.compose(
          sq => ({
            x: sq.x + (sq.x - 1 / 2) * spreadFactor,
            y: sq.y + (sq.y - 1 / 2) * spreadFactor,
            w: sq.w,
            size,
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
