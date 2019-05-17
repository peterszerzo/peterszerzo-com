const canvasSketch = require("canvas-sketch");
const utils = require("./utils");

const dim = 1024;

const settings = {
  dimensions: [dim, dim],
  animate: true,
  duration: 30,
  fps: 30
};

const circle = ({ x, y, r, gapAt }) => context => {
  context.beginPath();
  context.arc(x, y, r, gapAt - 0.6, gapAt + 0.6, true);
  context.stroke();
};

const a = 100;

const hexGrid = ({ n, m }) =>
  utils
    .range(n)
    .map(i => utils.range(m).map(j => [i, j]))
    .reduce((accumulator, current) => [...accumulator, ...current], [])
    .reduce((accumulator, current) => {
      const [i, j] = current;
      const hexagonCenter = Math.floor(j / 2);
      const hexagonDeviation = (j % 2) - 0.5;
      return {
        ...accumulator,
        [`${i}-${j}`]: {
          checksum: i + 2 * j,
          coordinates: [
            hexagonCenter * 3 * a + hexagonDeviation * a * (i % 2 == 0 ? 1 : 2),
            (a * i * Math.sqrt(3)) / 2
          ]
        }
      };
    }, {});

const hgrid = hexGrid({ n: 18, m: 14 });

const animateAt = 0.08;

const animateFor = animateAt / 4;

const sketch = () => ({ context, width, height, playhead }) => {
  context.fillStyle = "rgba(30, 30, 30, 1)";
  context.fillRect(0, 0, width, height);
  context.strokeStyle = "rgb(55, 55, 55)";
  context.lineCap = "round";
  context.strokeStyle = "rgb(255, 255, 255)";
  context.lineWidth = "6";
  const globalPlayhead = playhead;

  const c = utils.computeAnimateCycle({
    playhead: playhead,
    animateAt: 3 * animateAt,
    animateFor: animateFor + 0.006
  });

  context.translate(dim / 2, dim / 2);
  context.rotate((Math.PI / 12) * (c.cycle + utils.easeInOut(c.ratio)));
  context.translate(-dim / 2, -dim / 2);

  Object.entries(hgrid).forEach(([id, val], index) => {
    const c = utils.computeAnimateCycle({
      playhead: playhead - val.checksum * 0.002,
      animateAt: animateAt,
      animateFor: animateFor
    });
    circle({
      x: -180 + val.coordinates[0],
      y: -180 + val.coordinates[1],
      r: 20,
      gapAt:
        ((val.checksum + c.cycle + utils.easeInOut(c.ratio)) % 6) *
        ((2 * Math.PI) / 3)
    })(context);
  });
};

canvasSketch(sketch, settings);
