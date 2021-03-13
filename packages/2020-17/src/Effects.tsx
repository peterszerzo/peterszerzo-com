import { useMemo, useEffect, useRef } from "react";
import { useLoader, useThree, useFrame } from "react-three-fiber";
import {
  SMAAImageLoader,
  BlendFunction,
  EffectComposer,
  EffectPass,
  RenderPass,
  SMAAEffect,
  SSAOEffect,
  NormalPass,
} from "postprocessing";

// Fix smaa loader signature
const _load = SMAAImageLoader.prototype.load;
SMAAImageLoader.prototype.load = function(_: any, set: any) {
  return _load.bind(this)(set);
};

const Effects: React.FunctionComponent<{ checksum: any }> = (props) => {
  const { gl, scene, camera, size } = useThree();
  const smaa = useLoader(SMAAImageLoader, "");
  const composer = useMemo(() => {
    const composer = new EffectComposer(gl);
    composer.addPass(new RenderPass(scene, camera));
    const smaaEffect = new SMAAEffect(...(smaa as any));
    smaaEffect.colorEdgesMaterial.setEdgeDetectionThreshold(0.1);
    const normalPass = new NormalPass(scene, camera);
    const ssaoEffect = new SSAOEffect(camera, normalPass.renderTarget.texture, {
      blendFunction: BlendFunction.MULTIPLY,
      samples: 30,
      rings: 3,
      distanceThreshold: 1, // Render distance depends on camera near&far.
      distanceFalloff: 0.0, // No need for falloff.
      rangeThreshold: 0.05, // Larger value works better for this camera frustum.
      rangeFalloff: 0.01,
      luminanceInfluence: 0.6,
      radius: 80,
      scale: 0.32,
      bias: 0.5,
    });
    const effectPass = new EffectPass(camera, smaaEffect, ssaoEffect);
    effectPass.renderToScreen = true;
    composer.addPass(normalPass);
    composer.addPass(effectPass);
    return composer;
  }, []);

  const framesSinceChecksumChange = useRef(0);

  useEffect(() => void composer.setSize(size.width, size.height), [size]);

  useEffect(() => {
    framesSinceChecksumChange.current = 0;
  }, [props.checksum]);

  useFrame((_, delta) => {
    if (framesSinceChecksumChange.current > 50) {
      return;
    }
    composer.render(delta);
    framesSinceChecksumChange.current++;
  }, 1);
  return null;
};

export default Effects;
