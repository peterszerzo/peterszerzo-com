var Elm = require('./Main.elm')

var isDev = process.env.NODE_ENV === 'development'
var LOCAL_STORAGE_KEY = 'peterszerzo.com:notification-last-dismissed'

function notificationLastDismissedSince (localStorage) {
  var now = new Date().getTime()
  if (!localStorage) {
    return now
  }
  var lastDismissedAt = Number(localStorage.getItem(LOCAL_STORAGE_KEY))
  if (isNaN(lastDismissedAt)) {
    return now
  }
  return now - lastDismissedAt
}

function setNotificationLastDismissedSince (localStorage) {
  if (localStorage) {
    localStorage.setItem(
      LOCAL_STORAGE_KEY,
      String(new Date().getTime())
    )
  }
}

function startApp (node, localStorage) {
  var elmApp
  var isNotificationRecentlyDismissed = notificationLastDismissedSince(localStorage) < 2 * 24 * 3600 * 1000
  window.requestAnimationFrame(function () {
    node.innerHTML = ''
    elmApp = Elm.Main.embed(node, {
      isNotificationRecentlyDismissed: isNotificationRecentlyDismissed,
      isDev: isDev
    })
    if (localStorage) {
      elmApp.ports.notificationDismissed.subscribe(function () {
        setNotificationLastDismissedSince(localStorage)
      })
    }
  })
}

startApp(document.getElementById('App'), localStorage)
