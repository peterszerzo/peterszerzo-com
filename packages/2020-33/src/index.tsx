import * as React from "react";
import { render } from "react-dom";
import * as three from "three";
import range from "ramda/src/range";
import { Canvas, useThree, useFrame } from "react-three-fiber";
import Effects from "./Effects";
import * as noise from "noisejs";

const palette = ["#a31621", "#fcf7f8", "#ced3dc", "#4e8098", "#90c2e7"];

const getPalette = (index: number) => {
  return palette[Math.abs(Math.floor(index) % palette.length)];
};

interface Body {
  rotation: number;
  rotationVelocity: number;
  centrifugal: number;
}

const applyDelta = (delta: number, body: Body) => {
  const force = -0.0 * body.rotation;
  return {
    rotation: body.rotation + body.rotationVelocity * delta,
    rotationVelocity: body.rotationVelocity + force * delta,
    centrifugal: body.centrifugal,
  };
};

const Shape: React.FC<{
  position: [number, number, number];
  scale: number;
  color: string;
  gridOffset: number;
}> = (props) => {
  const material = React.useMemo(() => {
    return new three.MeshPhongMaterial({
      color: props.color,
    });
  }, [props.color]);

  const meshRef = React.useRef<three.Mesh | null>(null);

  const body = React.useRef<Body>({
    rotation: 0,
    rotationVelocity: 1000,
    centrifugal: 0,
  });

  useFrame((fr) => {
    const time = fr.clock.elapsedTime;
    const delta = fr.clock.getDelta();
    body.current = applyDelta(delta, body.current);
    const relTime = time * 0.4 + 150 * props.gridOffset;
    const rotation = Math.PI / 4 + 1 * Math.PI * Math.sin(relTime);
    const rotationVelocity = Math.cos(relTime);

    if (meshRef.current !== null) {
      meshRef.current.setRotationFromMatrix(
        new three.Matrix4()
          .makeRotationAxis(new three.Vector3(0, 0, 1), -rotation)
          .multiply(
            new three.Matrix4().makeRotationAxis(
              new three.Vector3(1, 0, 0),
              rotation
            )
          )
          .multiply(
            new three.Matrix4().makeRotationAxis(
              new three.Vector3(0, 1, 0),
              rotation
            )
          )
      );
      const rs = rotationVelocity ** 2;
      meshRef.current.scale.set(
        (1 + 0.7 * rs) * props.scale,
        (1 - 0.95 * rs) * props.scale,
        (1 + 0.7 * rs) * props.scale
      );
    }
  });

  return (
    <mesh
      ref={meshRef}
      position={props.position}
      geometry={new three.CylinderBufferGeometry(1, 1, 1, 16, 16)}
      material={material}
    ></mesh>
  );
};

const Scene: React.FunctionComponent<{ noise: any }> = (props) => {
  const threeContext = useThree();

  React.useEffect(() => {
    threeContext.camera.position.set(-0.5, 0, 20);
    threeContext.camera.lookAt(0, 0, 0);
    threeContext.camera.updateProjectionMatrix();
  }, []);

  const grid: Array<{
    position: [number, number, number];
    color: string;
    scale: number;
    gridOffset: number;
  }> = React.useMemo(
    () =>
      range2(24).map(([u, v]) => ({
        position: [
          -6 + 12 * u + 5 * props.noise.perlin2(u, v),
          -6 + 12 * v + 5 * props.noise.perlin2(v, u),
          18 * props.noise.simplex2(u * 13, v * 13),
        ],
        color: getPalette(Math.floor(props.noise.simplex2(u, v) * 17)),
        scale: 0.4 + 0.3 * props.noise.simplex2(u * 7, v * 7),
        gridOffset: 2.4 * props.noise.simplex2(u * 13, v * 13),
      })),
    [props.noise]
  );

  return (
    <>
      {grid.map((gridItem, index) => (
        <Shape
          key={index}
          position={gridItem.position}
          scale={gridItem.scale}
          color={gridItem.color}
          gridOffset={gridItem.gridOffset}
        />
      ))}
    </>
  );
};

const range2 = (n: number): Array<[number, number]> =>
  range(0)(n)
    .map((i) =>
      range(0)(n).map((j) => {
        const res: [number, number] = [i / (n - 1), j / (n - 1)];
        return res;
      })
    )
    .reduce(
      (
        accumulator: Array<[number, number]>,
        current: Array<[number, number]>
      ): Array<[number, number]> => [...accumulator, ...current],
      []
    );

const Container: React.FunctionComponent<{}> = () => {
  const [seed, setSeed] = React.useState(2500);

  const n = React.useMemo(() => {
    const n = new (noise as any).Noise();
    n.seed(seed);
    return n;
  }, [seed]);

  React.useEffect(() => {
    const handler: EventListener = (ev: any) => {
      if (ev.key === "a") {
        setSeed((prevSeed) => prevSeed + 1);
      }
      if (ev.key === "d" && ev.shiftKey && ev.metaKey) {
        const canvasNode = document.querySelector("canvas");
        if (canvasNode) {
          const image = canvasNode
            .toDataURL("image/png")
            .replace("image/png", "image/octet-stream");
          window.location.href = image;
        }
      }
    };
    document.addEventListener("keydown", handler);
    return () => {
      document.removeEventListener("keydown", handler);
    };
  }, []);

  return (
    <Canvas
      style={{ backgroundColor: "#fff" }}
      gl={{
        antialias: true,
        alpha: true,
        logarithmicDepthBuffer: true,
        preserveDrawingBuffer: true,
      }}
      camera={{
        near: 1,
        far: 120,
        zoom: 30,
      }}
      orthographic
    >
      <ambientLight intensity={0.2} />
      <directionalLight position={[0, 0, 10]} intensity={0.4} />
      <directionalLight position={[0, 3, 0]} intensity={0.4} />
      <directionalLight position={[5, 0, 0]} intensity={0.8} />
      <Scene noise={n} />
      <React.Suspense fallback={null}>
        <Effects />
      </React.Suspense>
    </Canvas>
  );
};

const start = () => {
  const rootNode = document.querySelector("#root");
  render(<Container />, rootNode);
};

start();
