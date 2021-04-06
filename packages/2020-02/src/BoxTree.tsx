import * as React from "react";
import * as three from "three";
import { Tree } from "./geometry";

// Box component

interface LeafProps {
  position: [number, number, number];
  rotation?: three.Euler;
  material: three.Material;
}

const globalScale = 8;

const globalCube = new three.BoxBufferGeometry().scale(
  globalScale,
  globalScale,
  globalScale
);

const Leaf: React.FunctionComponent<LeafProps> = (props) => {
  return <mesh {...props} geometry={globalCube} />;
};

// Boxes component

interface TreeStepProps {
  tree: Tree;
  open: number;
  material: three.Material;
  xEulerCache?: three.Euler;
  yEulerCache?: three.Euler;
}

export const treeStepXEuler = (open: number) =>
  new three.Euler().setFromRotationMatrix(
    new three.Matrix4().makeRotationX((open * -Math.PI) / 2)
  );

export const treeStepYEuler = (open: number) =>
  new three.Euler().setFromRotationMatrix(
    new three.Matrix4().makeRotationY((open * -Math.PI) / 2)
  );

const TreeStep: React.FunctionComponent<TreeStepProps> = (props) => {
  if (props.tree === null) {
    return null;
  }

  const xEuler = props.xEulerCache || (() => treeStepXEuler(props.open))();

  const yEuler = props.yEulerCache || (() => treeStepYEuler(props.open))();

  return (
    <>
      <Leaf material={props.material} position={[0, 0, 0]} />
      <group position={[props.open * globalScale, 0, 0]} rotation={yEuler}>
        <TreeStep
          tree={props.tree.child1}
          open={props.open}
          material={props.material}
          xEulerCache={xEuler}
          yEulerCache={yEuler}
        />
      </group>
      <group position={[0, props.open * globalScale, 0]} rotation={xEuler}>
        <TreeStep
          tree={props.tree.child2}
          open={props.open}
          material={props.material}
          xEulerCache={xEuler}
          yEulerCache={yEuler}
        />
      </group>
      <group position={[0, 0, props.open * globalScale]}>
        <TreeStep
          tree={props.tree.child3}
          open={props.open}
          material={props.material}
          xEulerCache={xEuler}
          yEulerCache={yEuler}
        />
      </group>
    </>
  );
};

// BoxTree

export interface BoxTreeProps {
  time: number;
  trees: Tree[];
  position: three.Vector3;
  color: string;
}

const animSpeed = 0.5;

const treeIndex = (time: number): number =>
  Math.floor(0.25 + (0.001 * time) / 2 / Math.PI);

const expoInOutFactor = 8;

const expoInOut = (t: number) =>
  t === 0.0 || t === 1.0
    ? t
    : t < 0.5
    ? +0.5 * Math.pow(2.0, expoInOutFactor * 2 * t - expoInOutFactor)
    : -0.5 * Math.pow(2.0, expoInOutFactor - t * 2 * expoInOutFactor) + 1.0;

const expandFactor = (time: number): number =>
  0.5 + 0.5 * Math.sin(0.001 * time);

export const getOpen = (time: number) =>
  expoInOut(expandFactor(time * animSpeed));

export const getIndex = (time: number) => treeIndex(time * animSpeed);

export const BoxTree: React.FunctionComponent<BoxTreeProps> = (props) => {
  const index = getIndex(props.time);
  const open = getOpen(props.time);

  const tree = props.trees[index % props.trees.length];

  const material = React.useMemo(
    () =>
      new three.MeshPhongMaterial({
        color: props.color,
      }),
    [props.color]
  );

  return (
    <group position={props.position}>
      <TreeStep material={material} tree={tree} open={open} />
    </group>
  );
};
