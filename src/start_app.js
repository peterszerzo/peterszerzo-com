module.exports = function startApp(Elm) {
  var node = document.getElementById('app');
  setTimeout(function() {
    node.innerHTML = '';
    var elmApp = Elm.Main.embed(document.getElementById('app'));
  }, 0);
}
