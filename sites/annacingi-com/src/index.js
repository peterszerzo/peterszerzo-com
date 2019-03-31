import * as d3 from "d3-hierarchy"
const Elm = require("./Maddi.elm")

const startApp = node => {
  const elmApp = Elm.Elm.Maddi.init({ node })
}

startApp(document.getElementById("App"))
