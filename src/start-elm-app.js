module.exports = function startApp(window, Elm) {
  var node = window.document.getElementById('app');
  window.requestAnimationFrame(function() {
    node.innerHTML = '';
    Elm.Main.embed(node);
  });
}
