import * as utils from "./utils/index";

const colorScheme = ["#020202", "#0d324d", "#7f5a83", "#a188a6", "#9da2ab"];

const stepBeetle = deltaTime => beetle => {
  beetle.x += beetle.v * deltaTime;
  beetle.v += (beetle.xc - beetle.x) * beetle.k * deltaTime;
};

const line = ({ x, y, rot, len }) => context => {
  context.save();
  context.translate(x, y);
  context.rotate(rot);
  context.beginPath();
  context.moveTo(-len / 2, -len / 2);
  context.lineTo(len / 2, len / 2);
  context.stroke();
  context.restore();
};

const generateBeetles = () =>
  utils.range(7).map(index => ({
    offset: [
      0.1 + 0.3 * (index % 3) + (Math.random() - 0.5) * 0.15,
      0.1 + 0.3 * Math.floor(index / 3) + (Math.random() - 0.5) * 0.15
    ],
    x: 0,
    v: 0.0001 - Math.random() * 0.0004,
    xc: 0.02 + Math.random() * 0.1,
    size: 0.5,
    k: 1 / 2000000
  }));

const createSketch = () => {
  const lines = utils.range(30).map(k => k - 15);
  const beetles = generateBeetles();
  return {
    step: ({ context, size, deltaTime }) => {
      context.fillStyle = "rgba(255, 255, 255, 1)";
      context.fillRect(0, 0, size, size);
      context.lineCap = "round";
      beetles.forEach(stepBeetle(deltaTime));
      beetles.forEach((beetle, index) => {
        context.lineWidth = size * 0.012 * beetle.size;
        context.strokeStyle = colorScheme[index % colorScheme.length];
        lines.forEach(k => {
          line({
            x:
              (beetle.offset[0] +
                beetle.x * beetle.size +
                k * 0.02 * beetle.size) *
              size,
            y:
              (beetle.offset[1] +
                beetle.x * beetle.size +
                k * 0.02 * beetle.size) *
              size,
            rot: k * 0.33 + beetle.x * 10,
            len: size * 0.2 * beetle.size
          })(context);
        });
      });
    }
  };
};

export default createSketch;
