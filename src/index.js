var Elm = require('./Main');
var domReady = require('domready');

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
require('./images/github.svg');
require('./images/linkedin.svg');
require('./images/twitter.svg');
require('./images/peter-szerzo-180-2x.jpg');

domReady(function() {
  var elmApp = Elm.Main.embed(document.getElementById('app'));
});
