import * as utils from "./utils";

const getRadius = pos => 1 - 0.8 * pos;

const getAngle = pos => pos * Math.PI * 5;

const generatePositions = () => {
  let prev = 0;
  let current = 0.024;
  const positions = [prev, current];
  while (current < 1) {
    // Generate next positions so distances are approximately the same
    const next =
      current + ((current - prev) * getRadius(prev)) / getRadius(current);
    prev = current;
    current = next;
    if (next < 1) {
      positions.push(next);
    }
  }
  return positions;
};

// coolors-to-array macro: 0$F-r,lysiw"li#jk0
const colorSchemes = [
  ["#a0ddff", "#758ecd", "#c1cefe", "#7189ff", "#624cab"],
  ["#33658a", "#86bbd8", "#2f4858", "#f6ae2d", "#f26419"],
  ["#d4e4bc", "#96acb7", "#36558f", "#40376e", "#48233c"],
  ["#333333", "#666a86", "#95b8d1", "#e8ddb5", "#edafb8"],
  ["#a1e8af", "#94c595", "#747c92", "#372772", "#3a2449"],
  ["#fcaa67", "#b0413e", "#ffffc7", "#548687", "#473335"]
];

const getFact = limit => pos => {
  if (pos < limit) {
    return ((limit - pos) / limit) ** 2;
  }
  if (pos > 1 - limit) {
    return ((pos - (1 - limit)) / limit) ** 2;
  }
  return 0;
};

const colorScheme = colorSchemes[1];

const sketch = (size, p5) => s => {
  let positions = [];

  const scale = 150;

  s.setup = () => {
    s.createCanvas(size, size, "webgl");
    s.camera(0, 0.72 * scale, 0.72 * scale, 0, 0, 0, 0, 1, 0);
    s.noStroke();
    positions = generatePositions();
  };

  const light = b => (x, y, z) => s => {
    s.directionalLight(b, b, b, x, y, z);
  };

  const drawCubes = s => {
    positions.forEach((pos, index) => {
      const angle = getAngle(pos);
      const fact1 = getFact(0.06)(pos);
      const fact2 = getFact(0.04)(pos);
      const [translateZ, rotateY, alpha] = [
        fact1 * scale * 0.05,
        fact1 * Math.PI * 0.75,
        1 - fact2
      ];
      const color = s.color(colorScheme[index % 5]);
      color.setAlpha(alpha * 255);
      s.fill(color);
      s.push();
      s.translate(
        0.4 * Math.sin(angle) * scale * getRadius(pos),
        0.4 * Math.cos(angle) * scale * getRadius(pos)
      );
      s.translate(0, 0, translateZ);
      s.rotateZ(-angle);
      s.rotateX(0.4);
      s.rotateY(rotateY);
      s.box((scale / positions.length) * 1.1);
      s.pop();
    });
  };

  s.draw = () => {
    const frameRate = s.frameRate();
    if (frameRate > 5) {
      const delta = 1000 / frameRate;
      positions = positions.map(pos => {
        let newPos = pos + (delta * 0.00003) / getRadius(pos);
        if (newPos > 1) {
          newPos = 1 - newPos;
        }
        return newPos;
      });
    }
    light(160)(-0.4, -0.4, -1)(s);
    light(160)(0.4, 0.4, -1)(s);
    s.background(255);
    drawCubes(s);
  };
};

export default sketch;
