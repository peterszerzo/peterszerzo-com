// Timing

export type Tree = null | {
  child1: Tree;
  child2: Tree;
  child3: Tree;
};

const probK = 0.9;

export const generateTree = (continueProbability: number, seed: number, notTopLevel?: boolean): Tree => {
  const prob = 0.5 + 0.5 * Math.sin(43145.8 * seed);
  if (prob > continueProbability && notTopLevel) {
    return null;
  }
  return {
    child1: generateTree(continueProbability * probK, seed + 4, true),
    child2: generateTree(continueProbability * probK, seed + 5, true),
    child3: generateTree(continueProbability * probK, seed + 6, true)
  };
};
