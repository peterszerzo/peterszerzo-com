const fs = require("fs")
const path = require("path")

const pieces = fs.readdirSync(path.join(__dirname, "../Pieces"))
  .filter(fileOrFolder => fileOrFolder.slice(-4) === ".elm")
  .map(file => file.slice(0, -4))

const boilerplate = `
module OverEasy.Pieces exposing (..)

import UrlParser exposing (..)
import Html

${pieces.map(piece => `import OverEasy.Pieces.${piece} as ${piece}`).join("\n")}
`

console.log(boilerplate)
