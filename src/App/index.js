var Elm = require('./Main.elm')

var LOCAL_STORAGE_KEY = 'peterszerzo-com:notification-last-dismissed'

function getTimeSinceNotificationLastDismissed () {
  var now = new Date().getTime()
  if (!window.localStorage) {
    return now
  }
  var lastDismissedAt = Number(window.localStorage.getItem(LOCAL_STORAGE_KEY))
  if (isNaN(lastDismissedAt)) {
    return now
  }
  return now - lastDismissedAt
}

function setNotificationLastDismissed () {
  if (window.localStorage) {
    window.localStorage.setItem(
      LOCAL_STORAGE_KEY,
      String(new Date().getTime())
    )
  }
}

module.exports = function startApp () {
  var elmApp
  var node = document.getElementById('app')
  var isNotificationRecentlyDismissed = getTimeSinceNotificationLastDismissed() < 2 * 24 * 3600 * 1000
  window.requestAnimationFrame(function () {
    node.innerHTML = ''
    elmApp = Elm.Main.embed(node, isNotificationRecentlyDismissed)
    if (window.localStorage) {
      elmApp.ports.notificationDismissed.subscribe(setNotificationLastDismissed)
    }
  })
}
