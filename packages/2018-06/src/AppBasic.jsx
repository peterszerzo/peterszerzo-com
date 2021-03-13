import React from "react"
import { Game, Moebius, Car, Obstacle } from "./Engine"

export default class App extends React.Component {
  render() {
    return (
      <div style={{ width: "100vw", height: "100vh", backgroundColor: "#000" }}>
        <Game size={600} lat={20} lng={20}>
          <Moebius />
          <Car x={0.6} y={0} z={1} />
          <Obstacle x={0} y={0} z={1} />
          <Obstacle x={0} y={0} z={1} />
        </Game>
      </div>
    )
  }
}
