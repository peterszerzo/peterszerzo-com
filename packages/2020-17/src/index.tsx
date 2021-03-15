import * as React from "react";
import { render } from "react-dom";
import * as three from "three";
import range from "ramda/src/range";
import { Canvas } from "react-three-fiber";
import SimplexNoise from "simplex-noise";
import { EffectComposer, SSAO } from "react-postprocessing";

const createGrid = (spreadSeed: number) => {
  const n = 300;

  const noise = new SimplexNoise("sampl");

  const grid = range(0)(n).map((i) => {
    return {
      x: 0.8 * noise.noise2D((1 + 0.1 * spreadSeed) * i * i, 2 * i),
      y: 0.8 * noise.noise2D(3 * i, 4 * i * i),
      z: 0.8 * noise.noise2D(-4 * i, (2 + 0.3 * spreadSeed) * i),
      size: 0.2 * (0.5 + 0.3 * noise.noise2D(6 * i, -i)),
    };
  });

  return grid;
};

const sphere = new three.SphereBufferGeometry(3, 32, 32);

const SphereCloud: React.FunctionComponent<{
  spreadSeed: number;
  material: three.Material;
}> = (props) => {
  const grid = createGrid(props.spreadSeed);
  return (
    <>
      {grid.map((gridItem, index) => (
        <mesh
          position={[3 * gridItem.x, 3 * gridItem.y, 3 * gridItem.z - 10]}
          key={index}
          scale={[gridItem.size, gridItem.size, gridItem.size]}
          geometry={sphere}
          material={props.material}
        ></mesh>
      ))}
    </>
  );
};

const sphereColors = ["#5D737E", "#888", "#7f2828", "#51537f"];

const Container: React.FunctionComponent<{ size: number }> = (props) => {
  const [colorIndex, setColorIndex] = React.useState(0);

  const [spreadSeed, setSpreadSeed] = React.useState(0);

  React.useEffect(() => {
    const handler: EventListener = (ev: any) => {
      if (ev.key === " ") {
        setColorIndex((prevColorIndex) =>
          prevColorIndex === sphereColors.length - 1 ? 0 : prevColorIndex + 1
        );
      }
      if (ev.key === "a") {
        setSpreadSeed((prevSpreadSeed) => prevSpreadSeed + 1);
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

  const sphereMaterial = React.useMemo(
    () =>
      new three.MeshLambertMaterial({
        color: sphereColors[colorIndex],
      }),
    [colorIndex]
  );

  return (
    <div style={{ width: props.size, height: props.size }}>
      <Canvas
        camera={{
          near: 2,
          far: 120,
          zoom: 3.2,
        }}
      >
        <ambientLight intensity={0.4} />
        <pointLight position={[19, 10, 10]} intensity={0.4} />
        <directionalLight position={[0, 0, 10]} intensity={0.3} />
        <directionalLight position={[5, 0, 0]} intensity={0.4} />
        <SphereCloud spreadSeed={spreadSeed} material={sphereMaterial} />
        <EffectComposer multisampling={0}>
          <SSAO
            samples={31}
            radius={20}
            intensity={40}
            luminanceInfluence={0.1}
            color="black"
          />
        </EffectComposer>
      </Canvas>
    </div>
  );
};

const start = () => {
  const rootNode = document.querySelector("#root");
  render(<Container size={600} />, rootNode);
};

start();
