var Elm = require('./Main');
var domReady = require('domready');

require('./index.html');
require('./styles/app');
require('./images/couchsurfing.svg');
require('./images/github.svg');
require('./images/linkedin.svg');
require('./images/twitter.svg');
require('./images/logo.svg');

domReady(function() {
  var elmApp = Elm.Main.embed(document.getElementById('app'));
});
