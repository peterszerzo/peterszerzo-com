import React, { Component } from "react";
import { drawShape } from "./utils/webgl";
import { transformOntoMoebius, trianglesToWebglObject } from "./utils/geometry";

const { Matrix4 } = window;

const s = 0.03;

const triangles = [
  {
    normal: [0, 0, 1],
    coordinates: [
      [s, s, s],
      [s, -s, s],
      [-s, -s, s],
    ],
  },
  {
    normal: [0, 0, 1],
    coordinates: [
      [-s, -s, s],
      [-s, s, s],
      [s, s, s],
    ],
  },
  {
    normal: [0, 0, -1],
    coordinates: [
      [s, s, -s],
      [s, -s, -s],
      [-s, -s, -s],
    ],
  },
  {
    normal: [0, 0, -1],
    coordinates: [
      [-s, -s, -s],
      [-s, s, -s],
      [s, s, -s],
    ],
  },
  {
    normal: [1, 0, 0],
    coordinates: [
      [-s, s, s],
      [-s, s, -s],
      [-s, -s, -s],
    ],
  },
  {
    normal: [1, 0, 0],
    coordinates: [
      [-s, -s, -s],
      [-s, -s, s],
      [-s, s, s],
    ],
  },
  {
    normal: [-1, 0, 0],
    coordinates: [
      [s, s, s],
      [s, s, -s],
      [s, -s, -s],
    ],
  },
  {
    normal: [-1, 0, 0],
    coordinates: [
      [s, -s, -s],
      [s, -s, s],
      [s, s, s],
    ],
  },
  {
    normal: [0, 1, 0],
    coordinates: [
      [s, -s, s],
      [s, -s, -s],
      [-s, -s, -s],
    ],
  },
  {
    normal: [0, 1, 0],
    coordinates: [
      [-s, -s, -s],
      [-s, -s, s],
      [s, -s, s],
    ],
  },
  {
    normal: [0, 1, 0],
    coordinates: [
      [s, s, s],
      [s, s, -s],
      [-s, s, -s],
    ],
  },
  {
    normal: [0, 1, 0],
    coordinates: [
      [-s, s, -s],
      [-s, s, s],
      [s, s, s],
    ],
  },
];

const shape = trianglesToWebglObject(triangles, [0.11, 0.4, 0.61, 1.0]);

export default class Obstacle extends Component {
  render() {
    return null;
  }

  update() {
    this.props.gl &&
      drawShape(
        this.props.gl,
        shape,
        transformOntoMoebius(this.props.x, this.props.y, this.props.z)
      );
  }

  componentDidMount() {
    this.update();
  }

  componentDidUpdate() {
    this.update();
  }
}
