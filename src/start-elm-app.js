var LOCAL_STORAGE_KEY = 'peterszerzo-com:notification-last-dismissed';

function getTimeSinceNotificationLastDismissed() {
  var localStorageItem;
  var lastDismissedAt = window.localStorage
    ?
    (window.localStorage.getItem(LOCAL_STORAGE_KEY) ? Number(window.localStorage.getItem(LOCAL_STORAGE_KEY)) : 0)
    : 0;
  var now = new Date().getTime();
  return now - lastDismissedAt;
}

function setNotificationLastDismissed() {
  if (window.localStorage) {
    window.localStorage.setItem(
      LOCAL_STORAGE_KEY,
      String(new Date().getTime())
    );
  }
}

module.exports = function startApp(window, Elm) {
  var elmApp;
  var node = window.document.getElementById('app');
  var isNotificationRecentlyDismissed = getTimeSinceNotificationLastDismissed() < 2 * 24 * 3600 * 1000;
  window.requestAnimationFrame(function() {
    node.innerHTML = '';
    elmApp = Elm.Main.embed(node, isNotificationRecentlyDismissed);
    if (window.localStorage) {
      elmApp.ports.notificationDismissed.subscribe(setNotificationLastDismissed);
    }
  });
}
