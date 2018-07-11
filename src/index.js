import Elm from "./Site.elm"
import * as d3 from "d3-hierarchy"

const isDev = process.env.NODE_ENV === "development"
const LOCAL_STORAGE_KEY = "peterszerzo.com:notification-last-dismissed"

const startApp = (node) => {
  node.innerHTML = "" 
  const elmApp = Elm.Site.embed(node)
  elmApp.ports && elmApp.ports.packLayoutReq.subscribe(msg => {
    const pack = d3.pack()
      .size([msg.width, msg.height])
      .padding(msg.width > 600 ? 45 : 30)
    const nodes = {
      children: msg.sizes.map(size => ({
        name: "name",
        size: size
      })),
      name: "name"
    }
    const root = d3.hierarchy(nodes)
    root.sum(d => d.size)
    const rootNode = pack(root)
    const packedCoordinates = rootNode.children.map(child => ({
      x: child.x,
      y: child.y,
      r: child.r
    }))
    elmApp.ports.packLayoutRes.send(packedCoordinates)
  })
}

startApp(document.getElementById("App"))
