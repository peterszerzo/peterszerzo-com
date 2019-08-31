import * as utils from "./utils/index";
import { shortTermDebtCycleCurves, drawCurves2 } from "./bezier-rail";

const n = 16;

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

const factor = (i, j, playhead) => {
  return (
    Math.sin(i * j * 8 + playhead / 1000) *
    Math.cos(j * j * 9 + playhead / 2000)
  );
};

const drawText = context => size => {
  context.save();

  context.translate(0, 0);
  context.fillStyle = "#000";

  context.textAlign = "start";

  context.font = `${size * 0.1}px 'Fira Code'`;
  context.fillText("€", size * 0.05, size * (0.05 + 0.1));

  context.font = `${size * 0.2}px 'Fira Code'`;
  context.fillText("50", size * 0.05, size * (0.5 - 0.05));

  context.textAlign = "end";
  context.font = `${size * 0.0375}px 'Fira Code'`;
  context.fillText("11435th AT21X4", size * (1 - 0.05), size * (0.05 + 0.0375));

  context.restore();
};

const draw1 = ({ context, size, playhead }) => {
  context.fillStyle = "#D2DFF4";
  context.fillRect(0, 0, size, size * 0.5);
  context.fillStyle = "#BCCFEE";
  grid.forEach(([i, j]) => {
    context.beginPath();
    context.arc(
      i * size,
      j * size * 0.5,
      size / (4 * n) + factor(i, j, playhead) * size / (10 * n),
      0,
      2 * Math.PI
    );
    context.fill();
  });
};

const grid2 = utils.range2(6)(4);

const draw2 = ({ context, size, playhead }) => {
  grid2.forEach(([i, j]) => {
    const t = 0.5 + 0.5 * Math.sin(playhead * 0.001 + i * 0.2 + j * 0.2);
    drawCurves2({
      color: "#EF4052",
      curves: shortTermDebtCycleCurves,
      transform: ([x, y]) => [
        (i + (j % 2 === 0 ? 0.5 : 0)) * size * 0.15 +
          x * size * 0.1 +
          size * 0.035,
        j * size * 0.11 + (1 - y) * size * 0.1 + size * (0.5 + 0.05 - 0.045)
      ],
      lineWidth: size * 0.008,
      radius: size * 0.009,
      context,
      t
    });
  });
};

const createSketch = () => {
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      draw1({ context, size, playhead, deltaTime });

      // Coverup
      context.fillStyle = "#FFF";
      context.fillRect(0, size * 0.5, size, size);
      context.fillStyle = "#0F0";

      draw2({ context, size, playhead, deltaTime });

      drawText(context)(size);
    }
  };
};

export default createSketch;
