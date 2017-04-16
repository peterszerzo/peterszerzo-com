var attachFastClick = require('fastclick')

console.log('Hi, Mom!')
attachFastClick.attach(global.document.body)

var Elm = require('./Main.elm')

var LOCAL_STORAGE_KEY = 'peterszerzo-com:notification-last-dismissed'

function notificationLastDismissedFor (localStorage) {
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

function setNotificationLastDismissed (localStorage) {
  if (localStorage) {
    localStorage.setItem(
      LOCAL_STORAGE_KEY,
      String(new Date().getTime())
    )
  }
}

function startApp (node, localStorage) {
  var elmApp
  var isNotificationRecentlyDismissed = notificationLastDismissedFor(localStorage) < 2 * 24 * 3600 * 1000
  window.requestAnimationFrame(function () {
    node.innerHTML = ''
    elmApp = Elm.Main.embed(node, isNotificationRecentlyDismissed)
    if (localStorage) {
      elmApp.ports.notificationDismissed.subscribe(setNotificationLastDismissed)
    }
  })
}

startApp(document.getElementById('app'), global.localStorage)
