import React from "react"
import Logo from "./Logo"

export default () => (
  <React.Fragment>
    <div
      style={{
        position: "absolute",
        opacity: 0.5,
        top: 20,
        left: 20,
        width: 60,
        height: 60
      }}
    >
      <Logo />
    </div>
    <div
      style={{
        color: "#FFF",
        opacity: 1,
        fontSize: 16,
        position: "absolute",
        lineHeight: 1.4,
        top: 28,
        left: 90
      }}
    >
      <strong>Twisty Donut Racer</strong>
      <br />
      <span style={{ opacity: 0.7 }}>Use arrow keys to steer and descend.</span>
    </div>
  </React.Fragment>
)
