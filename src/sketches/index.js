import pivotFrame from "./pivot-frame";
import cosineBeetles from "./cosine-beetles";
import theSpin from "./the-spin";
import shyCircles from "./shy-circles";
import tickle from "./tickle";
import honestCash from "./honest-cash";
import bezierRail from "./bezier-rail";

export const sketchByName = {
  ["pivot-frame"]: pivotFrame,
  ["the-spin"]: theSpin,
  ["cosine-beetles"]: cosineBeetles,
  ["shy-circles"]: shyCircles,
  ["tickle"]: tickle,
  ["honest-cash"]: honestCash,
  ["bezier-rail"]: bezierRail
};

export const sketches = sketchName => {
  return sketchByName[sketchName] || pivotFrame;
};

const animate = () => {
  requestAnimationFrame(() => {
    animate();
  });
};

export const createAnimation = stepper => {
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
    toggle
  };
};
