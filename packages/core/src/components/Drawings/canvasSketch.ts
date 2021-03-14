interface Config {
  playing: boolean;
  sketch: any;
}

const animate = () => {
  requestAnimationFrame(() => {
    animate();
  });
};

export const createAnimation = (stepper) => {
  let prevTime = new Date().getTime();
  let playhead = 0;
  let animating = false;
  stepper({ deltaTime: 0, playhead: 0 });
  const animate = () => {
    const newTime = new Date().getTime();
    const deltaTime = newTime - prevTime;
    playhead += deltaTime;
    stepper({ deltaTime, playhead });
    prevTime = newTime;
    requestAnimationFrame(() => {
      if (animating) {
        animate();
      }
    });
  };
  const start = () => {
    prevTime = new Date().getTime();
    animating = true;
    animate();
  };
  const stop = () => {
    animating = false;
  };
  const toggle = () => {
    animating ? stop() : start();
  };
  return {
    start,
    stop,
    toggle,
  };
};

const useCanvasSketch = (node: HTMLCanvasElement, config: Config) => {
  const canvasContext = node.getContext("2d");
  const size = node.clientWidth;
  node.width = size;
  node.height = size;
  const s = config.sketch();
  let animation = createAnimation(({ deltaTime, playhead }) => {
    s.step({
      size,
      context: canvasContext,
      deltaTime: deltaTime,
      playhead: playhead,
    });
  });
  if (config.playing) {
    animation.start();
  }
  return {
    update: (newConfig) => {
      if (newConfig.playing) {
        animation.start();
      } else {
        animation.stop();
      }
    },
    destroy: () => {
      animation.stop();
    },
  };
};

export default useCanvasSketch;
