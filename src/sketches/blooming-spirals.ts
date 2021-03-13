import { range, unitRange } from "./utils";

const curvature = (t: number) => t ** 2 + 0.2;

const getOpacity = (k: number) => {
  const limit = 0.4;
  if (k < limit) {
    return k / limit;
  }
  if (k < 1 - limit) {
    return 1;
  }
  return (1 - k) / limit;
};

const spiral = ({ context, rotation, playhead, tMax, steps, size }: any) => {
  const offset = 0.03 * Math.cos(playhead * 0.001);
  context.save();
  context.translate(0.5 * size, 0.5 * size);
  context.rotate(rotation);
  let prev = {
    x: 0,
    y: 0,
  };
  let current: { x: number; y: number };
  const dt = tMax / steps;
  const w = size * 0.011;
  unitRange(steps).forEach((iUnitRaw) => {
    const iUnit = iUnitRaw + offset;
    const opacity = getOpacity(iUnit);
    context.fillStyle = `rgba(167, 29, 49, ${opacity})`;
    const i = iUnit * (steps - 1);
    const t = i * dt;
    const dx = Math.cos(curvature(t)) * dt * 0.35;
    const dy = Math.sin(curvature(t)) * dt * 0.35;
    current = {
      x: prev.x + dx,
      y: prev.y + dy,
    };
    context.save();
    context.translate(current.x * size, current.y * size);
    context.rotate(curvature(t + dt / 2));
    context.beginPath();
    context.rect(-w / 2, -w / 2, w, w);
    context.fill();
    context.restore();
    prev = current;
  });

  context.restore();
};

const createSketch = () => {
  return {
    step: ({ context, size, playhead }) => {
      context.fillStyle = "#F1F0CC";
      context.fillRect(0, 0, size, size);
      context.lineCap = "round";
      context.lineWidth = size * 0.015;
      const n = 12;
      range(n).forEach((i) => {
        spiral({
          context,
          playhead,
          tMax: 2.5 + 0.75 * Math.sin(playhead * 0.001 + (i * Math.PI) / n),
          steps: 85,
          rotation: (i * 2 * Math.PI) / n,
          size,
        });
      });
    },
  };
};

export default createSketch;
