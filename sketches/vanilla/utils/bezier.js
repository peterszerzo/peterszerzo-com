const normalize = ([x, y]) => {
  const d = Math.sqrt(x * x + y * y);
  return [x / d, y / d];
};

export const ptOnCurve = ([[x1, y1], [x2, y2], [x3, y3], [x4, y4]], t) => [
  (1 - t) ** 3 * x1 +
    3 * (1 - t) ** 2 * t * x2 +
    3 * (1 - t) * t ** 2 * x3 +
    t ** 3 * x4,
  (1 - t) ** 3 * y1 +
    3 * (1 - t) ** 2 * t * y2 +
    3 * (1 - t) * t ** 2 * y3 +
    t ** 3 * y4
];

export const ptOnCurves = (curves, t) => {
  const th = t * curves.length;
  const curveIndex = th === curves.length ? curves.length - 1 : Math.floor(th);
  const curveT = th - curveIndex;
  return ptOnCurve(curves[curveIndex], curveT);
};

export const nOnCurve = ([[x1, y1], [x2, y2], [x3, y3], [x4, y4]], t) =>
  normalize([
    (-3 * (1 - t) ** 2 * y1 +
      3 * ((1 - t) ** 2 - 2 * (1 - t) * t) * y2 +
      3 * (-1 * t ** 2 + (1 - t) * 2 * t) * y3 +
      3 * t ** 2 * y4) *
      -1,
    -3 * (1 - t) ** 2 * x1 +
      3 * ((1 - t) ** 2 - 2 * (1 - t) * t) * x2 +
      3 * (-1 * t ** 2 + (1 - t) * 2 * t) * x3 +
      3 * t ** 2 * x4
  ]);

export const nOnCurves = (curves, t) => {
  const th = t * curves.length;
  const curveIndex = th === curves.length ? curves.length - 1 : Math.floor(th);
  const curveT = th - curveIndex * curves.length;
  return nOnCurve(curves[curveIndex], curveT);
};
