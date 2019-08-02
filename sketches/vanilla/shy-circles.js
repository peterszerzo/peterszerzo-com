const utils = require("./utils");

const circle = ({ x, y, r, gapAt }) => context => {
  context.beginPath();
  context.arc(x, y, r, gapAt - Math.PI / 3, gapAt + Math.PI / 3, true);
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
      const hexagonDeviation = j % 2 - 0.5;
      return {
        ...accumulator,
        [`${i}-${j}`]: {
          checksum: i * i + 2 * j - 3 * i * j,
          coordinates: [
            hexagonCenter * 3 * a + hexagonDeviation * a * (i % 2 == 0 ? 1 : 2),
            a * i * Math.sqrt(3) / 2
          ]
        }
      };
    }, {});

const animateAt = 3000;

const animateFor = animateAt * 0.75;

const fineFactor = 1.1;

const createSketch = () => {
  let hgrid = hexGrid({
    n: Math.floor(15 * fineFactor),
    m: Math.floor(15 * fineFactor)
  });
  return {
    step: ({ context, size, playhead, deltaTime }) => {
      context.fillStyle = "#C17278";
      context.fillRect(0, 0, size, size);
      context.lineCap = "round";
      context.strokeStyle = "#D7A5A9";
      context.lineWidth = size * 0.015 / fineFactor;
      const globalPlayhead = playhead;

      Object.entries(hgrid).forEach(([id, val], index) => {
        const c = utils.computeAnimateCycle({
          playhead: playhead,
          animateAt: animateAt,
          animateFor: animateFor
        });
        circle({
          x: size * -0.02 + val.coordinates[0] * size / 1000 / fineFactor,
          y: size * -0.05 + val.coordinates[1] * size / 1000 / fineFactor,
          r: size * 0.05 / fineFactor,
          gapAt:
            ((val.checksum + c.cycle + utils.easeInOut(c.ratio)) % 6) *
            (2 * Math.PI / 3)
        })(context);
      });
    }
  };
};

export default createSketch;
