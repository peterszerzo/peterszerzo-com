export const log = x => {
  console.log(x);
  return x;
};

export const compose = (...fns) => x => {
  if (fns.length === 0) {
    return x;
  }
  const [head, ...tail] = fns;
  return compose(...tail)(head(x));
};

export const range = n => [...Array(n).keys()];

export const unitRange = n => [...Array(n).keys()].map(val => val / (n - 1));

export const range2 = n => m =>
  range(n)
    .map(i => range(m).map(j => [i, j]))
    .reduce((accumulator, current) => [...accumulator, ...current], []);

export const minmax = lst =>
  lst.reduce(
    (accumulator, current) => ({
      min:
        current < accumulator.min || accumulator.min === null
          ? current
          : accumulator.min,
      max:
        current > accumulator.max || accumulator.max === null
          ? current
          : accumulator.max
    }),
    { min: null, max: null }
  );

export const clamp = min => max => val => {
  if (val < min) {
    return min;
  }
  if (val > max) {
    return max;
  }
  return val;
};

export const easeInOut = ratio =>
  ratio <= 0.5 ? (ratio * 2) ** 4 / 2 : 1 - ((1 - ratio) * 2) ** 4 / 2;

export const computeAnimateCycle = ({ playhead, animateAt, animateFor }) => {
  const cycle = Math.floor(playhead / animateAt);
  const ratio = clamp(0)(1)((playhead - cycle * animateAt) / animateFor);
  return {
    cycle,
    ratio
  };
};

export const drawFps = deltaTime => context => {
  context.save();
  context.fillStyle = "#000000";
  context.font = "14px Arial";
  context.fillText(Math.floor(1000 / deltaTime), 20, 40);
  context.restore();
};
