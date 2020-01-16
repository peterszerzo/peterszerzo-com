const range = n => [...Array(n).keys()];

const white = "#FFF";
const black = "#000";

const rhomby = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  const y = 0.5 + 0.45 * k;
  const u = size * 0.25;

  context.rotate(Math.PI * 0.25);
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

  context.rotate(Math.PI * -0.5);
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

const wheely = ({ context, size, playhead }) => ([gridX, gridY], k) => {
  context.save();
  context.translate(
    size * 0.5 + gridX * size * 0.25,
    size * 0.5 + gridY * size * 0.25
  );

  context.fillStyle = white;
  context.beginPath();
  context.ellipse(0, 0, size * 0.06, size * 0.06, 0, 0, 2 * Math.PI);
  context.fill();

  context.fillStyle = black;
  context.beginPath();
  context.ellipse(
    size * 0.035 * Math.cos(k * Math.PI / 3),
    size * 0.035 * Math.sin(k * Math.PI / 3),
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
    size * -0.09 * Math.cos(k * Math.PI / 6),
    size * -0.09 * Math.sin(k * Math.PI / 6),
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

  const d = Math.PI / 6 + Math.PI / 8 * k;
  const sliver = Math.PI / 8;
  context.rotate(Math.PI * 0.25);
  context.lineCap = "round";
  context.strokeStyle = white;
  context.lineWidth = size * 0.015;
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
  const e = 1 + 0.5 * (0.5 + 0.5 * k);
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

const createSketch = () => {
  return {
    step: ({ context, size, deltaTime, playhead }) => {
      context.fillStyle = black;
      context.fillRect(0, 0, size, size);
      context.strokeStyle = white;
      context.lineWidth = size / 300;
      const shared = { context, size, playhead };
      belly(shared)([-1, 0], Math.sin(playhead * 0.001 + Math.PI / 4));
      rhomby(shared)([0, 0], Math.sin(playhead * 0.001));
      wheely(shared)([1, 0], Math.sin(playhead * 0.001 + Math.PI / 4));
      bulgy(shared)([0, -1], Math.sin(playhead * 0.001 + Math.PI / 4));
    }
  };
};

export default createSketch;
