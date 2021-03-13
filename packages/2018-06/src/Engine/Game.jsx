import React from "react";
import * as webgl from "./utils/webgl";

export default class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      gl: null
    };
  }
  render() {
    return (
      <canvas
        style={{
          position: "absolute",
          top: "50%",
          left: "50%",
          transform: "translate3d(-50%, -50%, 0)"
        }}
        width={this.props.size}
        height={this.props.size}
        ref={node => {
          this.containerNode = node;
        }}
      >
        {this.state.gl
          ? React.Children.map(this.props.children, child =>
              React.cloneElement(child, {
                gl: this.state.gl
              })
            )
          : null}
      </canvas>
    );
  }

  componentDidMount() {
    const gl = webgl.create(this.containerNode);
    this.setState(prevState => ({
      gl
    }));
    setTimeout(() => {
      this.forceUpdate();
    }, 50);
    this.update();
  }

  setPerspective() {
    const lat = !this.props.lat && this.props.lat !== 0 ? 30 : this.props.lat;
    const lng = !this.props.lng && this.props.lng !== 0 ? 30 : this.props.lng;
    webgl.setPerspective(this.state.gl, lat, lng);
  }

  update() {
    if (!this.state.gl) {
      return;
    }
    this.state.gl.clearColor(0, 0, 0, 0);
    this.state.gl.clear(
      this.state.gl.COLOR_BUFFER_BIT | this.state.gl.DEPTH_BUFFER_BIT
    );
    this.state.gl &&
      this.state.gl.viewport(0, 0, this.props.size, this.props.size);
    this.setPerspective();
  }

  componentWillUpdate() {
    this.update();
  }
}
