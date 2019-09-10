import * as utils from "./utils/index";
import { shortTermDebtCycleCurves, drawCurves2 } from "./bezier-rail";
import chroma from "chroma-js";

const n = 16;

const font = "Source Sans Pro";

const grid = utils
  .range(n + 1)
  .map(i => i / n)
  .map(i =>
    utils
      .range(n / 2 + 1)
      .map(j => j / (n / 2))
      .map(j => [i, j])
  )
  .reduce((accumulator, current) => [...accumulator, ...current], []);

const drawText = ({ context, size, color, value, index, serial }) => {
  context.fillStyle = color;

  context.textAlign = "start";

  context.font = `${size * 0.075}px '${font}'`;
  context.fillText("€", size * 0.05, size * (0.05 + 0.06));

  context.font = `${size * 0.15}px '${font}'`;
  context.fillText(value, size * 0.05, size * (0.5 - 0.05));

  context.textAlign = "end";
  context.font = `${size * 0.0375}px '${font}'`;
  context.fillText(
    `${index}th ${serial}`,
    size * (1 - 0.05),
    size * (0.05 + 0.0375)
  );

  context.restore();
};

const bg1Factor = (i, j, playhead) => {
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

const bg1 = ({
  context,
  size,
  playhead,
  backgroundColor,
  backgroundPatternColor
}) => {
  bgBase({ context, size, backgroundColor });
  context.fillStyle = backgroundPatternColor;
  grid.forEach(([i, j]) => {
    if (i === 0 || j === 0 || i === 1 || j === 1) {
      return;
    }
    const [startAngle, endAngle] = (() => {
      return [0, 2 * Math.PI];
    })();
    context.beginPath();
    context.arc(
      i * size,
      j * size * 0.5,
      size / (4 * n) * (0.9 + bg1Factor(i, j, playhead) * 0.3),
      startAngle,
      endAngle
    );
    context.fill();
  });
};

const grid2 = utils.range2(6)(4);

const bg2 = ({
  context,
  size,
  playhead,
  backgroundColor,
  backgroundPatternColor
}) => {
  bgBase({ context, size, backgroundColor });
  context.fillStyle = backgroundPatternColor;
  grid2.forEach(([i, j]) => {
    const t = 0.5 + 0.5 * Math.sin(playhead * 0.001 + i * 0.2 + j * 0.2);
    drawCurves2({
      color:
        i === 5 && j === 3
          ? chroma(backgroundPatternColor)
              .darken(3.5)
              .hex()
          : backgroundPatternColor,
      curves: shortTermDebtCycleCurves,
      transform: ([x, y]) => [
        (i + (j % 2 === 1 ? 0.5 : 0)) * size * 0.147 +
          x * size * 0.09 +
          size * 0.05,
        j * size * 0.115 + (1 - y) * size * 0.09 + size * (0.05 - 0.04)
      ],
      lineWidth: size * 0.008,
      radius: size * 0.009,
      context,
      t
    });
  });
};

const bill = ({
  context,
  size,
  playhead,
  type,
  color,
  value,
  index,
  serial
}) => {
  const backgroundColor = chroma(color).hex();
  const backgroundPatternColor = chroma(color)
    .darken(0.25)
    .saturate(0.3)
    .hex();
  const textColor = chroma(color)
    .darken(3.5)
    .hex();
  (type === "1" ? bg1 : bg2)({
    context,
    size,
    playhead,
    color,
    backgroundColor,
    backgroundPatternColor
  });

  drawText({ context, size, value, index, color: textColor, serial });
};

const createSketch = () => {
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      context.fillStyle = "#FFF";
      context.fillRect(0, 0, size, size);

      [
        {
          type: "2",
          x: 0.1,
          y: 0.15,
          sizeFactor: 0.8,
          color: "#D2DFF4",
          serial: "B41FGH",
          value: 10,
          index: 1723
        },
        {
          type: "2",
          x: 0.1,
          y: 0.55,
          sizeFactor: 0.8,
          color: "#FBC6A8",
          value: 20,
          serial: "AT231S",
          index: 14721
        },
        {
          type: "2",
          x: 0.3,
          y: 0.35,
          sizeFactor: 0.8,
          color: "#BFABCB",
          value: 50,
          serial: "AT231S",
          index: 14721
        }
      ].forEach(info => {
        context.save();
        context.translate(size * info.x, size * info.y);
        // context.rotate(Math.PI / 6);
        bill({
          context,
          size: size * 0.6,
          playhead,
          type: info.type,
          color: info.color,
          serial: info.serial,
          value: info.value,
          index: info.index
        });
        context.restore();
      });
    }
  };
};

export default createSketch;
