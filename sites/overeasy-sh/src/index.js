import * as d3 from "d3-hierarchy"
const Elm = require("./OverEasy.elm")

const startApp = node => {
  const elmApp = Elm.Elm.OverEasy.init({ node })
}

startApp(document.getElementById("App"))
