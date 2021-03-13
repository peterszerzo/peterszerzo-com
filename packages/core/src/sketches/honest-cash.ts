import * as utils from "./utils/index";
import * as bezier from "./utils/bezier";
import chroma from "chroma-js";

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
      capEnd: index === curves.length - 1,
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
  t,
}) => {
  context.strokeStyle = color;
  context.fillStyle = color;
  drawCurves({ curves, transform, lineWidth, context });
  const [x, y] = transform(bezier.ptOnCurves(curves, t));
  context.beginPath();
  context.arc(x, y, radius, 0, 2 * Math.PI);
  context.fill();
};

const n = 16;
export const shortTermDebtCycleCurves = [
  [
    [0, 0],
    [0.2, 0],
    [0.3, 0.16],
    [0.43, 0.3],
  ],
  [
    [0.43 + 0, 0.3 + 0],
    [0.43 + 0.13, 0.3 + 0.14],
    [0.43 + 0.37, 0.3 + 0.22],
    [0.43 + 0.37, 0.3 + 0.02],
  ],
  [
    [0.8 + 0, 0.32 + 0],
    [0.8 + 0, 0.32 + -0.2],
    [0.8 + 0.05, 0.32 + -0.32],
    [0.8 + 0.2, 0.32 + -0.32],
  ],
];

const font = "Source Sans Pro";

const grid = utils
  .range(n + 1)
  .map((i) => i / n)
  .map((i) =>
    utils
      .range(n / 2 + 1)
      .map((j) => j / (n / 2))
      .map((j) => [i, j])
  )
  .reduce((accumulator, current) => [...accumulator, ...current], []);

const drawText = ({ context, size, color, value, no, serial }) => {
  context.fillStyle = color;

  context.textAlign = "start";

  context.font = `${size * 0.075}px '${font}'`;
  context.fillText("€", size * 0.05, size * (0.05 + 0.06));

  context.font = `${size * 0.15}px '${font}'`;
  context.fillText(value, size * 0.05, size * (0.5 - 0.05));

  context.textAlign = "end";
  context.font = `${size * 0.0375}px '${font}'`;
  context.fillText(
    `${no}th // ${serial}`,
    size * (1 - 0.05),
    size * (0.05 + 0.0375)
  );

  context.restore();
};

const bg1Factor = (i: number, j: number, playhead: number) => {
  const timeFactor1 = 0.5 + 0.5 * Math.sin(playhead * 0.001);
  const timeFactor2 = 0.5 + 0.5 * Math.cos(Math.PI / 3 + playhead * 0.0005);
  const d =
    ((i - 0.5 + (timeFactor1 - 0.5) * 0.3) ** 2 +
      (j - 0.5 - (timeFactor2 - 0.5) * 0.25) ** 2) **
    0.5;
  return (
    timeFactor1 * Math.sin(Math.PI / 2 + 2 * Math.PI * d) +
    (1 - timeFactor1) * Math.sin(Math.PI / 2 + 6 * Math.PI * d)
  );
};

const bgBase = ({ context, size, backgroundColor }) => {
  context.shadowBlur = 20;
  context.shadowColor = "rgba(0, 0, 0, 0.2)";
  context.fillStyle = backgroundColor;
  context.fillRect(0, 0, size, size * 0.5);
  context.shadowBlur = 0;
};

const bgHole = ({ context, size, backgroundColor }) => {
  context.fillStyle = chroma(backgroundColor).brighten(1.5).alpha(0.4).hex();
  context.beginPath();
  context.arc(size * (1 - 0.3), size * 0.2, size * 0.06, 0, 2 * Math.PI);
  context.fill();
};

const bg1 = ({
  context,
  size,
  playhead,
  backgroundColor,
  backgroundPatternColor,
}) => {
  bgBase({ context, size, backgroundColor });
  grid.forEach(([i, j], index) => {
    if (i === 0 || j === 0 || i === 1 || j === 1) {
      return;
    }
    const [startAngle, endAngle] = (() => {
      return [0, 2 * Math.PI];
    })();
    context.fillStyle =
      [15 * 8 + 12, 15 * 8 + 13, 16 * 8 + 13, 16 * 8 + 14].indexOf(index) > -1
        ? chroma(backgroundPatternColor).darken(3.5).hex()
        : backgroundPatternColor;
    context.beginPath();
    context.arc(
      i * size,
      j * size * 0.5,
      (size / (4 * n)) * (0.9 + bg1Factor(i, j, playhead) * 0.3),
      startAngle,
      endAngle
    );
    context.fill();
  });
  bgHole({ context, size, backgroundColor });
};

