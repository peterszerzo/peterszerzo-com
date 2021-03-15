import * as React from "react";
import { render } from "react-dom";
import * as three from "three";
import { range } from "ramda";
import { Canvas, useThree } from "react-three-fiber";
import * as noisePackage from "noisejs";
import { EffectComposer, SSAO } from "react-postprocessing";

const sphereMaterial = (uniforms: { color: three.Vector3 }) =>
  new three.ShaderMaterial({
    uniforms: {
      color: {
        value: uniforms.color
      }
    },
    vertexShader: `
precision mediump float;
uniform float time;

varying float brightness;

const float PI = 3.14159;

mat4 rotateAround(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
  float phase = 0.5 * sin(15.0 * dot(normal, vec3(1.0)));

  vec3 tangential = normalize(cross(normal, position));
  vec3 radial = cross(normal, tangential);

  float k = 0.5 + 0.5 * sin(0.0 * time * 0.001 + phase);
  float k2 = sin(0.0 * time * 0.004 + phase);

  vec3 offset = normal * k * 4.95;

  mat4 rotated = rotateAround(normal, k2 * 0.05 * PI);

  vec3 lightDir = normalize(vec3(3.2, 1.2, 1.0));

  brightness = 1.0 - 0.4 * dot(normal, lightDir);

  gl_Position =
    projectionMatrix *
    modelViewMatrix *
    rotated *
    vec4(
      position + offset,
      1.0
    );
}
  `,
    fragmentShader: `
precision mediump float;

varying float brightness;
uniform vec3 color;

void main() {
  gl_FragColor = vec4(brightness * color, 1.0);
}
  `
  });

type ShapeType =
  | "icosahedron"
  | "polyhedron"
  | "octahedron"
  | "cylinder"
  | "tetrahedron"
  | "cube"
  | "torus"
  | "sphere";

const pickShape = (index: number): ShapeType => {
  const shapeTypes: Array<ShapeType> = [
    "polyhedron",
    "icosahedron",
    "cube",
    "polyhedron",
    "cylinder",
    "tetrahedron",
    "torus",
    "sphere"
  ];
  return shapeTypes[index % 6];
};

const Shape: React.FunctionComponent<{
  type: ShapeType;
  position: [number, number, number];
  rotation: number;
  color: three.Vector3;
  scale: number;
}> = props => {
  const geometry = React.useMemo(() => {
    return props.type === "icosahedron"
      ? new three.IcosahedronBufferGeometry(1, 0)
      : props.type === "polyhedron"
      ? new three.DodecahedronBufferGeometry(1, 0)
      : props.type === "cylinder"
      ? new three.CylinderBufferGeometry(1, 1, 1, 3, 4)
      : props.type === "cube"
      ? new three.BoxBufferGeometry(1, 0)
      : props.type === "tetrahedron"
      ? new three.TetrahedronBufferGeometry(1, 0)
      : props.type === "torus"
      ? new three.TorusBufferGeometry(1, 0.2, 3, 3)
      : props.type === "sphere"
      ? new three.SphereBufferGeometry(1, 8, 8)
      : new three.OctahedronBufferGeometry(1, 0);
  }, [props.type]);

  const material = React.useMemo(() => {
    return sphereMaterial({
      color: props.color
    });
  }, [props.color]);

  return (
    <mesh
      position={props.position}
      rotation={new three.Euler().setFromRotationMatrix(
        new three.Matrix4().makeRotationAxis(
          new three.Vector3(0.7, 0.2, 0.2),
          props.rotation
        )
      )}
      scale={[props.scale, props.scale, props.scale]}
      geometry={geometry}
      material={material}
    ></mesh>
  );
};

const backdropMaterial = new three.ShaderMaterial({
  uniforms: {},
  vertexShader: `
precision mediump float;
varying vec2 vUv;

void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
  `,
  fragmentShader: `
precision mediump float;

varying vec2 vUv;

void main() {
  gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
  `
});

const backdropGeometry = new three.PlaneBufferGeometry(55, 55, 4, 4);

const Backdrop: React.FunctionComponent<{}> = () => {
  return (
    <mesh
      position={[0, 0, -30]}
      material={backdropMaterial}
      geometry={backdropGeometry}
    ></mesh>
  );
};

const palette = [
  new three.Vector3(255, 164, 0).multiplyScalar(1 / 255.0),
  new three.Vector3(0, 159, 253).multiplyScalar(1 / 255.0),
  new three.Vector3(42, 42, 114).multiplyScalar(1 / 255.0),
  new three.Vector3(35, 37, 40).multiplyScalar(1 / 255.0),
  new three.Vector3(128, 154, 181).multiplyScalar(1 / 255.0)
];

const Scene: React.FunctionComponent<{ noise: any }> = props => {
  const threeContext = useThree();

  React.useEffect(() => {
    threeContext.camera.position.set(-0.5, 0, 6);
    threeContext.camera.lookAt(0, 0, 0);
    threeContext.camera.updateProjectionMatrix();
  }, []);

  const grid: Array<{
    type: ShapeType;
    position: [number, number, number];
    rotation: number;
    scale: number;
    color: three.Vector3;
  }> = React.useMemo(
    () =>
      range2(9).map(([u, v], index) => ({
        type: pickShape(Math.floor(props.noise.perlin2(u * 3, v * 3) * 37)),
        position: [-3 + 6 * u, -3 + 6 * v, 0],
        rotation: props.noise.perlin2(u * 9, v * 9),
        scale: 0.24 + 0.06 * Math.sin(u * v * u * 71),
        color: palette[Math.floor(index + u * v * 17) % 5]
      })),
    [props.noise]
  );

  return (
    <>
      {grid.map((gridItem, index) => (
        <Shape
          key={index}
          type={gridItem.type}
          position={gridItem.position}
          rotation={gridItem.rotation}
          scale={gridItem.scale}
          color={gridItem.color}
        />
      ))}
      <Backdrop />
    </>
  );
};

const range2 = (n: number): Array<[number, number]> =>
  range(0)(n)
    .map(i =>
      range(0)(n).map(j => {
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

const Container: React.FunctionComponent<{}> = props => {
  const [seed, setSeed] = React.useState(0);

  const noise = React.useMemo(() => {
    const noise = new (noisePackage as any).Noise();
    noise.seed(seed);
    return noise;
  }, [seed]);

  React.useEffect(() => {
    const handler: EventListener = (ev: any) => {
      if (ev.key === "a") {
        setSeed(Math.floor(Math.random() * 50000));
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
      gl={{
        antialias: true,
        alpha: true,
        logarithmicDepthBuffer: true,
        preserveDrawingBuffer: true
      }}
      onCreated={({ size, camera }) => {
        camera.zoom = (70 * size.width) / 600;
        camera.updateProjectionMatrix();
      }}
      camera={{
        near: 2,
        far: 120,
        zoom: (70 * 600) / 600
      }}
      orthographic
    >
      <ambientLight intensity={0.5} />
      <pointLight position={[19, 10, 10]} intensity={0.5} />
      <directionalLight position={[0, 0, 10]} intensity={0.6} />
      <directionalLight position={[5, 0, 0]} intensity={0.4} />
      <Scene noise={noise} />
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
  );
};

const start = () => {
  const rootNode = document.querySelector("#root");
  render(<Container />, rootNode);
};

start();
