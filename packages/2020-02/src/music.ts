import { useEffect } from "react";
import { Loop, Transport, Synth, PolySynth, Gain } from "tone";
import { getOpen } from "./BoxTree";

export const useMusic = (playing: boolean) => {
  useEffect(() => {
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
};
