const log = x => {
  console.log(x);
  return x;
};

const range = n => [...Array(n).keys()];

const clamp = min => max => val => {
  if (val < min) {
    return min;
  }
  if (val > max) {
    return max;
  }
  return val;
};

const easeInOut = ratio =>
  ratio <= 0.5 ? (ratio * 2) ** 4 / 2 : 1 - ((1 - ratio) * 2) ** 4 / 2;

module.exports = {
  log,
  range,
  clamp,
  easeInOut
};
