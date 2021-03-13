import React, { Component } from "react";
import { drawShape } from "./utils/webgl";

const { Matrix4 } = window;

/**
 * Create moebius shape
 * @returns {Object} shape - Moebius shape.
 */
export function moebius() {
  const n = 161;
  let vertices = [];
  let connectivity = [];
  const radius = 0.5;
  const width = 0.25;
  const color = [0.9, 0.9, 0.9, 0.6];
  for (let i = 0; i < n; i += 1) {
    let angle = ((2 * Math.PI) / (n - 3)) * i;
    let sinAngle = Math.sin(angle);
    let cosAngle = Math.cos(angle);
    let projectedRadius =
      i % 2 === 0
        ? radius - (width / 2) * sinAngle
        : radius + (width / 2) * sinAngle;
    let normal = [sinAngle * cosAngle, sinAngle * sinAngle, cosAngle];
    let position = [
      projectedRadius * cosAngle,
      projectedRadius * sinAngle,
      (((i % 2 === 0 ? 1 : -1) * width) / 2) * cosAngle,
    ];
    vertices = vertices.concat([
      position[0],
      position[1],
      position[2],
      normal[0],
      normal[1],
      normal[2],
      color[0],
      color[1],
      color[2],
      color[3],
    ]);
    if (i > 1) {
      connectivity = connectivity.concat([i - 2, i - 1, i]);
    }
  }
  return {
    vertices: new Float32Array(vertices),
    connectivity: new Uint8Array(connectivity),
  };
}

const moebiusShape = moebius();

export default class Moebius extends Component {
  render() {
    return null;
  }

  update() {
    this.props.gl && drawShape(this.props.gl, moebiusShape);
  }

  componentDidMount() {
    this.update();
  }

  componentDidUpdate() {
    this.update();
  }
}
