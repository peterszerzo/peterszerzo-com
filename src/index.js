require('./index.html');
require('./styles/app');

require('./Banner/style');
require('./DesktopNav/style');
require('./Links/style');
require('./Nav/style');
require('./Main/style');
require('./MobileNav/style');
require('./Switch/style');
require('./TextBox/style');
require('./Notification/style');

require('./images/couchsurfing.svg');
require('./images/ripple.gif');
require('./images/github.svg');
require('./images/linkedin.svg');
require('./images/twitter.svg');
require('./images/peter-szerzo-180-2x.jpg');

var Elm = require('./Main');
var startApp = require('./start_app');
var attachFastClick = require('fastclick');
var domReady = require('domready');

domReady(function() {
  console.log('Hi, Mom!');
  attachFastClick.attach(document.body);
  startApp(Elm);
});
