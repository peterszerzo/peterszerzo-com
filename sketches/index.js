import pack from "./03-pack";
import theSpin from "./04-the-spin";

const sketches = sketchName => {
  switch (sketchName) {
    case "pack":
      return pack;
    case "the-spin":
      return theSpin;
    default:
      return pack;
  }
};

export default sketches;
