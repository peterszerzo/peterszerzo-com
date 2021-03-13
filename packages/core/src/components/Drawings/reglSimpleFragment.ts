import regl from "regl";

interface Config {
  frag: string;
  playing: boolean;
}

const useRegl = (node: HTMLElement, config: Config) => {
  const instance = regl(node);

  // Calling regl() creates a new partially evaluated draw command
  const drawTriangle = instance({
    frag: config.frag,

    vert: `
      precision mediump float;
      varying vec2 fragCoord;
      attribute vec2 position;
      void main() {
        gl_Position = vec4(position, 0, 1);
        fragCoord = position;
      }`,

    // Here we define the vertex attributes for the above shader
    attributes: {
      // regl.buffer creates a new array buffer object
      position: instance.buffer([
        [-1, -1],
        [1, -1],
        [1, 1],

        [-1, -1],
        [1, 1],
        [-1, 1],
      ]),
      // regl automatically infers sane defaults for the vertex attribute pointers
    },

    uniforms: {
      time: (instance as any).prop("time"),
    },

    // This tells regl the number of vertices to draw in this command
    count: 6,
  });

  let firstRendered: boolean = false;
  let playing = config.playing;
  const tick = instance.frame((context) => {
    if (!playing && firstRendered) {
      return;
    }
    instance.clear({
      color: [0, 0, 0, 1],
      depth: 1,
    });
    drawTriangle({
      time: context.time || 0,
    });
    firstRendered = true;
  });

  return {
    update(newConfig: Config) {
      playing = newConfig.playing;
    },
    destroy() {
      tick.cancel();
    },
  };
};

export default useRegl;
