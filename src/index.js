import Elm from "./Main.elm"
import * as d3 from "d3-hierarchy"

const isDev = process.env.NODE_ENV === "development"
const LOCAL_STORAGE_KEY = "peterszerzo.com:notification-last-dismissed"

const notificationLastDismissedSince = localStorage => {
  const now = new Date().getTime()
  if (!localStorage) {
    return now
  }
  const lastDismissedAt = Number(localStorage.getItem(LOCAL_STORAGE_KEY))
  if (isNaN(lastDismissedAt)) {
    return now
  }
  return now - lastDismissedAt
}

const setNotificationLastDismissedSince = localStorage => {
  if (localStorage) {
    localStorage.setItem(
      LOCAL_STORAGE_KEY,
      String(new Date().getTime())
    )
  }
}

const startApp = (node, localStorage) => {
  const isNotificationRecentlyDismissed = notificationLastDismissedSince(localStorage) < 2 * 24 * 3600 * 1000
  node.innerHTML = "" 
  const elmApp = Elm.Main.embed(node, {
    isNotificationRecentlyDismissed: isNotificationRecentlyDismissed,
    isDev: isDev
  })
  elmApp.ports.packLayoutReq.subscribe(msg => {
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
  if (localStorage) {
    elmApp.ports.notificationDismissed.subscribe(() => {
      setNotificationLastDismissedSince(localStorage)
    })
  }
}

startApp(document.getElementById("App"), localStorage)
