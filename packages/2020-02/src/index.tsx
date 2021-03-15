import * as React from "react";
import { render } from "react-dom";
import range from "ramda/src/range";
import * as three from "three";
import { Canvas, useThree } from "react-three-fiber";
import { getOpen, BoxTree } from "./BoxTree";
import { useAnimationFrame } from "./utils";
import { generateTree } from "./geometry";
import { Loop, Transport, Synth, PolySynth, Gain } from "tone";
import { EffectComposer, SSAO } from "react-postprocessing";

const range2d = (n: number): Array<[number, number]> =>
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

const grid = range2d(3).map(([x, y], index) => ({
  x,
  y,
  trees: [
    generateTree(0.75 + 0.2 * Math.cos(index * 101), index * 0.3),
    generateTree(0.75 + 0.2 * Math.cos(index * 31), index * 0.4),
    generateTree(0.75 + 0.2 * Math.cos(index * 71), index * 0.5),
  ],
}));

const App: React.FunctionComponent<{ time: number }> = (props) => {
  const threeContext = useThree();

  const scale = 2.6;

  React.useEffect(() => {
    threeContext.camera.position.set(6 * scale, -8 * scale, 20 * scale);
    threeContext.camera.lookAt(0, 4, 0);
    threeContext.camera.updateProjectionMatrix();
  }, []);

  return (
    <>
      {grid.map(({ x, y, trees }, index) => (
        <BoxTree
          key={index}
          time={props.time + x * 1000 + y * 1000}
          trees={trees}
          position={
            new three.Vector3(
              (x - 0.5) * 55 + 0.3 * Math.sin(props.time * 0.001 + index * 0.3),
              (y - 0.5) * 55 +
                0.3 * Math.sin(2 * props.time * 0.001 + index * 0.6),
              -5 +
                3.5 * Math.sin(35 * x ** 2 + 35 * y ** 2) +
                0.2 * Math.sin(1.5 * props.time * 0.001 + index * 0.6)
            )
          }
          color="rgb(167, 29, 49)"
        />
      ))}
    </>
  );
};

const PlayPauseButton: React.FunctionComponent<{
  playing: boolean;
  onClick: () => void;
}> = (props) => (
  <button
    title={props.playing ? "Pause sound" : "Play with sound"}
    className="play-pause-button"
    onClick={() => props.onClick()}
  >
    {!props.playing ? (
      <svg
        viewBox="0 0 24 24"
        fill="currentColor"
        stroke="none"
        strokeLinecap="round"
        strokeLinejoin="round"
        className="feather feather-play"
      >
        <polygon
          transform="translate(2 0)"
          points="5 3 19 12 5 21 5 3"
        ></polygon>
      </svg>
    ) : (
      <svg
        viewBox="0 0 24 24"
        fill="currentColor"
        stroke="none"
        strokeLinecap="round"
        strokeLinejoin="round"
        className="feather feather-pause"
      >
        <rect x="6" y="4" width="4" height="16"></rect>
        <rect x="14" y="4" width="4" height="16"></rect>
      </svg>
    )}
  </button>
);

interface ContainerProps {
  sound?: boolean;
}

const Container: React.FunctionComponent<ContainerProps> = () => {
  const [time, setTime] = React.useState(0);

  useAnimationFrame((diff) => {
    setTime((prevTime) => prevTime + diff);
  });

  const [playing, setPlaying] = React.useState(false);

  const [opacity, setOpacity] = React.useState(0);

  React.useEffect(() => {
    requestAnimationFrame(() => {
      setOpacity(1);
    });
  }, []);

  React.useEffect(() => {
    if (playing) {
      const mainSynth = new PolySynth(Synth, {
        oscillator: {
          type: "square",
        },
        envelope: {
          attack: 0.01,
          decay: 0.1,
          sustain: 0.1,
          release: 1.2,
        },
      });

      const harmony = [["C3"], ["C3"], ["C3", "C4"], ["C3"]];

      const gain = new Gain(0.8).toDestination();

      mainSynth.connect(gain);

      let ticks: number = 0;

      const song = (songTime: number) => {
        const timeFromSongTime = songTime * 1000;
        const velocity = getOpen(timeFromSongTime + 1000);
        mainSynth.triggerAttackRelease(
          harmony[ticks % 4],
          "16n",
          songTime,
          velocity
        );
        ticks = ticks + 1;
      };

      const loopBeat = new Loop(song, "4n");

      Transport.bpm.value = 220;
      Transport.swing = 1;
      Transport.start();

      loopBeat.start(0);

      return () => {
        loopBeat.stop();
        gain.disconnect();
        mainSynth.disconnect();
        Transport.stop();
      };
    }
  }, [playing]);

  return (
    <>
      <PlayPauseButton
        playing={playing}
        onClick={() => setPlaying((playing) => !playing)}
      />
      <div
        style={{
          opacity,
          background: "linear-gradient(45deg, #343445, #121223)",
        }}
        className="container"
      >
        <Canvas
          gl={{ antialias: true, alpha: true }}
          camera={{
            near: 2,
            far: 120,
            zoom: 5,
          }}
          orthographic
        >
          <ambientLight intensity={0.1} />
          <directionalLight position={[0, 0, 10]} intensity={0.4} />
          <directionalLight position={[5, 0, 0]} intensity={0.2} />
          <directionalLight position={[0, -5, 0]} intensity={0.1} />
          <App time={time} />
          <EffectComposer multisampling={0}>
            <SSAO
              samples={31}
              radius={20}
              intensity={280}
              luminanceInfluence={0.1}
              color="black"
            />
          </EffectComposer>
        </Canvas>
      </div>
    </>
  );
};

const start = () => {
  const loaderNode: HTMLElement | null = document.querySelector("#loader");
  const rootNode = document.querySelector("#root");
  if (loaderNode) {
    loaderNode.style.opacity = "0";
    setTimeout(() => {
      render(<Container />, rootNode);
    }, 300);
  } else {
    render(<Container />, rootNode);
  }
};

start();
