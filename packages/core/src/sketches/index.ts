import honestCash from "./honest-cash";
import misfitPlanets from "./misfit-planets";

export const sketchByName = {
  ["honest-cash"]: honestCash,
  ["misfit-planets"]: misfitPlanets,
};

export const sketches = (sketchName) => {
  return sketchByName[sketchName] || honestCash;
};

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
