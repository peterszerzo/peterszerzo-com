require('./styles.compiled.css')
var attachFastClick = require('fastclick')
var domReady = require('domready')
var app = require('./App')

console.log('Hi, Mom!')
attachFastClick.attach(document.body)
app()
