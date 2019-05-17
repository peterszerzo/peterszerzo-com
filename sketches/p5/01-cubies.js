import p5 from "p5";
import * as utils from "./utils";

const grid = 12;

// coolors-to-array macro: 0$F-r,lysiw"li#jk0
const colorSchemes = [
  ["#a0ddff", "#758ecd", "#c1cefe", "#7189ff", "#624cab"],
  ["#33658a", "#86bbd8", "#2f4858", "#f6ae2d", "#f26419"],
  ["#d4e4bc", "#96acb7", "#36558f", "#40376e", "#48233c"],
  ["#333333", "#666a86", "#95b8d1", "#e8ddb5", "#edafb8"],
  ["#a1e8af", "#94c595", "#747c92", "#372772", "#3a2449"],
  ["#fcaa67", "#b0413e", "#ffffc7", "#548687", "#473335"]
];

const colorScheme = colorSchemes[1];

const sketch = size => s => {
  let positions;

  s.setup = () => {
    s.createCanvas(size, size, "webgl");
    // s.ortho(-size / 2, size / 2, size / 2, -size / 2, 0, 500);
    s.noStroke();
    positions = utils
      .range(grid)
      .map(x => utils.range(grid).map(y => [x, y]))
      .reduce((current, accumulator) => [...current, ...accumulator], []);
  };

  const light = b => (x, y, z) => s => {
    s.directionalLight(b, b, b, x, y, z);
  };

  const drawCubes = s => {
    const millis = s.millis();
    const speedFactor = 1.5;
    const c = utils.computeAnimateCycle({
      playhead: millis,
      animateAt: 2000 * speedFactor,
      animateFor: 1000 * speedFactor
    });
    s.rotate(millis / 16000 / speedFactor, [0, 0, 1]);
    positions.forEach(([x, y], index) => {
      const colorIndex1 = Math.floor(x * 23 + y * 7) % 5;
      const colorIndex2 = Math.floor(x * 19 + y * 13) % 5;
      const color1 = s.color(colorScheme[colorIndex1]);
      const color2 = s.color(colorScheme[colorIndex2]);
      const color = s.lerpColor(
        color1,
        color2,
        Math.abs((c.cycle % 2) - c.ratio)
      );
      s.fill(color);
      s.push();
      s.translate((x - 0.5) * size * 1.5, (y - 0.5) * size * 1.5);
      s.rotate(
        ((millis / 1000 / speedFactor) * Math.PI) / 3 + (x + y) * Math.PI * 0.5,
        [1, -1, 0]
      );
      s.box(size / grid / 1.6);
      s.pop();
    });
  };

  s.draw = () => {
    light(160)(-0.4, -0.4, -1)(s);
    light(160)(0.4, 0.4, -1)(s);
    s.background(255);
    drawCubes(s);
  };
};

export default sketch;
