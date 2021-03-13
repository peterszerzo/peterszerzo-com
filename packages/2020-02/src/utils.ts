import * as React from "react";
import { useFrame } from "react-three-fiber";

export const usePrevious = <T>(value: T): T | undefined => {
  const ref = React.useRef<T>();

  React.useEffect(() => {
    ref.current = value;
  }, [value]);

  return ref.current;
};

export const useDiff = () => {
  const [startTime] = React.useState(new Date().getTime());

  const [currentTime, setCurrentTime] = React.useState(new Date().getTime());

  useFrame(() => {
    setCurrentTime(new Date().getTime());
  });

  return currentTime - startTime;
};

export const useAnimationFrame = (callback: (diff: number) => void) => {
  // Use useRef for mutable variables that we want to persist
  // without triggering a re-render on their change
  const requestRef = React.useRef<number>();
  const previousTimeRef = React.useRef<number>();

  const animate = (time: number) => {
    if (previousTimeRef.current != undefined) {
      const deltaTime = time - previousTimeRef.current;
      callback(deltaTime);
    }
    previousTimeRef.current = time;
    requestRef.current = requestAnimationFrame(animate);
  };

  React.useEffect(() => {
    requestRef.current = requestAnimationFrame(animate);
    return () => {
      if (requestRef.current) cancelAnimationFrame(requestRef.current);
    };
  }, []); // Make sure the effect runs only once
};
