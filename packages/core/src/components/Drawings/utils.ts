import { range, map, unnest } from "ramda";

export type Pt = [number, number];

export type Vec3 = [number, number, number];

export const unitRange = (n: number) => range(0, n).map((val) => val / (n - 1));

export const range2 = (n: number) =>
  unnest(
    map((i) => map((j) => [i / (n - 1), j / (n - 1)], range(0, n)), range(0, n))
  );

export const distance = (pt1: Pt, pt2: Pt): number =>
  ((pt1[0] - pt2[0]) ** 2 + (pt1[1] - pt2[1]) ** 2) ** 0.5;

// Polygons

const unitRangeWithExtraMidpoint = (n: number) => {
  const startRange = unitRange(n);
  const spliceAt = Math.floor(n / 2);
  startRange.splice(spliceAt, 0, 0.5);
  return startRange;
};

const lerpTuple = (k: number) => ([x1, y1]: Pt) => ([x2, y2]: Pt) => [
  (1 - k) * x1 + k * x2,
  (1 - k) * y1 + k * y2,
];

export const lerp3 = (k: number) => ([x1, y1, z1]: Vec3) => ([
  x2,
  y2,
  z2,
]: Vec3) => [
  (1 - k) * x1 + k * x2,
  (1 - k) * y1 + k * y2,
  (1 - k) * z1 + k * z2,
];

const scaleTuple = (k: number) => ([x1, y1]: Pt): Pt => [k * x1, k * y1];

export const polyint = (n: number, rotation = 0) =>
  unitRange(n + 1).map((turn) => {
    const angle = 2 * Math.PI * turn + rotation;
    return [Math.cos(angle), Math.sin(angle)];
  });

export const polyfloat = (nf: number, rotation = 0) => {
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
        Math.sin(angle1),
      ])
    )([Math.cos(angle2), Math.sin(angle2)]);
  });
};

// Svelte utilities

type StoreCallback<T> = (val: T) => void;

interface Store<T> {
  subscribe: (callback: StoreCallback<T>) => void;
}

function diff<T>(val1: T, val2: T): T {
  if (typeof val1 === "number" && typeof val2 === "number") {
    return ((val1 - val2) as unknown) as T;
  }
  const d: T = ({} as unknown) as T;
  Object.keys(val1).forEach((key) => {
    d[key] = val1[key] - val2[key];
  });
  return d;
}

export function diffStore<T>(store: Store<T>) {
  let prev: T | undefined = undefined;

  let subscribers = [];

  store.subscribe((val: T) => {
    if (typeof prev !== "undefined") {
      subscribers.forEach((callback) => callback(diff(val, prev)));
    }
    prev = val;
  });

  return {
    subscribe: (callback: StoreCallback<number>) => {
      subscribers = [...subscribers, callback];
      return () => {
        subscribers = subscribers.filter(
          (currentCallback) => currentCallback !== callback
        );
      };
    },
  };
}