const grid2 = utils.range2(6)(4);

const bg2 = ({
  context,
  size,
  playhead,
  backgroundColor,
  backgroundPatternColor,
}) => {
  bgBase({ context, size, backgroundColor });
  context.fillStyle = backgroundPatternColor;
  grid2.forEach(([i, j]) => {
    const t = 0.5 + 0.5 * Math.sin(playhead * 0.001 + i * 0.2 + j * 0.2);
    drawCurves2({
      color:
        i === 5 && j === 3
          ? chroma(backgroundPatternColor).darken(3.5).hex()
          : backgroundPatternColor,
      curves: shortTermDebtCycleCurves,
      transform: ([x, y]) => [
        (i + (j % 2 === 1 ? 0.5 : 0)) * size * 0.147 +
          x * size * 0.09 +
          size * 0.05,
        j * size * 0.115 + (1 - y) * size * 0.09 + size * (0.05 - 0.04),
      ],
      lineWidth: size * 0.008,
      radius: size * 0.009,
      context,
      t,
    });
  });
  bgHole({ context, size, backgroundColor });
};

const bgs = [bg1, bg2];

const bill = ({ context, size, playhead, type, color, value, no, serial }) => {
  const backgroundColor = chroma(color).hex();
  const backgroundPatternColor = chroma(color).darken(0.25).saturate(0.3).hex();
  const textColor = chroma(color).darken(3.5).hex();
  bgs[type]({
    context,
    size,
    playhead,
    backgroundColor,
    backgroundPatternColor,
  });

  drawText({ context, size, value, no, color: textColor, serial });
};

const colorScheme = ["#AAC0AA", "#BFABCB", "#E2D58B"];

const compositions = [
  [
    { x: 0.4, y: 0.3, z: 0, scale: 0.6 },
    { x: 0.6, y: 0.5, z: 1, scale: 0.6 },
    { x: 0.4, y: 0.7, z: 0, scale: 0.6 },
  ],
  [
    { x: 0.0, y: 0.3, z: 0.0, scale: 1.2 },
    { x: 0.5, y: 0.25, z: 0.0, scale: 0.8 },
    { x: 0.6, y: 0.8, z: 1.0, scale: 0.5 },
  ],
  [
    { scale: 0 },
    { scale: 0 },
    { x: 0.25 + 0.025, y: 0.875 - 0.025, z: 1, scale: 0.5 },
  ],
  [
    { x: 0.5, y: 0.5, z: 1, scale: 0 },
    { x: 0.5, y: 0.5, z: 2, scale: 0.5 },
    { x: 0.5, y: 0.5, z: 1, scale: 2 },
  ],
  [
    { scale: 0 },
    { scale: 0 },
    { x: 0.75 - 0.025, y: 0.875 - 0.025, z: 1, scale: 0.5 },
  ],
  [
    { x: 0.75 - 0.025, y: 0.5, z: 1, scale: 0.5 },
    { x: 0.25 + 0.025, y: 0.125 + 0.025, z: 1, scale: 0.5 },
    { x: 0.25 + 0.025, y: 0.875 - 0.025, z: 1, scale: 0.5 },
  ],
];

const createSketch = () => {
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      context.fillStyle = "#FFF";
      context.fillRect(0, 0, size, size);

      const animIndex = Math.floor(playhead * 0.00075) % 15;

      [
        {
          serial: "B41FGH",
          value: 10,
          no: 1723,
        },
        {
          value: 20,
          serial: "AT231S",
          no: 14721,
        },
        {
          value: 50,
          serial: "AT231S",
          no: 14721,
        },
      ]
        .map((bill, index) => ({
          ...bill,
          ...compositions[animIndex % compositions.length][index],
          // Keep track of index here to have access to it after sorting
          index,
        }))
        .sort((a, b) => a.z - b.z)
        .forEach((info) => {
          if (info.scale === 0) {
            return;
          }
          context.save();
          context.translate(
            size * (-info.scale * 0.5),
            size * (-info.scale * 0.25)
          );
          context.translate(size * info.x, size * info.y);
          bill({
            context,
            size: size * info.scale,
            playhead,
            type: (info.index ** 2 + info.index * animIndex + animIndex) % 2,
            color: colorScheme[info.index],
            serial: info.serial,
            value: info.value,
            no: info.no,
          });
          context.restore();
        });
    },
  };
};

export default createSketch;
