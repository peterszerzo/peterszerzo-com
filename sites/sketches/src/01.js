const canvasSketch = require("canvas-sketch");
const utils = require("./utils");

const dim = 1024;

const settings = {
  dimensions: [dim, dim],
  animate: true,
  duration: 30
};

const particle = {
  position: 100,
  velocity: 0
};

const spring = {
  center: dim / 2,
  stiffness: 0.0001
};

const stepParticle = () => {
  particle.position += particle.velocity;
  particle.velocity += (spring.center - particle.position) * spring.stiffness;
};

const line = ({ x, y, rot, len }) => context => {
  context.save();
  context.translate(x, y);
  context.rotate(rot);
  context.beginPath();
  context.moveTo(-len / 2, -len / 2);
  context.lineTo(len / 2, len / 2);
  context.stroke();
  context.restore();
};

const sketch = () => ({ context, width, height, playhead }) => {
  context.fillStyle = "rgba(30, 30, 30, 1)";
  context.fillRect(0, 0, width, height);
  context.strokeStyle = "rgb(255, 255, 255)";
  context.lineWidth = "8";
  context.lineCap = "round";
  stepParticle();
  const position = particle.position;
  utils
    .range(45)
    .map(k => k - 22.5)
    .forEach(k => {
      line({
        x: position + k * 20,
        y: position + k * 20,
        rot: k / 3 + position / 100,
        len: 200
      })(context);
    });
};

canvasSketch(sketch, settings);
