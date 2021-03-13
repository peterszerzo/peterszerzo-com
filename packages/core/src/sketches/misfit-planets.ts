import { polyfloat } from "./utils/polyfloat";

// Constants

const pi = Math.PI;
const { sin, cos } = Math;
const white = "#FFF";
const black = "#000";
const standardLine = 0.015;

// Entry point

export default () => {
  return {
    step: ({ context, size, deltaTime, playhead }) => {
      context.fillStyle = black;
      context.fillRect(0, 0, size, size);

      const k1Raw = playhead * 0.001 + pi / 4;
      const k1 = sin(k1Raw);
      const k2Raw = playhead * 0.001 - pi / 4;
      const k2 = sin(k2Raw);

      const shared = { context, size, playhead };
      hoopy(shared)([-1.125, -1.125], k1, k1Raw);
      bulgy(shared)([-1.125, 0], k1, k1Raw);
      polly(shared)([0, 0], k2, k2Raw);
      wheely(shared)([1.125, 0], k1, k1Raw);
      belly(shared)([-1.125, 1.125], k2, k2Raw);
      rhomby(shared)([1.125, 1.125], k1, k1Raw);
      flowery(shared)([0, -1.125], k2, k2Raw);
      kippy(shared)([0, 1.125], k1, k1Raw);
      heidy(shared)([1.125, -1.125], k1, k1Raw);
    },
  };
};

// Planets

const polly = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(
    0,
    0,
    size * (0.025 - 0.005 * k),
    size * (0.025 - 0.005 * k),
    0,
    0,
    2 * pi
  );
  context.fill();

  context.strokeStyle = white;
  context.lineWidth = size * standardLine;
  context.lineCap = "round";
  context.lineJoin = "round";

  const pts = polyfloat(5 + 1 * k, (pi / 6) * k);

  const r = size * 0.1;

  context.beginPath();
  pts.forEach(([x, y], index) => {
    if (index === 0) {
      context.moveTo(x * r, y * r);
    }
    context.lineTo(x * r, y * r);
  });
  context.stroke();

  context.restore();
};

const rhomby = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  const y = 0.5 + 0.45 * k;
  const u = size * 0.25;

  context.rotate(pi * 0.25);
  context.fillStyle = white;
  context.beginPath();
  context.moveTo(u * -0.5, u * 0.0 * y);
  context.lineTo(u * 0.0, u * 0.25 * y);
  context.lineTo(u * 0.5, u * 0.0 * y);
  context.lineTo(u * 0.0, u * -0.25 * y);
  context.closePath();
  context.fill();

  const u2 = size * 0.12;
  const y2 = 0.5 - 0.45 * k;

  context.rotate(pi * -0.5);
  context.fillStyle = white;
  context.beginPath();
  context.moveTo(u2 * -0.5, u2 * 0.0 * y2);
  context.lineTo(u2 * 0.0, u2 * 0.25 * y2);
  context.lineTo(u2 * 0.5, u2 * 0.0 * y2);
  context.lineTo(u2 * 0.0, u2 * -0.25 * y2);
  context.closePath();
  context.fill();

  context.restore();
};

const hoopy = ({ context, size, playhead }) => ([gridX, gridY], k, kRaw) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.strokeStyle = white;
  context.lineWidth = size * standardLine;
  context.beginPath();
  context.ellipse(
    0 + size * 0.05 * k,
    0,
    size * 0.025,
    size * 0.08,
    0,
    0,
    2 * pi
  );
  context.stroke();

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(
    0 - size * 0.05 * k,
    0.025 * sin(2 * kRaw) * size,
    size * 0.02,
    size * 0.02,
    0,
    0,
    2 * pi
  );
  context.fill();

  context.restore();
};

const wheely = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(0, 0, size * 0.06, size * 0.06, 0, 0, 2 * pi);
  context.fill();

  context.fillStyle = black;
  context.beginPath();
  context.ellipse(
    size * 0.035 * cos((k * pi) / 3),
    size * 0.035 * sin((k * Math.PI) / 3),
    size * 0.012,
    size * 0.012,
    0,
    0,
    2 * Math.PI
  );
  context.fill();

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(
    size * -0.09 * cos((k * Math.PI) / 6),
    size * -0.09 * sin((k * Math.PI) / 6),
    size * 0.012,
    size * 0.012,
    0,
    0,
    2 * Math.PI
  );
  context.fill();

  context.restore();
};

const belly = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(0, 0, size * 0.0125, size * 0.0125, 0, 0, 2 * Math.PI);
  context.fill();

  context.save();
  const d = Math.PI / 6 + (Math.PI / 8) * k;
  const sliver = Math.PI / 8;
  context.rotate(Math.PI * 0.25);
  context.lineCap = "round";
  context.strokeStyle = white;
  context.lineWidth = size * standardLine;
  context.beginPath();
  context.ellipse(
    0,
    0,
    size * 0.03,
    size * 0.12,
    0,
    d + sliver / 2,
    d - sliver / 2
  );
  context.stroke();
  context.restore();

  context.restore();
};

const flowery = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.lineCap = "round";
  context.fillStyle = white;

  polyfloat(6, (Math.PI / 4) * k).map(([x, y]) => {
    context.beginPath();
    context.ellipse(
      x * size * (0.04 * k),
      y * size * (0.04 * k),
      size * 0.03,
      size * 0.03,
      0,
      0,
      2 * Math.PI
    );
    context.fill();
  });

  context.restore();
};

const heidy = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.lineCap = "round";
  context.fillStyle = white;

  const pts = polyfloat(3, (-Math.PI / 4) * k);

  const r = size * (0.065 + 0.01 * k);

  context.beginPath();
  pts.forEach(([x, y], index) => {
    if (index === 0) {
      context.moveTo(x * r, y * r);
    }
    context.lineTo(x * r, y * r);
  });
  context.fill();

  const r2 = size * (0.03 - 0.01 * k);

  context.fillStyle = black;
  context.beginPath();
  context.ellipse(0, 0, r2, r2, 0, 0, 2 * Math.PI);
  context.fill();

  context.restore();
};

const bulgy = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.lineCap = "round";
  context.strokeStyle = white;
  const u = size * 0.02 * 0.9;
  const e = 1 + 0.75 * (0.5 + 0.5 * k);
  context.lineWidth = u / 0.9;
  context.beginPath();
  context.ellipse(0, 0, u * e * 0.5, u * e * 0.5, 0, 0, 2 * Math.PI);
  context.stroke();

  context.beginPath();
  context.ellipse(0, 0, u * e * 1.5, u * e * 1.5, 0, 0, 2 * Math.PI);
  context.stroke();

  context.beginPath();
  context.ellipse(0, 0, u * e * 2.5, u * e * 2.5, 0, 0, 2 * Math.PI);
  context.stroke();

  context.restore();
};

const kippy = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.lineCap = "round";
  context.strokeStyle = white;
  context.fillStyle = white;
  context.lineWidth = size * standardLine;

  context.save();

  context.rotate((Math.PI / 6) * k);

  context.beginPath();
  context.moveTo(-size * 0.075, 0);
  context.lineTo(+size * 0.075, 0);
  context.stroke();

  context.beginPath();
  context.ellipse(
    -size * 0.075 * k,
    -size * 0.04,
    size * 0.02,
    size * 0.02,
    0,
    0,
    2 * Math.PI
  );
  context.fill();

  context.beginPath();
  context.ellipse(
    size * 0.075 * k,
    size * 0.04,
    size * 0.02,
    size * 0.02,
    0,
    0,
    2 * Math.PI
  );
  context.fill();

  context.restore();

  context.restore();
};
