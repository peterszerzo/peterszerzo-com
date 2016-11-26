require('./styles.css');
require('./images/peter-szerzo-180-2x.jpg');
require('./images/ripple-2x.gif');

var attachFastClick = require('fastclick');
var domReady = require('domready');
var app = require('./App');

domReady(function() {
  console.log('Hi, Mom!');
  attachFastClick.attach(document.body);
  app();
});
