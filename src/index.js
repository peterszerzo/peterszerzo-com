require('./index.html');
require('./styles/main');

require('./Banner/style');
require('./DesktopNav/style');
require('./Main/style');
require('./MobileNav/style');
require('./Switch/style');
require('./TextBox/style');
require('./Notification/style');

require('./images/peter-szerzo-180-2x.jpg');
require('./images/ripple-2x.gif');

var attachFastClick = require('fastclick');
var domReady = require('domready');

var Elm = require('./Main');
var startElmApp = require('./start-elm-app');

domReady(function() {
  console.log('Hi, Mom!');
  attachFastClick.attach(document.body);
  startElmApp(window, Elm);
});
