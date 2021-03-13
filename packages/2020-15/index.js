const canvasSketch = require("canvas-sketch");
const { lerp } = require("canvas-sketch-util/math");
const random = require("canvas-sketch-util/random");
const palettes = require("nice-color-palettes");

const settings = {
  dimensions: [3600, 3600],
};

random.setSeed(2.3);

export const range = (n) => [...Array(n).keys()];

const res = 160;

const sketch = () => {
  const palette = random.pick(palettes);
  const points = range(res)
    .map((i) =>
      range(res).map((j) => {
        const u = res <= 1 ? 0.5 : i / (res - 1);
        const v = res <= 1 ? 0.5 : j / (res - 1);
        const minRadius = 0.4;
        const maxRadius = 1.2;
        const k = Math.abs(random.noise2D(2.5 * u, 2.5 * v));
        return {
          radius: minRadius + (maxRadius - minRadius) * k,
          open: ((2 * Math.PI) / 16) * (1.8 - k * 1.2),
          color: random.pick(palette),
          rotation: 3.0 * Math.abs(random.noise2D(6 * u, 6 * v)),
          position: [u, v],
        };
      })
    )
    .reduce((accumulator, current) => [...accumulator, ...current], [])
    .filter(() => random.value() > 0.5);

  return ({ context, width, height }) => {
    const margin = width * 0.05;
    context.fillStyle = "#FFF";
    context.fillRect(0, 0, width, height);
    points.forEach((pt) => {
      const [u, v] = pt.position;
      const x = lerp(margin, width - margin, u);
      const y = lerp(margin, height - margin, v);

      const r = (pt.radius * width * 2.3) / res;

      context.save();
      context.translate(x, y);
      context.rotate(pt.rotation);
      context.beginPath();
      context.moveTo(0, 0);
      context.arc(0, 0, r, -pt.open / 2, pt.open / 2, false);
      context.fillStyle = pt.color;
      context.lineWidth = width * 0.01;
      context.fill();
      context.restore();
    });
  };
};

canvasSketch(sketch, settings);
