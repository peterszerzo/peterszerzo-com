export const computeAnimateCycle = ({ playhead, animateAt, animateFor }) => {
  const cycle = Math.floor(playhead / animateAt);
  const ratio = clamp(0)(1)((playhead - cycle * animateAt) / animateFor);
  return {
    cycle,
    ratio
  };
};

export const clamp = min => max => val => {
  if (val < min) {
    return min;
  }
  if (val > max) {
    return max;
  }
  return val;
};

export const range = n => [...Array(n).keys()].map(key => key / (n - 1));
