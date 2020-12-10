import range from "ramda/src/range";
import map from "ramda/src/map";
import unnest from "ramda/src/unnest";

export type Pt = [number, number];

export const unitRange = (n: number) => range(0, n).map((val) => val / (n - 1));

export const range2 = (n: number) =>
  unnest(
    map((i) => map((j) => [i / (n - 1), j / (n - 1)], range(0, n)), range(0, n))
  );

export const distance = (pt1: Pt, pt2: Pt): number =>
  ((pt1[0] - pt2[0]) ** 2 + (pt1[1] - pt2[1]) ** 2) ** 0.5;

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
