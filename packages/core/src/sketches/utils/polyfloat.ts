import { range, unitRange } from "./index";

const unitRangeWithExtraMidpoint = n => {
  const startRange = unitRange(n);
  const spliceAt = Math.floor(n / 2);
  startRange.splice(spliceAt, 0, 0.5);
  return startRange;
};

const lerpTuple = k => ([x1, y1]) => ([x2, y2]) => [
  (1 - k) * x1 + k * x2,
  (1 - k) * y1 + k * y2
];

const scaleTuple = k => ([x1, y1]) => [k * x1, k * y1];

export const polyint = (n, rotation = 0) =>
  unitRange(n + 1).map(turn => {
    const angle = 2 * Math.PI * turn + rotation;
    return [Math.cos(angle), Math.sin(angle)];
  });

export const polyfloat = (nf, rotation = 0) => {
  const nfFloor = Math.floor(nf);

  if (nf === nfFloor) {
    return polyint(nf, rotation);
  }

  const nfCeil = Math.ceil(nf);

  const nfDiff = nf - nfFloor;

  const range1 = unitRangeWithExtraMidpoint(nfCeil);

  const range2 = unitRange(nfCeil + 1);

  return range1.map((k1, index) => {
    const k2 = range2[index];
    const angle1 = 2 * Math.PI * k1 + rotation;
    const angle2 = 2 * Math.PI * k2 + rotation;
    const factor = Math.cos(Math.PI / nfFloor);
    return lerpTuple(nfDiff)(
      scaleTuple(nfFloor % 2 === 1 && k1 === 0.5 ? factor : 1)([
        Math.cos(angle1),
        Math.sin(angle1)
      ])
    )([Math.cos(angle2), Math.sin(angle2)]);
  });
};
