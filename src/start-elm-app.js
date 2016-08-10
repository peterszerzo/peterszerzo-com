var LOCAL_STORAGE_KEY = 'peterszerzo-com:notification-last-dismissed';

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
  window.requestAnimationFrame(function() {
    node.innerHTML = '';
    elmApp = Elm.Main.embed(node, true);
    if (window.localStorage) {
      elmApp.ports.notificationDismissed.subscribe(setNotificationLastDismissed);
    }
  });
}
