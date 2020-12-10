import regl, { Regl } from "regl";

// Calling regl() creates a new partially evaluated draw command
const drawTriangle = (instance: Regl) =>
  instance({
    // Shaders in regl are just strings.  You can use glslify or whatever you want
    // to define them.  No need to manually create shader objects.
    frag: `
    precision mediump float;
    varying vec2 pos;
    uniform vec3 color;
    uniform float time;
    void main() {
      vec2 grid = floor(pos * 12.0) * (0.5 * sin(0.05 * time)) +
        0.2 * vec2(0.5 * sin(0.5 * time), 1.5 * cos(1.0 * time));
      gl_FragColor = vec4(color * (0.5 + 0.5 * sin(20.0 * grid.x + 0.25 * grid.y + 20.0 * distance(pos, vec2(0.0)))), 1.0);
    }`,

    vert: `
    precision mediump float;
    varying vec2 pos;
    attribute vec2 position;
    void main() {
      gl_Position = vec4(1.9 * position, 0, 1);
      pos = position;
    }`,

    // Here we define the vertex attributes for the above shader
    attributes: {
      // regl.buffer creates a new array buffer object
      position: instance.buffer([
        [-0.5, -0.5],
        [0.5, -0.5],
        [0.5, 0.5],

        [-0.5, -0.5],
        [0.5, 0.5],
        [-0.5, 0.5],
      ]),
      // regl automatically infers sane defaults for the vertex attribute pointers
    },

    uniforms: {
      color: (instance as any).prop("color"),
      time: (instance as any).prop("time"),
    },

    // This tells regl the number of vertices to draw in this command
    count: 6,
  });

const color = [69, 176, 164].map((c) => c / 255);

const useRegl = (node: HTMLElement) => {
  const instance = regl(node);
  const tick = instance.frame((context) => {
    instance.clear({
      color: [...color, 1] as [number, number, number, number],
      depth: 1,
    });
    drawTriangle(instance)({
      color,
      time: context.time || 0,
    });
  });

  return () => {
    tick.cancel();
  };
};

export default useRegl;
