import * as utils from "./utils";

import chroma from "chroma-js";

const drawQuadratic = context => ([[x1, y1], [x2, y2], [x3, y3]]) => {
  context.beginPath();
  context.moveTo(x1, y1);
  context.quadraticCurveTo(x2, y2, x3, y3);
  context.stroke();
};

const n = 30;

const ptOnQuadratic = ([[x1, y1], [x2, y2], [x3, y3]]) => t => [
  (1 - t) * (1 - t) * x1 + 2 * (1 - t) * t * x2 + t * t * x3,
  (1 - t) * (1 - t) * y1 + 2 * (1 - t) * t * y2 + t * t * y3
];

const rotate = angle => ([x, y]) => {
  const sinAngle = Math.sin(angle);
  const cosAngle = Math.cos(angle);
  return [x * cosAngle - y * sinAngle, x * sinAngle + y * cosAngle];
};

const normalize = ([x, y]) => {
  const d = Math.sqrt(x * x + y * y);
  return [x / d, y / d];
};

const drawLeaf = context => ({
  dim,
  quadratic,
  baseArmLength,
  divideInto,
  harmonics
}) => {
  const rg = utils.range(divideInto).map(i => i / (divideInto - 1));
  const pts = rg.map(ptOnQuadratic(quadratic));
  const normals = rg.map(normalOnQuadratic(quadratic));
  rg.forEach((t, i) => {
    const [x, y] = pts[i];
    const [nx1, ny1] = rotate(-Math.PI * 0.25)(normals[i]);
    const [nx2, ny2] = rotate(Math.PI * 1.25)(normals[i]);

    const armLength =
      harmonics.reduce(
        (accumulator, current, index) =>
          accumulator + current * Math.sin(t * Math.PI * (index + 1)),
        0
      ) * baseArmLength;

    const colorFactor = (x + y) / dim / 2;

    context.strokeStyle = chroma.mix("#131B2B", "#D257E0", colorFactor, "lch");

    context.beginPath();
    context.moveTo(x + 0.3 * nx1 * armLength, y + 0.3 * ny1 * armLength);
    context.lineTo(x + nx1 * armLength, y + ny1 * armLength);
    context.stroke();

    context.beginPath();
    context.moveTo(x + 0.2 * nx2 * armLength, y + 0.2 * ny2 * armLength);
    context.lineTo(x + nx2 * armLength, y + ny2 * armLength);
    context.stroke();
  });

  context.strokeStyle = "#131B2B";
  drawQuadratic(context)(quadratic);
};

const normalOnQuadratic = ([[x1, y1], [x2, y2], [x3, y3]]) => t =>
  normalize([
    -(-2 * (1 - t) * y1 + 2 * (1 - 2 * t) * y2 + 2 * t * y3),
    -2 * (1 - t) * x1 + 2 * (1 - 2 * t) * x2 + 2 * t * x3
  ]);

const createSketch = dim => {
  return {
    step: ({ context, width, height, playhead }) => {
      context.fillStyle = "rgb(255, 255, 255)";
      context.fillRect(0, 0, width, height);
      context.strokeStyle = "rgb(0, 0, 0)";
      context.lineWidth = dim / 140;
      context.lineCap = "round";

      const factor1 = Math.sin(playhead / 800);
      const factor2 = Math.sin(playhead / 800 + Math.PI / 12);
      const factor3 = Math.sin(playhead / 800 + 2 * Math.PI / 12);

      let factor;

      // Leaf 1

      factor = factor1;

      drawLeaf(context)({
        dim,
        quadratic: [
          [
            dim * (0.3 + 0.02 * factor + 0.2),
            dim * (0.3 - 0.02 * factor - 0.2)
          ],
          [
            dim * (0.5 - 0.04 * factor + 0.2),
            dim * (0.5 + 0.04 * factor - 0.2)
          ],
          [dim * (0.7 + 0.02 * factor + 0.2), dim * (0.7 - 0.02 * factor - 0.2)]
        ],
        baseArmLength: width * 0.1,
        harmonics: [1, -0.05, -0.15, -0.05, -0.05, -0.05],
        divideInto: 24,
        factor
      });

      // Leaf 2

      factor = factor2;

      drawLeaf(context)({
        dim,
        quadratic: [
          [dim * (0.25 + 0.01 * factor), dim * (0.25 - 0.01 * factor)],
          [dim * (0.5 - 0.03 * factor), dim * (0.5 + 0.03 * factor)],
          [dim * (0.75 + 0.02 * factor), dim * (0.75 - 0.02 * factor)]
        ],
        baseArmLength: width * 0.2,
        harmonics: [0.7, 0.08, 0.1, 0.01, 0, -0.05],
        divideInto: 30,
        factor
      });

      // Leaf 3

      factor = factor3;

      drawLeaf(context)({
        dim,
        quadratic: [
          [
            dim * (0.35 + 0.02 * factor - 0.2),
            dim * (0.35 - 0.02 * factor + 0.2)
          ],
          [
            dim * (0.5 - 0.04 * factor - 0.2),
            dim * (0.5 + 0.04 * factor + 0.2)
          ],
          [
            dim * (0.65 + 0.02 * factor - 0.2),
            dim * (0.65 - 0.02 * factor + 0.2)
          ]
        ],
        baseArmLength: width * 0.08,
        harmonics: [1.5, 0.3, 0.1],
        divideInto: 18,
        factor
      });
    }
  };
};

export default createSketch;
