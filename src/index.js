var Elm = require('./Main');
var domReady = require('domready');
var attachFastClick = require('fastclick');

require('./index.html');
require('./styles/app');

require('./Banner/style');
require('./DesktopNav/style');
require('./Links/style');
require('./Nav/style');
require('./Main/style');
require('./Switch/style');
require('./TextBox/style');

require('./images/couchsurfing.svg');
require('./images/ripple.gif');
require('./images/github.svg');
require('./images/linkedin.svg');
require('./images/twitter.svg');
require('./images/peter-szerzo-180-2x.jpg');

domReady(function() {
  attachFastClick.attach(document.body);
  var node = document.getElementById('app');
  setTimeout(function() {
    node.innerHTML = '';
    var elmApp = Elm.Main.embed(document.getElementById('app'));
  }, 0);
});
