import React from "react";
import { Game, Moebius, Car, Obstacle } from "./Engine";
import { Logo, Banner } from "./Components";

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      startTime: new Date().getTime(),
      currentTime: new Date().getTime(),
      acceptKeys: true,
      window: {
        width: 300,
        height: 300
      },
      car: {
        y: 0,
        yTarget: 0,
        z: 1,
        zTarget: 1
      }
    };
  }

  render() {
    const minWH = Math.min(this.state.window.width, this.state.window.height);
    const ticks = (this.state.currentTime - this.state.startTime) / 16;
    const xCar = ticks / 250;
    return (
      <div
        style={{
          width: this.state.window.width,
          height: this.state.window.height,
          backgroundColor: "#000013",
          color: "#FFF",
          position: "relative"
        }}
      >
        <Banner />
        <Game size={minWH} lat={30} lng={(ticks / 300) * 40}>
          <Moebius />
          <Car x={xCar} y={this.state.car.y} z={this.state.car.z} />
          <Obstacle x={0} y={0} z={1} />
          <Obstacle x={0} y={0} z={1} />
        </Game>
      </div>
    );
  }

  componentDidMount() {
    this.resize();
    window.addEventListener("resize", this.resize.bind(this));
    document.addEventListener("keydown", this.handleKeyDown.bind(this));
    const tick = () => {
      window.requestAnimationFrame(() => {
        this.setState(
          p => ({
            currentTime: new Date().getTime(),
            ...this.animatePositions()
          }),
          () => {
            tick();
          }
        );
      });
    };
    tick();
  }

  animatePositions() {
    const newCar = { ...this.state.car };
    if (newCar.y < newCar.yTarget - 0.001) {
      newCar.y += 0.025;
    } else if (newCar.y > newCar.yTarget + 0.001) {
      newCar.y -= 0.025;
    }
    if (newCar.z < newCar.zTarget - 0.001) {
      newCar.z += 0.05;
    } else if (newCar.z > newCar.zTarget + 0.001) {
      newCar.z -= 0.05;
    }
    return { car: newCar };
  }

  resize() {
    const width = document.body.clientWidth;
    const height = document.body.clientHeight;
    const minWH = Math.min(width, height);
    this.setState(p => ({ window: { width, height } }));
  }

  handleKeyDown(e) {
    if (!this.state.acceptKeys) {
      return;
    }
    const newCar = { ...this.state.car };
    const stateChanges = {};
    stateChanges.acceptKeys = false;
    setTimeout(() => {
      this.setState(p => ({
        acceptKeys: true
      }));
    }, 100);
    const keyCode = e.keyCode;
    if (keyCode === 39) {
      newCar.yTarget = Math.max(newCar.yTarget - 0.5, -1);
    } else if (keyCode === 37) {
      newCar.yTarget = Math.min(newCar.yTarget + 0.5, 1);
    } else if (keyCode === 40) {
      newCar.zTarget = -newCar.zTarget;
    }
    stateChanges.car = newCar;
    this.setState(p => stateChanges);
  }
}
