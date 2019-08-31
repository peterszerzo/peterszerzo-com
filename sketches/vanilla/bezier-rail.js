import * as utils from "./utils/index";
import * as bezier from "./utils/bezier";

const n = 6;

const grid = utils.range2(n)(n);

// Main

const createSketch = () => {
  return {
    step: ({ context, size, playhead }) => {
      context.fillStyle = "#17263A";
      context.fillRect(0, 0, size, size);
      const curves = shortTermDebtCycleCurves;

      grid.map(([i, j]) => {
        const t = 0.5 + 0.5 * Math.sin(playhead * 0.001 + i * 0.2 + j * 0.2);
        drawCurves2({
          color: "#EF4052",
          curves,
          transform: ([x, y]) => [
            (i - 0.1 + x * 0.7) * (size / (n - 1)) * 1.1,
            (j - 0.1 + (i % 2 === 0 ? 0.5 : 0) + -y * 0.7) *
              (size / (n - 1)) *
              1.1
          ],
          lineWidth: size * 0.008,
          radius: size * 0.012,
          context,
          t
        });
      });
    }
  };
};

// Drawing utilities

const drawCurve = ({ curve, transform, lineWidth, context, capEnd }) => {
  const [pt1, pt2, pt3, pt4] = curve;

  const [x1, y1] = transform(pt1);
  const [x2, y2] = transform(pt2);
  const [x3, y3] = transform(pt3);
  const [x4, y4] = transform(pt4);

  context.beginPath();
  context.arc(x1, y1, lineWidth / 2, 0, 2 * Math.PI);
  context.fill();

  if (capEnd) {
    context.beginPath();
    context.arc(x4, y4, lineWidth / 2, 0, 2 * Math.PI);
    context.fill();
  }

  context.beginPath();
  context.moveTo(x1, y1);
  context.bezierCurveTo(x2, y2, x3, y3, x4, y4);
  context.stroke();
};

const drawCurves = ({ curves, context, lineWidth, transform }) => {
  context.lineWidth = lineWidth;
  curves.forEach((curve, index) => {
    drawCurve({
      curve,
      transform,
      lineWidth,
      context,
      capEnd: index === curves.length - 1
    });
  });
};

export const drawCurves2 = ({
  color,
  curves,
  transform,
  radius,
  lineWidth,
  context,
  t
}) => {
  context.strokeStyle = color;
  context.fillStyle = color;
  drawCurves({ curves, transform, lineWidth, context });
  const [x, y] = transform(bezier.ptOnCurves(curves, t));
  context.beginPath();
  context.arc(x, y, radius, 0, 2 * Math.PI);
  context.fill();
};

// Drawing geometry

const curves1 = [
  [[0.1, 0.1], [0.3, 0.1], [0.2, 0.5], [0.5, 0.5]],
  [[0.5, 0.5], [0.8, 0.5], [0.6, 0.9], [0.9, 0.9]]
];

export const shortTermDebtCycleCurves = [
  [[0, 0], [0.2, 0], [0.3, 0.16], [0.43, 0.3]],
  [
    [0.43 + 0, 0.3 + 0],
    [0.43 + 0.13, 0.3 + 0.14],
    [0.43 + 0.37, 0.3 + 0.22],
    [0.43 + 0.37, 0.3 + 0.02]
  ],
  [
    [0.8 + 0, 0.32 + 0],
    [0.8 + 0, 0.32 + -0.2],
    [0.8 + 0.05, 0.32 + -0.32],
    [0.8 + 0.2, 0.32 + -0.32]
  ]
];

export default createSketch;
